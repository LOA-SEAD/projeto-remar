class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')
        "/tile/level/$level?"(controller:"tile", action: "index")

        "/carta1/$id/$timestamp"( controller:"tile", action:"WAVFile") {
            file = "carta1"
        }

        "/carta2/$id/$timestamp"( controller:"tile", action:"WAVFile") {
            file = "carta2"
        }

        "/descricao/$id/$timestamp"( controller:"tile", action:"WAVFile") {
            file = "descricao"
        }
	}
}
