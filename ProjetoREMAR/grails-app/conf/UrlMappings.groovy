class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller:'/index')
        '/user/email/confirm'(controller: 'user',action: 'confirmNewUser')
        "500"(view:'/error')
	}
}
