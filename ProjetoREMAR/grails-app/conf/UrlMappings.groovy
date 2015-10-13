class UrlMappings {

	@SuppressWarnings("GroovyAssignabilityCheck")
    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        // begin index mappings
        "/"(controller:'index')
        "/frame$uri**"(controller: "index", action: "frame")
        // end index mappings

        name login: "/login"(view: "login/auth")
        name signup: "/signup"(controller: "user", action: "create")
        "/signup/success/$id"(controller: "user", action: "signUpSuccess")

        // begin user mappings
        "/user/account/confirm/$token"(controller: 'user',action: 'confirmAccount')
        '/user/newpassword/confirm'(controller: 'user',action: 'createPassword')
        '/user/confirmation'(view: '/static/emailuser')
        // end user mappings

        // begin password mappings
        //noinspection GroovyAssignabilityCheck
        name resetPassword: "/password/reset"(view: "/static/forgottenPassword")
        //noinspection GroovyAssignabilityCheck
        name developerForm: "/developer/new"(view:"/static/formDeveloper")
        name infoPage: "/index/info" (view: "index/info")
        // end password mappings

        // begin Process API endpoints
        "/process/task/complete/$taskId"(controller:"process", action:"completeTask")
        "/process/task/resolve/$taskId"(controller:"process", action:"resolveTask")
        "/process/tasks/delegate/$processId"(controller:"process", action:"delegateTasks")
        "/process/tasks/overview/$processId"(controller:"process", action:"chooseUsersTasks")
        "/process/publishOptions/$processId"(controller:"process", action:"publishOptions")
        // end Process API endpoints

        // begin Resource API endpoints
        "/resource/review/$id/$status?"(controller:"resource", action:"review")
        // end Resource API endpoints

        "500"(view:'/error')
	}
}
