package br.ufscar.sead.loa.remar

import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import groovy.json.JsonBuilder
import org.springframework.http.HttpMethod

import javax.annotation.PostConstruct
import java.lang.reflect.Method

@Transactional
class DspaceRestService {

    def grailsApplication

    private boolean initialized;

    //variable for dpsace's controller
    private String restUrl;
    private String mainCommunityId
    private String email
    private String password
    private String jspuiUrl

    private RestBuilder rest
    private String token

    boolean getInitialized() {
        return initialized
    }

    void setInitialized(boolean initialized) {
        this.initialized = initialized
    }

    String getRestUrl() {
        return restUrl
    }

    void setRestUrl(String restUrl) {
        this.restUrl = restUrl
    }

    String getMainCommunityId() {
        return mainCommunityId
    }

    void setMainCommunityId(String mainCommunityId) {
        this.mainCommunityId = mainCommunityId
    }

    String getEmail() {
        return email
    }

    void setEmail(String email) {
        this.email = email
    }

    String getPassword() {
        return password
    }

    void setPassword(String password) {
        this.password = password
    }

    String getToken() {
        return token
    }

    void setToken(String token) {
        this.token = token
    }

    String getJspuiUrl() {
        return jspuiUrl
    }

    void setJspuiUrl(String jspuiUrl) {
        this.jspuiUrl = jspuiUrl
    }

    /**
     * Inicia as variáveis de controle do dspace baseado com os dados do arquivo env-dspace toda vez que o objeto é instanciado
     * Se a inicialização já foi realizada retorna
     * */
    @PostConstruct
    private void init() {
        if (this.initialized) {
            return
        }
        this.restUrl = grailsApplication.config.dspace.restUrl
        this.jspuiUrl = grailsApplication.config.dspace.jspuiUrl
        this.mainCommunityId = grailsApplication.config.dspace.mainCommunityId
        this.email = grailsApplication.config.dspace.email
        this.password = grailsApplication.config.dspace.password
        this.rest = null
        this.token = null

        this.initialized = true
    }

    /**
     * Procura nos bitstreams, quais são pertencentes ao json  (olhando o parentObject e comparando com o id do json)
     *  e add o link da imagem no json (cria novo elemento chamada retrieveLink). Geralmente o json será uma comunidade ou uma coleção
     * @params objeto restBuilder e json
     * */
    def concatBitstreamsWithRetrieveLink(json, String parentObject_type){

        def resp = this.rest.get("${this.restUrl}/bitstreams?expand=parent")
        def bitstreams = resp.json

        json.each { sub ->
            try{

                def retLink = (bitstreams.find { it.parentObject.id == sub.id && it.parentObject.type == parentObject_type }).retrieveLink
                sub.retrieveLink = retLink
            }catch (Exception e){
                sub.retrieveLink =  null
            }
        }

        return json
    }

    /**
     * Realiza o login no Dspace, inicializando as variaveis
     * @params email e string
     * @return uma string token
     * */
    def login(String e = null,String p = null) throws RuntimeException{

        this.rest = new RestBuilder(connectTimeout:1000, readTimeout:20000)

        if(e != null && p != null){
            this.email = e
            this.password = p
        }

        def resp = rest.post("${restUrl}/login"){
            contentType "application/json"
            json {
                email = this.email
                password = this.password
            }
        }
        this.token = resp.body.toString()
        return [token: token] //return token
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
            this.token = null
        }else{
            throw new RuntimeException('Error in logout: attribute token is null')
        }
    }

    /**
     * Pesquisa pela comunidade principal no dpsace do remar
     * @return json da comunidade principal
     * */
    def getMainCommunity() throws RuntimeException{
        login()
        def resp = rest.get("${this.restUrl}/communities/${this.mainCommunityId}")
        logout()

        return resp.json
    }

    /**
     * Pesquisa pela comunidade principal no dpsace do remar
     * @return json da comunidade principal
     * */
    def getBitstream(bitstreamId) throws RuntimeException{
        if(Integer.parseInt(bitstreamId.toString()) > 0){
            login()
            def resp = rest.get("${this.restUrl}/bitstreams/${bitstreamId.toString()}")
            logout()
            return resp.json
        }else{
            throw new RuntimeException("Error in getBitstream: bitstreamId has value less than zero")
        }
    }

    /**
     * Pesquisa pelas subcomunidades de uma comunidade no dpsace
     * caso nao seja fornecido nenhum valor ao método é pesquisado pela
     * subcomunidades na comunidade pricipal.
     * @return json com as subcategorias
     * */
    def listSubCommunities(communityId = null) throws RuntimeException{
        if(communityId){
            if(Integer.parseInt(communityId.toString()) >=0){
                login()
                def resp = this.rest.get("${this.restUrl}/communities/${communityId}/communities")
                logout()
                return resp.json
            }else{
                throw new RuntimeException("Error in listSubCommunities: communityId has value less than zero")
            }
        }else{
            login()
            def resp = this.rest.get("${this.restUrl}/communities/${this.mainCommunityId}/communities")
            logout()
            return resp.json
        }
    }

    /**
     * Pesquisa pelas subcomunidades de uma comunidade no dpsace fazendo a concatenação da mesma
     * com o retrieveLink.
     * Caso nao seja fornecido nenhum valor ao método é pesquisado pela
     * subcomunidades na comunidade pricipal.
     * @return json com as subcategorias
     * */
    def listSubCommunitiesExpanded(communityId = null) throws RuntimeException{
        if(communityId){
            if(Integer.parseInt(communityId.toString()) >=0){
                login()
                def resp = this.rest.get("${this.restUrl}/communities/${communityId}/communities")
                logout()
                return concatBitstreamsWithRetrieveLink(resp.json,"community")
            }else{
                throw new RuntimeException("Error in listSubCommunitiesExpanded: communityId has value less than zero")
            }
        }else{
            login()
            def resp = this.rest.get("${this.restUrl}/communities/${this.mainCommunityId}/communities")
            logout()
            return concatBitstreamsWithRetrieveLink(resp.json,"community")
        }
    }


    /**
     * Pesquisa pelas coleções de uma comunidade no dpsace fazendo a concatenação da mesma
     * com o retrieveLink.
     * Caso nao seja fornecido nenhum valor ao método é pesquisado pelas
     * coleções da comunidade pricipal.
     * @return json com as coleções
     * */
    def listCollectionsExpanded(communityId = null) throws RuntimeException{
        if(communityId){
            if(Integer.parseInt(communityId.toString()) >=0){
                login()
                def resp = this.rest.get("${this.restUrl}/communities/${communityId}/collections")
                logout()
                return concatBitstreamsWithRetrieveLink(resp.json, "collection")
            }else{
                throw new RuntimeException("Error in listCollectionsExpanded: communityId has value less than zero")
            }
        }else{ //lista as coleções da communityId, caso ela possua
            login()
            def resp = this.rest.get("${this.restUrl}/communities/${this.mainCommunityId}/collections")
            logout()
            return concatBitstreamsWithRetrieveLink(resp.json, "collection")
        }
    }

    /**
     * Pesquisa pelas subcomunidades de uma comunidade no dpsace
     * caso nao seja fornecido nenhum valor ao método é pesquisado pela
     * subcomunidades na comunidade pricipal.
     * @return json com as subcategorias
     * */
    def listItems(collectionId) throws RuntimeException{
        if(collectionId){
            if(Integer.parseInt(collectionId.toString()) >=0){
                login()
                def resp = this.rest.get("${this.restUrl}/collections/${collectionId}/items?expand=all")
                logout()
                return resp.json
            }else{
                throw new RuntimeException("Error in listItems: collectionId has value less than zero")
            }
        }
    }

    /**
     * Adiciona um bitstream a um item. Espera o id do item, um arquivo (bitstream) desejado,
     * o nome do arquivo e  uma descrição (opcional)
     * @return o corpo na resp, normalmente em json do bitstream submetido
     * */
    def addBitstreamToItem(itemId, file, name, description=null){
        if(Integer.parseInt(itemId.toString())>0){
            if(file){
                login()
                def resp = this.rest.post("${this.restUrl}/items/${itemId}/bitstreams?name=${name}&description=${description}"){
                                header 'rest-dspace-token', token
                                body file.bytes
                            }
                logout()
                return resp.body
            }else{
                throw new RuntimeException("Error in addBitstreamToItem: file was not specified")
            }
        }else{
            throw new RuntimeException("Error in addBitstreamToItem: itemId has value less than zero")
        }
    }

    /**
     * Deleta o bitstream de um item.
     * @params id do item e id do bitstream pertencente ao item
     * @return o corpo na resp, normalmente um json do bitstream deletado
     * */
    def deleteBitstreamOfItem(itemId,bitstreamId){
        if(Integer.parseInt(itemId.toString())>0){
            if(Integer.parseInt(bitstreamId.toString())>0){
                login()
                def resp = this.rest.delete("${this.restUrl}/items/${itemId}/bitstreams/${bitstreamId}"){
                                header 'rest-dspace-token', token
                            }
                logout()
                return resp.body
            }else{
                throw new RuntimeException("Error in deleteBitstreamOfItem: bitstreamId has value less than zero")
            }
        }else{
            throw new RuntimeException("Error in deleteBitstreamOfItem: itemId has value less than zero")
        }
    }


    /**
     * Cria uma nova subcomunidade na comunidade especificada ou caso ela não seja especificada,
     * na comunidade principal (mainCommunity). O formato do metadados deve ser:
     * {
     *       "name":"CREATED BY JSON (POST)",
     *       "copyrightText":"CREATED BY JSON (POST)",
     *       "introductoryText":"CREATED BY JSON (POST)",
     *       "shortDescription":"CREATED BY JSON (POST)",
     *       "shortDescription":"CREATED BY JSON (POST)",
     *       "sidebarText":"CREATED BY JSON (POST)"
     *    }
     * @params id da comunidade (opcional) e arquivo json de metadados
     * @return o corpo na resp, normalmente um json da subcomunidade criada
     * */
    def newSubCommunity(metadata,file){
        def communityId=null
        if(!communityId){
            communityId = this.mainCommunityId
        }

        println("community Id: "+communityId)

        if(Integer.parseInt(communityId.toString())>0){
            if(metadata){
                login()
                println(this.token)
                def resp = this.rest.post("${this.restUrl}/communities/${communityId}/communities"){
                    header 'rest-dspace-token', this.token
                    json metadata
                }
//                body file.bytes

                logout()
                println(resp.body)

                return resp.body
            }else{
                throw new RuntimeException("Error in newCommunity: metadata was not specified")
            }
        }else{
            throw new RuntimeException("Error in newCommunity: communityId has value less than zero")
        }
    }

    /**
     * Cria um novo item na coleção especificada. O formato do metadados deve ser:
     * {"metadata":[
     *    {
     *       "key": "dc.contributor.author",
     *       "value": "LAST, FIRST"
     *    },
     *    {
     *       "key": "dc.description",
     *       "language": "pt_BR",
     *       "value": "DESCRICAO"
     *    },
     *    {
     *       "key": "dc.description.abstract",
     *       "language": "pt_BR",
     *       "value": "ABSTRACT"
     *    },
     *    {
     *      "key": "dc.title",
     *      "language": "pt_BR",
     *      "value": "TESTE 1"
     *    }
     *    ]}
     * @params id da coleção e arquivo json de metadados
     * @return o corpo na resp, normalmente um json do item criado
     * */
    def newItem(collectionId, metadata){
        if(!collectionId){
            throw new RuntimeException("Error in newItem: collectionId was not specified")
        }else{
            if(Integer.parseInt(collectionId.toString())>0){
                if(metadata){
                    login()
                    def resp = this.rest.post("${this.restUrl}/collections/${collectionId}/items"){
                        header 'rest-dspace-token', this.token
                        json metadata
                    }
                    logout()
                    println(resp.body)
                    return resp.body
                }else{
                    throw new RuntimeException("Error in newCommunity: metadata was not specified")
                }
            }else{
                throw new RuntimeException("Error in newCommunity: communityId has value less than zero")
            }
        }



    }
}
