package br.ufscar.sead.loa.remar

import grails.converters.XML
import grails.plugins.rest.client.RestBuilder
import grails.transaction.Transactional
import groovy.json.JsonBuilder
import jdk.nashorn.internal.parser.JSONParser
import org.apache.xerces.parsers.XMLParser
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

    def listMetadata = [author: "dc.contributor.author",
                        title:  "dc.title",
                        abstract: "dc.description.abstract",
                        license: "dcterms.license",
                        publication_date: "dc.date.issued"
                        ]

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
        this.rest = new RestBuilder(connectTimeout:1000, readTimeout:20000)

    }

    /**
     * Procura nos bitstreams, quais são pertencentes ao json  (olhando o parentObject e comparando com o id do json)
     *  e add o link da imagem no json (cria novo elemento chamada retrieveLink). Geralmente o json será uma comunidade ou uma coleção
     * @params objeto restBuilder e json
     * */
    def concatBitstreamsWithRetrieveLink(json, String parentObject_type) throws RuntimeException{

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
    def login(String e = null,String p = null) throws SocketTimeoutException, RuntimeException{

        if(e != null && p != null){
            this.email = e
            this.password = p
        }

        try{
            def resp = rest.post("${restUrl}/login"){
                contentType "application/json"
                json {
                    email = this.email
                    password = this.password
                }
            }
            this.token = resp.body.toString()
            return [token: token] //return token

        }catch (SocketTimeoutException timeout){
            println("Timeout in Login - ${timeout.message}, ${timeout.cause}")
            throw timeout
        }
    }


    /**
     * Realiza o logout no Dspace
     * @params
     * */
    def logout() throws SocketTimeoutException, RuntimeException{
        if(token != null){
            try {
                rest.post("${restUrl}/logout") {
                    contentType "application/json"
                    header 'rest-dspace-token', this.token
                }
                this.token = null

            }catch (SocketTimeoutException timeout){
                println("Timeout in Logout - ${timeout.message}, ${timeout.cause}")
                throw timeout
            }

        }else{
            throw new RuntimeException('Error in logout: token is null')
        }
    }

    /**
     * Pesquisa pela comunidade principal no dpsace do remar
     * @return json da comunidade principal
     * */
    def getMainCommunity() throws SocketTimeoutException, RuntimeException{
        def resp = rest.get("${this.restUrl}/communities/${this.mainCommunityId}")
        return resp.json
    }

    /**
     * Pesquisa pela comunidade principal no dpsace do remar
     * @return json da comunidade principal
     * */
    def getBitstream(bitstreamId) throws SocketTimeoutException, RuntimeException{
        if(Integer.parseInt(bitstreamId.toString()) > 0){
            def resp = rest.get("${this.restUrl}/bitstreams/${bitstreamId.toString()}")
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
    def listSubCommunities(communityId = null) throws SocketTimeoutException, RuntimeException{
        if(communityId){
            if(Integer.parseInt(communityId.toString()) >=0){
                def resp = this.rest.get("${this.restUrl}/communities/${communityId}/communities")
                return resp.json
            }else{
                throw new RuntimeException("Error in listSubCommunities: communityId has value less than zero")
            }
        }else{
            def resp = this.rest.get("${this.restUrl}/communities/${this.mainCommunityId}/communities")
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
    def listSubCommunitiesExpanded(communityId = null) throws SocketTimeoutException, RuntimeException{
        if(communityId){
            if(Integer.parseInt(communityId.toString()) >=0){
                def resp = this.rest.get("${this.restUrl}/communities/${communityId}/communities")
                return concatBitstreamsWithRetrieveLink(resp.json,"community")
            }else{
                throw new RuntimeException("Error in listSubCommunitiesExpanded: communityId has value less than zero")
            }
        }else{
            def resp = this.rest.get("${this.restUrl}/communities/${this.mainCommunityId}/communities")
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
    def listCollectionsExpanded(communityId = null) throws SocketTimeoutException, RuntimeException{
        if(communityId){
            if(Integer.parseInt(communityId.toString()) >=0){
                def resp = this.rest.get("${this.restUrl}/communities/${communityId}/collections")
                return concatBitstreamsWithRetrieveLink(resp.json, "collection")
            }else{
                throw new RuntimeException("Error in listCollectionsExpanded: communityId has value less than zero")
            }
        }else{ //lista as coleções da communityId, caso ela possua
            def resp = this.rest.get("${this.restUrl}/communities/${this.mainCommunityId}/collections")
            return concatBitstreamsWithRetrieveLink(resp.json, "collection")
        }
    }

    /**
     * Pesquisa pelas subcomunidades de uma comunidade no dpsace
     * caso nao seja fornecido nenhum valor ao método é pesquisado pela
     * subcomunidades na comunidade pricipal.
     * @return json com as subcategorias
     * */
    def listItems(collectionId) throws SocketTimeoutException, RuntimeException{
        if(collectionId){
            if(Integer.parseInt(collectionId.toString()) >=0){
                def resp = this.rest.get("${this.restUrl}/collections/${collectionId}/items?expand=all")
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
    def addBitstreamToItem(itemId, file, name, description=null) throws SocketTimeoutException, RuntimeException{
        if(Integer.parseInt(itemId.toString())>0){
            if(file){
                try{

                    login()
                    def resp = this.rest.post("${this.restUrl}/items/${itemId}/bitstreams?name=${name}&description=${description}"){
                        header 'rest-dspace-token', token
                        body file.bytes
                    }
                    logout()
                    return resp.body

                }catch (SocketTimeoutException timeout){
                    println("Timeout in addBitstreamToItem - ${timeout.message}, ${timeout.cause}")
                    throw timeout
                }

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
    def deleteBitstreamOfItem(itemId,bitstreamId) throws SocketTimeoutException, RuntimeException{
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
     * Deleta uma comunidade do Dspace
     * @params id da comunidade
     * @return ---
     * */
    def deleteCommunity(communityId) throws SocketTimeoutException, RuntimeException{

        if(Integer.parseInt(communityId.toString())>0){
            login()
            def resp = this.rest.delete("${this.restUrl}/communities/${communityId}"){
                header 'rest-dspace-token', token
            }
            logout()
            return resp.body
        }else{
            throw new RuntimeException("Error in deleteCommunity: communityId has value less than zero")
        }
    }

    /**
     * Deleta uma coleção do dspace
     * @params id da coleção
     * @return ---
     * */
    def deleteCollection(collectionId) throws SocketTimeoutException, RuntimeException{

        if(Integer.parseInt(collectionId.toString())>0){
            login()
            def resp = this.rest.delete("${this.restUrl}/collections/${collectionId}"){
                header 'rest-dspace-token', token
            }
            logout()
            return resp.body
        }else{
            throw new RuntimeException("Error in deleteCollection: collectionId has value less than zero")
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
     * @return o id da sub-comunidade criada
     * */
    def newSubCommunity(communityId, Map metadata) throws SocketTimeoutException, RuntimeException{
        if(!communityId){
            communityId = this.mainCommunityId
        }

        println("community Id: "+communityId)

        if(Integer.parseInt(communityId.toString())>0){
            if(metadata){
                try{
                    login()
                    if(this.token != null){

                        def resp = this.rest.post("${this.restUrl}/communities/${communityId}/communities"){
                            header 'rest-dspace-token', this.token
                            json metadata
                        }

                        logout()

                        println(resp.body)
                        def list = resp.body as String
                        def subCommunityId = list.substring(list.indexOf("<id>")+4, list.indexOf("</id>"))
                        return subCommunityId

                    }else{
                        throw new NullPointerException("Error in newSubCommunity: token is null")
                    }
                }catch (SocketTimeoutException timeout){
                    println("Timeout in newSubCommunity - ${timeout.message}, ${timeout.cause}")
                    throw timeout
                }

            }else{
                throw new RuntimeException("Error in newSubCommunity: metadata was not specified")
            }
        }else{
            throw new RuntimeException("Error in newSubCommunity: communityId has value less than zero")
        }
    }

    /**
     * Cria uma nova coleção na comunidade especificada ou caso ela não seja especificada,
     * na comunidade principal (mainCommunity). O formato do metadados deve ser:
     * {
     *       "name":"CREATED BY JSON (POST)",
     *       "copyrightText":"CREATED BY JSON (POST)",
     *       "introductoryText":"CREATED BY JSON (POST)",
     *       "shortDescription":"CREATED BY JSON (POST)",
     *       "sidebarText":"CREATED BY JSON (POST)"
     *    }
     * @params id da comunidade (opcional) e arquivo json de metadados
     * @return o id da coleção criada
     * */
    def newCollection(communityId,Map metadata) throws SocketTimeoutException, RuntimeException{
        if(!communityId){
            communityId = this.mainCommunityId
        }

        println("community Id: "+communityId)

        if(Integer.parseInt(communityId.toString())>0){
            if(metadata){
                try{

                    login()
                    if(this.token != null){

                        def resp = this.rest.post("${this.restUrl}/communities/${communityId}/collections"){
                            header 'rest-dspace-token', this.token
                            json metadata
                        }
                        logout()

                        println(resp.body)
                        def list = resp.body as String
                        def collectionId = list.substring(list.indexOf("<id>")+4, list.indexOf("</id>"))
                        return collectionId
                    }else{
                        throw new RuntimeException("Error in newCollection: token is null")
                    }

                }catch (SocketTimeoutException timeout){
                    println("Timeout in newColletion - ${timeout.message}, ${timeout.cause}")
                    throw timeout
                }
            }else{
                throw new RuntimeException("Error in newCollection: metadata was not specified")
            }
        }else{
            throw new RuntimeException("Error in newCollection: communityId has value less than zero")
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
     * @return o id do item criado
     * */
    def newItem(collectionId, metadata) throws SocketTimeoutException, RuntimeException{
        if(!collectionId){
            throw new RuntimeException("Error in newItem: collectionId was not specified")
        }else{
            if(Integer.parseInt(collectionId.toString())>0){
                if(metadata){
                    try{

                        login()
                        def resp = this.rest.post("${this.restUrl}/collections/${collectionId}/items"){
                            header 'rest-dspace-token', this.token
                            json metadata
                        }
                        logout()
                        def list = resp.body as String
                        def itemId = list.substring(list.indexOf("<id>")+4, list.indexOf("</id>"))
                        return itemId

                    }catch (SocketTimeoutException timeout){
                        println("Timeout in newItem - ${timeout.message}, ${timeout.cause}")
                        throw timeout
                    }
                }else{
                    throw new RuntimeException("Error in newCommunity: metadata was not specified")
                }
            }else{
                throw new RuntimeException("Error in newCommunity: communityId has value less than zero")
            }
        }
    }


}
