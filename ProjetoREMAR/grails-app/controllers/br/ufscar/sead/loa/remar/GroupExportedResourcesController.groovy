package br.ufscar.sead.loa.remar

class GroupExportedResourcesController {

    def index() {}

    def delete(){
        def groupExportedResource = GroupExportedResources.findById(params.id)
        println groupExportedResource
        def group = groupExportedResource.group
        println group
        if(session.user.id == group.owner.id) {
            groupExportedResource.delete flush: true
            render status: 200
        }else{
            render(view: "../401", status: 401)
        }
    }

    def addGroupExportedResources(){
        def groupsId
        groupsId = params.groupsid.split(",")

        def exportedResource = ExportedResource.findById(params.exportedresource)

        groupsId.each{
            def groupExportedResource = new GroupExportedResources()
            def group = Group.findById("${it}")

            if(GroupExportedResources.findByGroupAndExportedResource(group,exportedResource))
                render status: 405, text: "Jogo já pertence a grupo!"
            else{
                groupExportedResource.group = group
                groupExportedResource.exportedResource = exportedResource

                groupExportedResource.save flush: true
                render status: 200
            }


        }

//        redirect(action: "myGames", controller: "exportedResource")

    }
}
