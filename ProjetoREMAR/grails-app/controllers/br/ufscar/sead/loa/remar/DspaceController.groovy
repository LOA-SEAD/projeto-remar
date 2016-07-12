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

        render view: "overview", model: [process:process]
    }

    def listMetadata() {

        params.processId = "57740a26c9cd332a5d6b9684"
        params.taskId = "57740a26c9cd332a5d6b9686"

        def list = [];
        def dir = new File(servletContext.getRealPath("/data/processes/${params.processId}/tmp/${params.taskId}/"))
        dir.eachFileRecurse (FileType.FILES) {file ->
            list << file
        }

        list.each {
            println it.name
        }

        render view: 'listMetadata', model: [bitstreams: list]
    }


    def createCommunityTest(){
        def json = new JsonBuilder()
        def m= json {
            "name" "game de teste"
            "copyrightText" "teste"
            "introductoryText" "teste"
            "shortDescription" "game para teste de criação de uma comunidade"
        }

        def r = dspaceRestService.newSubCommunity(metadata:m)

        render r
    }

    def mongoTest(){

        def data = [:]

        def r = Resource.findById(1)

        data = {
            id: r.id
            name: r.name
            communityId: 3
            tasks: [
                    {
                        id: "577404b2c9cd3319baf9b41d"
                        name: "Tema"
                        uri: "theme"
                        collectionId: 2
                    },
                    {
                        id: "577404b2c9cd3319baf9b41e"
                        name: "Banco de Questões"
                        uri: "questions"
                        collectionId: 3
                    }
            ]
        }

//        data.tasks = {
//            MongoHelper.instance.getDataForUri('process_definition', r.uri.toString())
//        }

        println(data)

//        def t = MongoHelper.instance.getDataForUri('process_definition', r.uri.toString())
//        t.collect {
//            println it
//        }

        MongoHelper.instance.createCollection('resource_dspace')
        MongoHelper.instance.insertData('resource_dspace',data)

        render "<h1>teste</h1>"
    }
}
