class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')
        "/memoria/tile/validate"(controller: "tile", action: "validate")
        "/memoria/tile/show"(controller: "tile", action: "show")
        "/memoria/tile/listByDifficulty"(controller: "tile", action: "listByDifficulty")
	}
}
