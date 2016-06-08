package br.ufscar.sead.loa.remar

class GroupExportedResourcesController {

    def index() {}

    def delete(){
        def groupExportedResource = GroupExportedResources.findById(params.id)
        println groupExportedResource
        def group = groupExportedResource.group
        println group
        if(session.user.id == group.owner.id) {
            println "entrou"
            groupExportedResource.delete flush: true
            redirect(action: "show", id: group.id,  controller: "group")
        }else{
            render(view: "../401", status: 401)
        }
    }

    def addGroupExportedResources(){
        println params.exportedresource
        println params.groupsid
        def exportedResource = ExportedResource.findById(params.exportedresource)
        params.groupsid.each{
            def groupExportedResource = new GroupExportedResources()

            groupExportedResource.group = Group.findById("${it}")
            groupExportedResource.exportedResource = exportedResource

            println groupExportedResource.group
            println groupExportedResource.exportedResource

            groupExportedResource.save flush: true
        }



        redirect(action: "myGames", controller: "exportedResource")

    }
}
