package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.propeller.Propeller
import grails.plugin.springsecurity.annotation.Secured
import grails.plugins.rest.client.RestBuilder

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

    def updateOutputs() {

    }
}
