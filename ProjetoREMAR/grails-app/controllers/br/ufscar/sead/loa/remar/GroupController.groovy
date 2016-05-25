package br.ufscar.sead.loa.remar


class GroupController {

    def springSecurityService

    def list() {
        def groups = Group.findAllByOwner(session.user)

        render(view: "list", model: [groups: groups])
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
        def admins = group.getAdmins().toList()
//        def groupUsers = UserGroup.findAllByGroup(group)
        def groupUsers = group.getUserGroups()
        render(view: "show", model: [group: group, groupUsers: groupUsers])
    }

    def addUser(){

        def userGroup = new UserGroup()
        userGroup.group = Group.findById(params.groupid)
        userGroup.user = User.findById(params.userid)
        //TODO filtrar usuarios ja adicionados
        userGroup.save flush: true

        redirect(action: "show", id: userGroup.groupId)
    }

    def makeAdmin(){
        def user = User.findById(params.id)
        def userGroup = UserGroup.findByUser(user)
        def group = userGroup.group

        group.addToAdmins(user)
        group.save flush: true

        redirect(action: "show", id: userGroup.groupId)

    }

    def removeAdmin(){

        def user = User.findById(params.id)
        def userGroup = UserGroup.findByUser(user)
        def group = userGroup.group

        group.removeFromAdmins(user)
        group.save flush: true

        redirect(action: "show", id: userGroup.groupId)

    }

    def delete(){
        def userGroup = UserGroup.findByUser(User.findById(params.id))
        def adminList = userGroup.group.admins.toList()

        if(userGroup){
            if(adminList.contains(userGroup.user)){
                def group = userGroup.group
                group.removeFromAdmins(userGroup.user)
                group.save flush: true
            }

            userGroup.delete flush: true
            redirect(action: "show", id: userGroup.group.id, message: true )
        }else{
            redirect(action: "show", id: userGroup.group.id , message: false )
        }


    }





}
