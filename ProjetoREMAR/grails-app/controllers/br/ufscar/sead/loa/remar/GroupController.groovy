package br.ufscar.sead.loa.remar


class GroupController {

    def springSecurityService

    def list() {
        def groups = Group.findAll()

        render(view: "list", model: [groups: groups])
    }

    def create(){
        println params
        def groupInstance = new Group()
        ArrayList<User> owners = new ArrayList<>()

        owners.add(session.user)
        groupInstance.name = params.groupname
        groupInstance.privacy = params.privacy

        groupInstance.owners = owners

        groupInstance.save flush: true


    }



}
