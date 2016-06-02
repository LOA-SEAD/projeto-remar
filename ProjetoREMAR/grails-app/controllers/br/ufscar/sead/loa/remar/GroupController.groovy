package br.ufscar.sead.loa.remar


class GroupController {

    def springSecurityService

    def list() {
        def model = [:]

        model.groupsIOwn = Group.findAllByOwner(session.user)
        model.groupsIBelong = UserGroup.findAllByUser(session.user).group

        render view: "list", model: model
    }

    def create(){
        println params
        def groupInstance = new Group()

        groupInstance.owner = session.user
        groupInstance.name = params.groupname
        groupInstance.privacy = params.privacy

        groupInstance.save flush: true

    }

    def show(){
        def group = Group.findById(params.id)
        def userGroup = UserGroup.findByUserAndGroup(session.user,group)

        if( group.owner.id == session.user.id ||  userGroup){
            def groupExportedResources = group.groupExportedResources.toList()
            render(view: "show", model: [group: group, groupExportedResources: groupExportedResources])
            response.status = 200
        }else{
            response.status = 401
            render (status: 401, view: "401")
        }

    }

    def addUser(){

        def userGroup = new UserGroup()
        userGroup.group = Group.findById(params.groupid)
        userGroup.user = User.findById(params.userid)
        //TODO filtrar usuarios ja adicionados
        userGroup.save flush: true

        redirect(action: "show", id: userGroup.groupId)
    }


}
