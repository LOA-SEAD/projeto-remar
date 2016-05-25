package br.ufscar.sead.loa.remar

class GroupExportedResourcesController {

    def index() {}

    def addExportedResources(){
        println params
//        println params.expor


        redirect(action: "myGames", controller: "exportedResource")


    }
}
