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
        def current_task = Propeller.instance.getTaskInstance(params.taskId, session.user.id as long)

        if(params.step=="0"){
           render view: '_itemMetadata', model: [processId: params.processId,
                                                 taskId: params.taskId,
                                                 step: params.step,
                                                 metadataForm: new MetadataForm()]
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

                render view: '_bitMetadata', model: [bitstreams: list,
                                                    processId: params.processId,
                                                    taskId: params.taskId,
                                                    step: params.step,
                                                    itemId: params.itemId]

            }
        }
    }

    private static createCommunityMetadata(Resource resource){
        def json = new JsonBuilder()
        def m = json {
            "name" resource.name.toString()
            "copyrightText" "cc-by-sa"
            "introductoryText" resource.name.toString()
            "shortDescription" resource.description.toString()
            "shortDescription" resource.description.toString()
            "sidebarText" resource.description.toString()
        }
        println(m)
        return m
    }

    private static createCollectionMetadata(def task){
        def json = new JsonBuilder()
        def m = json {
            "name" task.name
            "copyrightText" "cc-by-sa"
            "introductoryText" task.name
            "shortDescription" task.description
            "sidebarText" task.description
        }
        println(m)
        return m
    }


    //inserir no mongo os id da coleção e comunidades referentes ao resource submetido
    def createStructure(Resource resourceInstance){
        def processDefinition = Propeller.instance.getProcessDefinitionByUri(resourceInstance.uri)
        def data = [:]
        def listTasks = []
        def logMsg = "pd-${session.user.username}"

        println(processDefinition.name)

        try{

            data.id = resourceInstance.id
            data.name = resourceInstance.name
            data.uri = resourceInstance.uri
            data.communityId = dspaceRestService.newSubCommunity(null, createCommunityMetadata(resourceInstance))

            for (def taskDefinition : processDefinition.tasks) {
                def t = [:]
                t.id = taskDefinition.id
                t.name = taskDefinition.name
                t.uri = taskDefinition.uri
                t.collectionId = dspaceRestService.newCollection(data.communityId,
                        createCollectionMetadata(taskDefinition))
                listTasks.add(t)
            }

            data.tasks = listTasks
            println(data)

            MongoHelper.instance.addCollection('resource_dspace')
            MongoHelper.instance.insertData('resource_dspace',data)

            log.debug "${logMsg} ENDED: success – 201"
            response.status = 201
            render 201

        }catch (SocketTimeoutException timeout){
            println("Timeout in CreateStructure - ${timeout.message}, ${timeout.cause}")
        }


    }

    // create-item
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
                def itemId = null
                def process = Propeller.instance.getProcessInstanceById(params.processId, session.user.id as long)
                def resource = Resource.get(process.getVariable('resourceId'))
                def current_task = Propeller.instance.getTaskInstance(params.taskId, session.user.id as long)

                if(current_task.getVariable('step') == null){
                    current_task.putVariable('step','metadata',true)
                }

                //convert date for pattern expected
                Date date = new Date()
                params.publication_date = date.format('YYYY-MM-dd')

                //gerar arquivo de metadados
                for(def hash : dspaceRestService.listMetadata){
                    if(params.get(hash.key).getClass().isArray()){
                        params.get(hash.key).each {
                            def m = [:]
                            m.key = hash.value
                            m.value =  it
                            metadatas.add(m)
                        }
                    }else{
                        def m = [:]
                        m.key = hash.value
                        m.value =  params.get(hash.key)
                        metadatas.add(m)
                    }
                }

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
        def process = Propeller.instance.getProcessInstanceById(params.processId, session.user.id as long)
        def dir = new File(servletContext.getRealPath("/data/processes/${params.processId}/tmp/${params.taskId}/"))
        def i = 0

        dir.eachFileRecurse (FileType.FILES) {file ->
            def description = null
            if(params.description.getClass().isArray()){
                description = params.description.getAt(i)
                i = i+1
            }else{
                description = params.description
            }
            dspaceRestService.addBitstreamToItem(params.itemId, file, file.name, description)
        }

        def tasks = process.getVariable("tasksSendToDspace")
        if(tasks == null) {
            tasks = params.taskId
        }else {
            tasks += ";" + params.taskId
        }
        process.putVariable("tasksSendToDspace",tasks, true)

        def map = [:]
        def list = tasks.split(";")
        list.each {task->
            map.put(task.toString(),task.toString())
        }

        render view: 'overview', model: [process: process, tasksSendToDspace: map]
    }
}
