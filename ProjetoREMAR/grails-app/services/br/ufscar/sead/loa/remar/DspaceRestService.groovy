package br.ufscar.sead.loa.remar

import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional

@Transactional
class DspaceRestService {

    static scope = 'prototype'
    def grailsApplication

    private boolean initialized;

    //variable for dpsace's controller
    private String restUrl;
    private String mainCommunityId
    private String email
    private String password

    private RestBuilder rest
    private String token

    private void init() {
        if (initialized) {
            return
        }
        restUrl = grailsApplication.config.dspace.restUrl
        mainCommunityId = grailsApplication.config.dspace.mainCommunityId
        email = grailsApplication.config.dspace.email
        password = grailsApplication.config.dspace.password

        initialized = true
    }

    /**
     * Realiza o login no Dspace, inicializando as variaveis
     * @params email e string
     * @return uma string token
     * */
    def login(String e = null,String p = null){

        rest = new RestBuilder(connectTimeout:1000, readTimeout:20000)

        if(e != null && p != null){
            init()
            this.email = e
            this.password = password
        }else{
            init()
        }

        def resp = rest.post("${restUrl}/login"){
            contentType "application/json"
            json {
                email = this.email
                password = this.password
            }
        }

        return [token: resp.body.toString()] //return token
    }


    /**
     * Realiza o logout no Dspace
     * @params
     * */
    def logout(){
        rest.post("${restUrl}/logout"){
            contentType "application/json"
            header 'rest-dspace-token', this.token
        }
    }


}
