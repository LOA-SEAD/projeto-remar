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

        groupInstance.addToOwners(session.user)
        groupInstance.name = params.groupname
        groupInstance.privacy = params.privacy

        groupInstance.save flush: true

    }

    def show(){
        def group = Group.findById(params.id)
        def groupUsers = UserGroup.findAllByGroup(group)

        render(view: "show", model: [group: group, groupUsers: groupUsers])
    }

    def addUser(){
        println params

        def userGroup = new UserGroup()
        userGroup.group = Group.findById(params.groupid)
        userGroup.user = User.findById(params.userid)

        userGroup.save flush: true

        redirect(action: "show", id: userGroup.groupId)
    }

    def delete(){
        def userGroup = UserGroup.findByUser(User.findById(params.id))
        def groupId = userGroup.group.id

        if(userGroup){
            userGroup.delete flush: true
            redirect(action: "show", id: groupId, message: true )
        }else{
            redirect(action: "show", id: groupId , message: false )
        }


    }





}
