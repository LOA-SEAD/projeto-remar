package br.ufscar.sead.loa.remar

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder

class DspaceController {
    def grailsApplication

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

        //get collection on forca community
        def id = searchName(subCommunities,"forca")
        resp = rest.get("${restUrl}/communities/${id}/collections")
        collections = resp.json


        resp = rest.get("${restUrl}/items")
        items = resp.json

        resp = rest.get("${restUrl}/bitstreams")
        bitstreams = resp.json


        resp = rest.post("${restUrl}/items/find-by-metadata-field"){
            contentType "application/json"
            json {
                key= "dc.title"
                value= "Teste"
                language="en_US"
            }
        }
        reports = resp.body

       logout(token,rest)

        render view: 'index', model:[
                token:token,
                communities:communities,
                subCommunities:subCommunities,
                collections : collections,
                items:items,
                bitstreams:bitstreams,
                reports: reports
        ]
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

        print(resp.body)

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
}
