package br.ufscar.sead.loa.remar

class GroupExportedResourcesController {

    def index() {}

    def deleteall(){
        GroupExportedResources.deleteAll()
    }

    def addGroupExportedResources(){

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
