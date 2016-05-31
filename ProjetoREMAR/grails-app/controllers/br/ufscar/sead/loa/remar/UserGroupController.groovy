package br.ufscar.sead.loa.remar

class UserGroupController {

    def delete(){
        //TODO, verificar se eh o admin
        def userGroup = UserGroup.findById(params.userGroupId)
        if(userGroup){
            println "if 1"
            def admin = userGroup.group.admins.find {
                it.id == userGroup.user.id
            }
            if(admin){
                println "if do admin"
                def group = userGroup.group
                group.removeFromAdmins(admin)
                group.save flush: true
            }

            userGroup.delete flush: true
            response.status = 205
            render 205
        }else{
//            redirect(controller: "group", action: "show", id: params.groupId , message: false )
        }


    }

    def manageAdmin(){
        println params

        def userGroup = UserGroup.findById(params.userGroupId)
        def group = userGroup.group

        if(params.option == "make-admin"){
            group.addToAdmins(userGroup.user)
            group.save flush: true
            response.status = 200
            render 200
        }else if(params.option == "remove-admin"){
            def user = group.admins.find {
                it.id == userGroup.user.id
            }
            group.removeFromAdmins(user)
            group.save flush: true
            response.status = 200
            render 200
        }else{
            response.status = 400
            render 400

        }
    }

}
