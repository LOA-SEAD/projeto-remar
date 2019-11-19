import br.ufscar.sead.loa.respondasepuder.remar.Question

class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/" {controller = "Question"
             action = "index"
        }
        "500"(view:'/error')
	}
}
