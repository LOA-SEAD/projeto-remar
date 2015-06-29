class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }


        "/"(controller:'/index')
        '/user/email/confirm'(controller: 'user',action: 'confirmNewUser')
        '/user/newpassword/confirm'(controller: 'user',action: 'confirmEmail')
        name resetPassword: "/password/reset"(view: "/static/forgottenPassword")
        "500"(view:'/error')

        "/process/task/complete/$id"(controller:"process", action:"completeTask")
        "/process/task/resolve/$process/$id"(controller:"process", action:"resolveTask")
        "/process/task/delegate/$process/$id"(controller:"process", action:"delegateTasks")
        "/deploy/review/$id/$status?"(controller:"deploy", action:"review")
	}
}
