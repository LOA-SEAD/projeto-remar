package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.propeller.Propeller
import grails.plugin.springsecurity.annotation.Secured
import groovy.io.FileType
import groovy.json.JsonBuilder
import com.mongodb.MongoClient
import com.mongodb.client.MongoDatabase;

@Secured('IS_AUTHENTICATED_ANONYMOUSLY')
class DspaceController {

    static allowedMethods = [bitstream: "GET"]
    static scope = "prototype"

    def dspaceRestService

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

        def collections = dspaceRestService.listCollectionsExpanded(params.id)

        render view: 'listCollections', model:[
                collections:collections,
                communityName: params.names,
                restUrl: dspaceRestService.getRestUrl()
        ]
    }

    def listItems(){
        def items, metadata, bitstreams

        //gerando url para os breadcrumbs
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
                                            restUrl: dspaceRestService.getRestUrl(),
                                            communityUrl: oldUrl ]
    }

    def bitstream(){

        def resp = dspaceRestService.getBitstream(params.id)

        render view: "_modalBody", model: [bitstream: resp, restUrl: dspaceRestService.getRestUrl()]
    }

    def create() {

        print(params)

        def img = new File(servletContext.getRealPath("/images/respondasepuder-banner.png"))
        def resp = dspaceRestService.addBitstreamToItem(params.id,img,"respodasepuder-banner.png", "blslballalba")

        render resp
    }

    def delete(){

        def resp = dspaceRestService.deleteBitstreamOfItem('5',params.id)

        render resp

    }

    def save(){
//        def path = new File(servletContext.getRealPath("/images/dspace"))
//        path.mkdirs()
//
//        if (params.img != null) {
//            log.debug("save image ${params.img}")
//
//            def img1 = new File(servletContext.getRealPath("${params.img}"))
//            img1.renameTo(new File(path, "img.png"))
//        }
    }

    def overview(){
        def process = Propeller.instance.getProcessInstanceById(params.id, session.user.id as long)
        def resource = Resource.get(process.getVariable('resourceId'))

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

        println(resource)
        process.definition.id

        render view: "overview", model: [process:process]
    }

    def listMetadata() {

        if(params.step=="0"){
            println(params)

            render view: 'listMetadata', model: [processId: params.processId, taskId:params.taskId, step: params.step]
        }
        else{
            println(params)
            if(params.step=="1")
            {
                def list = [];
                def dir = new File(servletContext.getRealPath("/data/processes/${params.processId}/tmp/${params.taskId}/"))
                dir.eachFileRecurse (FileType.FILES) {file ->
                    list << file
                }

                list.each {
                    println it.name
                }

                render view: '_bitMetadata', model: [bitstreams: list, abstractP: params.abstract, author: params.author, title: params.title, editor: params.editor, license: params.license, date: params.date, step: params.step]

            }
        }


    }


    def createCommunityTest(){
        def json = new JsonBuilder()
        def img = new File(servletContext.getRealPath("/images/respondasepuder-banner.png"))

        def m = json {
            "name" "game de teste"
            "copyrightText" "teste"
            "introductoryText" "teste"
            "shortDescription" "game para teste de criação de uma comunidade"
            "shortDescription" "CREATED BY JSON (POST)"
            "sidebarText" "CREATED BY JSON (POST)"
        }

        def r = dspaceRestService.newSubCommunity(m,img)

        render r
    }

    def createDspaceStructure(){
        //inserir no mongo os id da coleção e comunidades referentes ao resource submetido
        params.resource_id = 1

        def data = [:]
        def task = [:]
        def task2 = [:]
        def listTasks = []
        def r = Resource.findById(1)

        task.id = "5787da2c1b4f8b1bba0af8f6"
        task.name = "Tema"
        task.uri = "theme"
        task.collectionId = 1

        listTasks.add(task)

        task2.id = "5787da2c1b4f8b1bba0af8f5"
        task2.name = "Banco de Questões"
        task2.uri = "questions"
        task2.collectionId = 2

        listTasks.add(task2)

        data.id = r.id
        data.name = r.name
        data.uri = r.uri
        data.communityId = 2
        data.tasks = listTasks

        println(data)

        MongoHelper.instance.addCollection('resource_dspace')
        MongoHelper.instance.insertData('resource_dspace',data)

        render "<h1>teste</h1>"
    }

    // create/item
    def createItem(){
        println(params)

        def metadatas = [], list = [:]
        def m1 = [:],m2 = [:],m3 = [:], m4 = [:]

        def process = Propeller.instance.getProcessInstanceById(params.processId, session.user.id as long)
        def resource = Resource.get(process.getVariable('resourceId'))
        def current_task = Propeller.instance.getTaskInstance(params.taskId, session.user.id as long)

        m1.key = "dc.contributor.author"
        m1.value = "LAST, FIRST"
        metadatas.add(m1)

        m2.key = "dc.description"
        m2.language = "pt_BR"
        m2.value = "DESCRICAO"
        metadatas.add(m2)

        m3.key = "dc.description.abstract"
        m3.language = "pt_BR"
        m3.value = "RESUMO"
        metadatas.add(m3)

        m4.key = "dc.title"
        m4.language = "pt_BR"
        m4.value = "TESTE 1"
        metadatas.add(m4)

        list.metadata = metadatas

        if(Integer.parseInt(params.step) == 0){ // -> step era 0 e chegou como 1 create item
            def resource_dspace = MongoHelper.instance.getCollection("resource_dspace", resource.id)
            resource_dspace.collect{

                it.tasks.each{ task ->
                    if(task.id.toString() == current_task.definition.id.toString()){ //achei a coleção correta
                        println(task.collectionId)
                        def resp = dspaceRestService.newItem(task.collectionId, list)
                        render resp
                    }
                }
            }

        }else{ //step == 1 -> create bitstream
            def new_step = Integer.parseInt(params.step)+1 //calcula o novo step
            redirect uri: "dspace/listMetadata?processId=${params.processId}&&taskId=${params.taskId}&&step=${new_step}"
        }

    }
}
