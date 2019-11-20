class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(uri:'/')
        "500"(view:'/error')
        "/statement/$id/$timestamp"( controller:"question", action:"MP3File") {
            file = "statement"
        }

        "/answer/$id/$timestamp"( controller:"question", action:"MP3File") {
            file = "answer"
        }
	}
}
