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
        def groupsId
        groupsId = params.groupsid.split(",")

        def exportedResource = ExportedResource.findById(params.exportedresource)

        groupsId.each{
            def groupExportedResource = new GroupExportedResources()
            def group = Group.findById("${it}")

            if(GroupExportedResources.findByGroupAndExportedResource(group,exportedResource)){
                println "ja tem"
                //TODO
            }else{
                groupExportedResource.group = group
                groupExportedResource.exportedResource = exportedResource

                groupExportedResource.save flush: true
                render status: 200
            }


        }

//        redirect(action: "myGames", controller: "exportedResource")

    }
}
