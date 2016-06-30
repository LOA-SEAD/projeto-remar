package br.ufscar.sead.loa.remar

import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import org.springframework.http.HttpMethod

import java.lang.reflect.Method

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

    enum HttpMethod{get,post,put,delete}

    private void init() {
        if (initialized) {
            return
        }
        restUrl = grailsApplication.config.dspace.restUrl
        mainCommunityId = grailsApplication.config.dspace.mainCommunityId
        email = grailsApplication.config.dspace.email
        password = grailsApplication.config.dspace.password
        rest = null
        token = null

        initialized = true
    }

    /**
     * Procura nos bitstreams, quais são pertencentes ao json (olhando o parentObject e comparando com o id do json)
     *  , e add o link da imagem no json (cria novo elemento). Geralmente o json será uma comunidade ou uma coleção
     * @params objeto restBuilder e json
     * */
    def concatBitstreamsWithRetrieveLink(json){

        def resp = rest.get("${restUrl}/bitstreams?expand=parent")
        def bitstreams = resp.json

        json.each { sub ->
            def retLink = (bitstreams.find { it.parentObject.id == sub.id }).retrieveLink
            sub.retrieveLink = retLink
        }

        return json
    }

    /**
     * Realiza o login no Dspace, inicializando as variaveis
     * @params email e string
     * @return uma string token
     * */
    def login(String e = null,String p = null) throws RuntimeException{

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
    def logout() throws RuntimeException{
        if(token != null){
            rest.post("${restUrl}/logout"){
                contentType "application/json"
                header 'rest-dspace-token', this.token
            }
        }else{
            throw new RuntimeException('Error in logout: attribute token is null')
        }
    }

    /**
     * pesquisa pela comunidade principal no dpsace do remar
     * @return json da comunidade principal
     * */
    def getMainCommunity() throws RuntimeException{
        login()
        def resp = rest.get("${restUrl}/communities/${mainCommunityId}")
        logout()

        return resp.json
    }

    /**
     * pesquisa pelas subcomunidades de uma comunidade no dpsace
     * caso nao seja fornecido nenhum valor ao método é pesquisado pela
     * subcomunidades na comunidade pricipal
     * @return json da comunidade principal
     * */
    def listSubCommunities(communityId) throws RuntimeException{
        if(communityId){
            if(communityId >=0){
                login()
                def resp = rest.get("${restUrl}/communities/${communityId}/communities")
                logout()
                return resp.json
            }else{
                throw new RuntimeException("Error in listSubCommunities: communityId has value less than zero")
            }
        }else{
            login()
            def resp = rest.get("${restUrl}/communities/${mainCommunityId}/communities")
            logout()
            return resp.json
        }
    }

    def listSubCommunitiesExpanded(communityId) throws RuntimeException{
        if(communityId){
            if(communityId >=0){
                login()
                def resp = rest.get("${restUrl}/communities/${communityId}/communities")
                logout()
                return resp.json
            }else{
                throw new RuntimeException("Error in listSubCommunities: communityId has value less than zero")
            }
        }else{
            login()
            def resp = rest.get("${restUrl}/communities/${mainCommunityId}/communities")
            logout()
            return resp.json
        }
    }

}
