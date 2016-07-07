package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.propeller.Propeller
import grails.plugin.springsecurity.annotation.Secured
import grails.plugins.rest.client.RestBuilder

@Secured('IS_AUTHENTICATED_ANONYMOUSLY')
class DspaceController {
    def grailsApplication

    static allowedMethods = [bitstream: "GET"]
    static scope = "prototype"

    def dspaceRestService

    static boolean inited;
    static String restUrl;
    static String mainCommunityId
    static String email
    static String password

    def init() {
        if (inited) {
            return
        }
        restUrl = grailsApplication.config.dspace.restUrl
        mainCommunityId = grailsApplication.config.dspace.mainCommunityId
        email = grailsApplication.config.dspace.email
        password = grailsApplication.config.dspace.password
        inited = true
    }

    def index() {

        def community = dspaceRestService.getMainCommunity()

        def subCommunities = dspaceRestService.listSubCommunitiesExpanded()

        render view: 'index', model:[
                community:community,
                subCommunities:subCommunities,
                restUrl: dspaceRestService.getRestUrl(),
                jspuiUrl: dspaceRestService.getJspuiUrl()
        ]
    }

    def listCollections(){
        init()

        def collections = dspaceRestService.listCollectionsExpanded(params.id)

        render view: 'listCollections', model:[
                collections:collections,
                communityName: params.names,
                restUrl: restUrl
        ]
    }

    def listItems(){
        def items, metadata, bitstreams
        def oldUrl = "/dspace/listCollections/${params.old}?names=${params.names.getAt(0)}"

        items = dspaceRestService.listItems(params.id)
        metadata = items.metadata
        bitstreams = items.bitstreams

        render view: 'listItems', model:[
                                            items: items,
                                            metadata: metadata,
                                            bitstreams: bitstreams,
                                            communityName: params.names.getAt(0),
                                            collectionName: params.names.getAt(1),
                                            restUrl: restUrl,
                                            communityUrl: oldUrl ]
    }

    def bitstream(){

        def resp = dspaceRestService.getBitstream(Integer.parseInt(params.id.toString()))

        render view: "_modalBody", model: [bitstream: resp, restUrl: dspaceRestService.getRestUrl()]
    }

    def create() {

        init()
        def l = login(email, password)
        def token = l.token
        def rest = l.restBuilder
        def community = null

        print(params)


        def img = new File(servletContext.getRealPath("/images/respondasepuder-banner.png"))

        def resp = rest.post("${restUrl}/items/5/bitstreams?name=respondasepuder-banner.png&description=blablablalba"){
            header 'rest-dspace-token', token
            body img.bytes
        }

        logout(token,rest)

        render resp.body
    }

    def delete(){
        init()
        def l = login(email, password)
        def token = l.token
        def rest = l.restBuilder

        def resp = rest.delete("${restUrl}/items/5/bitstreams/${params.id}"){
            header 'rest-dspace-token', token
        }

        logout(token,rest)

        render resp.body

    }

    def show(){
        init()
        def l = login(email, password)
        def token = l.token
        def rest = l.restBuilder

        def resp = rest.get("${restUrl}/bitstreams/${params.id}")

        logout(token,rest)

        render view: "show", model: [dspaceUrl: restUrl, bitstream: resp.json]
    }

    def save(){
        def path = new File(servletContext.getRealPath("/images/dspace"))
        path.mkdirs()

        if (params.img != null) {
            log.debug("save image ${params.img}")

            def img1 = new File(servletContext.getRealPath("${params.img}"))
            img1.renameTo(new File(path, "img.png"))
        }
    }


    /**
     * Realiza o login no Dspace, necessita ter executado o init() anteriormente
     * @params email e string
     * @return um token e um objeto restBuilder
    * */
    private static login(String e,String p){

        def rest = new RestBuilder(connectTimeout:1000, readTimeout:20000)

        def resp = rest.post("${restUrl}/login"){
            contentType "application/json"
            json {
                email = e
                password = p
            }
        }

        return [token: resp.body.toString(), restBuilder:rest] //token
    }

    /**
     * Realiza o logout no Dspace, necessita ter executado o init() anteriormente
     * @params token e objeto restBuilder
     * */
    private static logout(String token, RestBuilder rest){
        rest.post("${restUrl}/logout"){
            contentType "application/json"
            header 'rest-dspace-token', token
        }
    }

    /**
     * Procura nos bitstreams, quais são pertencentes ao json (olhando o parentObject e comparando com o id do json)
     *  , e add o link da imagem no json (cria novo elemento). Geralmente o json será uma comunidade ou uma coleção
     * @params objeto restBuilder e json
     * */
    private static catBitstreamsRetrieveLink(RestBuilder rest, json){

        def resp = rest.get("${restUrl}/bitstreams?expand=parent")
        def bitstreams = resp.json

        json.each { sub ->
            def retLink = (bitstreams.find { it.parentObject.id == sub.id }).retrieveLink
            sub.retrieveLink = retLink
        }

        return json
    }

    private static getListBitstreams(RestBuilder rest){
        def resp = rest.get("${restUrl}/bitstreams?expand=parent")
        return resp.json
    }

    def overview(){
        def process = Propeller.instance.getProcessInstanceById(params.id, session.user.id as long)
        def tmpFolder = new File("${servletContext.getRealPath("/data/processes/${process.id}")}/tmp")
        def ant = new AntBuilder()
        tmpFolder.mkdirs()

        process.completedTasks.each { task ->
            def taskFolder = new File(tmpFolder,task.id as String)
            task.outputs.each {output ->
                ant.copy(
                        file: output.path,
                        tofile: "${taskFolder}/${output.definition.name}",
                        overwrite: true
                )
            }
        }

        render view: "overview", model: [process:process]
    }

    def updateOutputs() {
        /*
        *
        *
        * */
    }
}
