package br.ufscar.sead.loa.remar

class UserGroupController {

    def delete(){
        def userGroup = UserGroup.findById(params.userGroupId)
        if(userGroup) {
            if (userGroup.group.owner.id == session.user.id) {

                userGroup.delete flush: true
                response.status = 205
                render status: 205

            } else
                render(status: 401, view: "../401")



        }
    }

    def manageAdmin(){
        println params

        def userGroup = UserGroup.findById(params.userGroupId)
        def group = userGroup.group

        if(params.option == "make-admin"){
            userGroup.admin = true
            group.save flush: true
            render status: 200
        }else if(params.option == "remove-admin"){
            userGroup.admin = false
            group.save flush: true
            render status: 200
        }else{
            render status: 400

        }
    }

}
