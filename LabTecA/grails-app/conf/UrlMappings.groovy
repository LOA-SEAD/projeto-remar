class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')

        // Resource API
        "/composto/getNomeComposto/$id"(controller: "composto", action: "getNomeComposto")
        "/composto/getFormulaComposto/$id"(controller: "composto", action: "getFormulaComposto")
        "/composto/getTipoComposto/$id"(controller: "composto", action: "getTipoComposto")
	}
}
