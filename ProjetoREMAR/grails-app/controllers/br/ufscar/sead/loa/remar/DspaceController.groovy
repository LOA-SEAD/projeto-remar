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
    static scope = "session"

    def dspaceRestService

//    def tasksFinished = [:]

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

    def overview(){
        def process = Propeller.instance.getProcessInstanceById(params.id, session.user.id as long)

        // cria diretório de tmp no processo e copia os outputs para subpastas nomeadas pelo id das tasks instance
        // do process instance corrente
        def tmpFolder = new File("${servletContext.getRealPath("/data/processes/${process.id}")}/tmp")
        if(!tmpFolder.exists()){
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
        }



//        // cria no mongo uma estrutura que representa o process instance para o dspace
//        // eh necessário saber quando uma task completed foi enviada para o dpsace ...
//        // criado um item na coleção que task defination em resource_dspace representa, e submetido os
//        // bistreams da task -> outputs
//        def process_dspace = MongoHelper.instance.getCollection("process_dspace", params.id)
//        if(process_dspace.first() == null){ //cria uma instancia no Mongo para o processo corrente
//            def data =  [:]
//            def tasks = []
//
//            process.completedTasks.each { task ->
//                def taskStructure = [:]
//
//                taskStructure.id = task.id
//                taskStructure.name = task.name
//                taskStructure.uri = task.uri
//                taskStructure.status = "pending" //atributo que representa se a task (intansce) do process corrente já foi enviada para o dspace
//                tasks.add(taskStructure)
//            }
//
//            data.id = process.id //id do process instance
//            data.name = process.name
//            data.uri = process.uri
//            data.tasks = tasks
//
//            MongoHelper.instance.insertData('resource_dspace',data)
//
//        }

        def map = [:]
        def list = process.getVariable("tasksSendToDspace")
        if(list != null){
            list.split(";").each {task->
                map.put(task.toString(),task.toString())
            }
        }
        println(map)

        render view: "overview", model: [process:process, tasksSendToDspace: map]
    }

    def listMetadata() {

        if(params.step=="0"){
           render view: '_itemMetadata', model: [processId: params.processId, taskId: params.taskId, step: params.step, metadataForm: new MetadataForm()]
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

                render view: '_bitMetadata', model: [bitstreams: list,
                                                    processId: params.processId,
                                                    taskId: params.taskId,
                                                    step: params.step,
                                                    itemId: params.itemId]

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
    def createItem(MetadataForm form){
        println(params)
        println(form)

//        form.validate()
        if(false){ //validação do formulário
//            for (error in form.errors.allErrors){
//                println(error)
//            }

            flash.message = "Erro de validação"
            render view: '_itemMetadata', model: [processId: params.processId, taskId: params.taskId, step: params.step, metadataForm: form]

        }else{
            withForm { //submssão esperada

                def metadatas = [], list = [:]
                def m1 = [:],m2 = [:],m3 = [:], m4 = [:]
                def itemId = null

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

                if(Integer.parseInt(params.step) == 0){ // -> step 0 - criar item
                    def resource_dspace = MongoHelper.instance.getCollection("resource_dspace", resource.id)
                    resource_dspace.collect{
                        it.tasks.each{ task -> //procurando pelo id da coleção que o item será criado
                            if(task.id.toString() == current_task.definition.id.toString()){ //achei a coleção correta
                                itemId = dspaceRestService.newItem(task.collectionId, list)
                            }
                        }
                    }

                    def new_step = Integer.parseInt(params.step)+1 //calcula o novo step
                    redirect uri: "/dspace/listMetadata?processId=${params.processId}&&taskId=${params.taskId}&&step=${new_step}&&itemId=${itemId}"

                }

            }.invalidToken {
                //sbmissão duplicada do formulário
            }
        }
    }

    def submitBitstream(){
        println(params)

        def process = Propeller.instance.getProcessInstanceById(params.processId, session.user.id as long)

        def dir = new File(servletContext.getRealPath("/data/processes/${params.processId}/tmp/${params.taskId}/"))
        dir.eachFileRecurse (FileType.FILES) {file ->
            dspaceRestService.addBitstreamToItem(params.itemId, file, file.name, params.description)
        }

        def tasks = process.getVariable("tasksSendToDspace")
        if(tasks == null) {
            tasks = params.taskId
        }else {
            tasks += ";" + params.taskId
        }
        println(tasks)
        process.putVariable("tasksSendToDspace",tasks, true)

        def map = [:]
        def list = tasks.split(";")
        list.each {task->
            map.put(task.toString(),task.toString())
        }

        render view: 'overview', model: [process: process, tasksSendToDspace: map]
    }
}
