import br.ufscar.sead.loa.respondasepuderinclusivo.remar.Question

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

        "/title/$id/$timestamp"( controller:"question", action:"WAVFile") {
            file = "title"
        }

        "/answer1/$id/$timestamp"( controller:"question", action:"WAVFile") {
            file = "answer1"
        }

        "/answer2/$id/$timestamp"( controller:"question", action:"WAVFile") {
            file = "answer2"
        }

        "/answer3/$id/$timestamp"( controller:"question", action:"WAVFile") {
            file = "answer3"
        }

        "/answer4/$id/$timestamp"( controller:"question", action:"WAVFile") {
            file = "answer4"
        }

        "/hint/$id/$timestamp"( controller:"question", action:"WAVFile") {
            file = "hint"
        }
	}
}
