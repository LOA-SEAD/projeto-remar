package br.ufscar.sead.loa.remar

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.plugins.rest.client.RestBuilder

@Secured('IS_AUTHENTICATED_ANONYMOUSLY')
class DspaceController {
    def grailsApplication

    static allowedMethods = [bitstream: "GET"]

    static scope = "prototype"

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

        init()

        def l  = login(email,password)
        def token = l.token
        def rest =  l.restBuilder
        def  communities,subCommunities, collections, items, bitstreams, reports
        def resp

        //get community remar
        resp = rest.get("${restUrl}/communities/${mainCommunityId}")
        communities = resp.json

        //get sub-communities in remar
        resp = rest.get("${restUrl}/communities/${mainCommunityId}/communities")
        subCommunities = resp.json

        subCommunities = catBitstreamsRetrieveLink(rest, subCommunities)

        logout(token,rest)

        render view: 'index', model:[
                communities:communities,
                subCommunities:subCommunities,
                restUrl: restUrl
        ]
    }

    def listCollections(){
        init()

        def l  = login(email,password)
        def token = l.token
        def rest =  l.restBuilder
        def collections
        def resp

        //def id = searchName(subCommunities,"forca")
        resp = rest.get("${restUrl}/communities/${params.id}/collections")
        collections = resp.json

        collections = catBitstreamsRetrieveLink(rest, collections)

        logout(token,rest)

        render view: 'listCollections', model:[
                collections:collections,
                communityName: params.names,
                restUrl: restUrl
        ]
    }

    def listItems(){
        init()

        def l  = login(email,password)
        def token = l.token
        def rest =  l.restBuilder
        def items, metadata, bitstreams
        def resp

        println(request.getRequestURL())

        resp = rest.get("${restUrl}/collections/${params.id}/items?expand=all")
        items = resp.json
        metadata = items.metadata
        bitstreams = items.bitstreams

        logout(token,rest)

        render view: 'listItems', model:[
                items: items,
                metadata: metadata,
                bitstreams: bitstreams,
                communityName: params.names.getAt(0),
                collectionsName: params.names.getAt(1),
                restUrl: restUrl
        ]
    }

    def bitstream(){
        init()

        def l  = login(email,password)
        def token = l.token
        def rest =  l.restBuilder
        def resp

        resp = rest.get("${restUrl}/bitstreams/${params.id}")

        logout(token,rest)

        render view: "_modalBody", model: [bitstream: resp.json, restUrl: restUrl]
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


    private static searchName(json, name){
        for (j in json){
            if(j.name == name)
                return j.id
        }
        return null
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
}
