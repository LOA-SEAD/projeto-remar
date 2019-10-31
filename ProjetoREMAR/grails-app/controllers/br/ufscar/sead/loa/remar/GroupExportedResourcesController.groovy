package br.ufscar.sead.loa.remar

class GroupExportedResourcesController {

    def index() {}

    def deleteGroupExportedResources() {
        def exportedResource = ExportedResource.findById(params.exportedresource)
        def group = session.group

        def groupExportedResource =  GroupExportedResources.findByGroupAndExportedResource(group, exportedResource)

        if (groupExportedResource) { // pesquisa se o jogo ja pertence ao respectivo grupo
            groupExportedResource.delete flush: true
            render status: 200, text: "Jogo descompartilhado com sucesso!"
        }
        else { // se não existir, redireciona para erro
            render(view: "../401", status: 401)
        }
    }

    def addGroupExportedResources() {
        def exportedResourceId = ExportedResource.findById(params.exportedresource)
        def groupId = Group.findById(params.groupid)

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