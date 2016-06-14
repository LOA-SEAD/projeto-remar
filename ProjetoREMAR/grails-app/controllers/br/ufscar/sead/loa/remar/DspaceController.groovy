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


//        def resp = rest.post("${restUrl}/communities/${mainCommunityId}/communities"){
//            contentType "application/json"
//            header 'rest-dspace-token', token
//            json {
//                name=pName
//                copyrightText= "CREATED BY JSON (POST)"
//                introductoryText= "CREATED BY JSON (POST)"
//                shortDescription= "CREATED BY JSON (POST)"
//                shortDescription= "CREATED BY JSON (POST)"
//                sidebarText= "CREATED BY JSON (POST)"
//            }
//        }

        def img = new File(servletContext.getRealPath("/images/architecture.png"))

        def resp = rest.post("${restUrl}/items/5/bitstreams?name=teste&description=blablablalba"){
            contentType "image/jpeg"
            header 'rest-dspace-token', token
            file = img
        }

        logout(token,rest)

//        render view: "create", model: [community:community]
        render resp.body
    }

    def delete(){
        init()
//        def l = login("delanobeder@yahoo.com.br", "asdfgasd")
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
