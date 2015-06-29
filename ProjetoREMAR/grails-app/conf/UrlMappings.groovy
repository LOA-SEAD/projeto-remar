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
	}
}
