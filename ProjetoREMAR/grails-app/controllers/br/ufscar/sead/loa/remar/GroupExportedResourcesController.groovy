package br.ufscar.sead.loa.remar

class GroupExportedResourcesController {

    def index() {}

    def deleteGroupExportedResources() {
<<<<<<< HEAD
        def exportedResource = ExportedResource.findById(params.exportedresource)
        def group = session.group

        def groupExportedResource =  GroupExportedResources.findByGroupAndExportedResource(group, exportedResource)
=======
        def exportedResourceId = ExportedResource.findById(params.exportedresource) // pega o id do jogo
        def groupId = Group.findById(params.groupid) // pega o id do grupo

        def groupExportedResource =  GroupExportedResources.findByGroupAndExportedResource(groupId, exportedResourceId)
>>>>>>> 3e256c8e73a4f68069b335fb195d93b6ff0134b8

        if (groupExportedResource) { // pesquisa se o jogo ja pertence ao respectivo grupo
            groupExportedResource.delete flush: true
            render status: 200, text: "Jogo descompartilhado com sucesso!"
        }
        else { // se não existir, redireciona para erro
            render(view: "../401", status: 401)
        }
    }

    def addGroupExportedResources() {
<<<<<<< HEAD
        def exportedResourceId = ExportedResource.findById(params.exportedresource)
        def groupId = Group.findById(params.groupid)
=======
        def exportedResourceId = ExportedResource.findById(params.exportedresource) // pega o id do jogo
        def groupId = Group.findById(params.groupid) // pega o id do grupo
>>>>>>> 3e256c8e73a4f68069b335fb195d93b6ff0134b8

        def groupExportedResource = new GroupExportedResources() // declara um novo grupo (a ser gravado ou não)

        if (GroupExportedResources.findByGroupAndExportedResource(groupId, exportedResourceId)) // pesquisa se o jogo ja pertence ao respectivo grupo
            render status: 405, text: "Este jogo já pertence a um grupo!"
        else { // se não existir, grava
            groupExportedResource.group = groupId
            groupExportedResource.exportedResource = exportedResourceId

            groupExportedResource.save flush: true
            render status: 200
        }

    }
}