class UrlMappings {

	@SuppressWarnings("GroovyAssignabilityCheck")
    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        // begin index mappings
        "/"                                             (controller: "index")
        "/frame$uri**"                                  (controller: "index", action: "frame")
        // end index mappings

        // begin user verification mappings
        name login: "/login"                            (controller: "index", action: "login")
        name signup: "/signup"                          (controller: "user",  action: "create")
        "/signup/success/$id"                           (controller: "user",  action: "signUpSuccess")
        // end user verification mappings

        // begin user mappings
        name resetPassword: "/user/password/reset"      (controller: "user", action: "resetPassword")
        name update: "/user/update"                     (controller: "user", action: "update")
		name updatePhoto: "/user/updatePhoto"           (controller: "user", action: "updatePhoto")
        name myProfile: "/my-profile"                   (controller: "user", action: "myProfile")
        "/user/userProfile/$id"                         (controller: "user", action: "userProfile")
		"/user/account/confirm/$token"                  (controller: "user", action: "confirmAccount")
        // end user mappings

        // begin password mappings
        name project       : "/index"                   (controller: "index", action: "index")
        name developerForm : "/developer/new"           (view: "/static/formDeveloper")
        name infoPage      : "/index/info"              (view: "/index/info")
        name recoverAccount: "/user/accountRecover"     (view: "/user/accountRecover")
        name newGroup      : "/group/new"               (view: "/group/new")
        // end password mappings

        // begin admin endpoints
        "/admin/dashboard"                              (controller: "admin", action: "index")
        "/admin/users"                                  (controller: "admin", action: "users")
        "/admin/groups"                                 (controller: "admin", action: "groups")
        "/admin/games"                                  (controller: "admin", action: "games")
        "/admin/exportCSV"                              (controller: "admin", action: "exportCSV")
        // end admin endpoints

        // begin Process API endpoints
        "/process/task/complete/$taskId"                (controller: "process", action: "completeTask")
        "/process/task/resolve/$taskId"                 (controller: "process", action: "resolveTask")
        "/process/tasks/delegate/$processId"            (controller: "process", action: "delegateTasks")
        "/process/overview/$id"                         (controller: "process", action: "overview")
        "/process/publishOptions/$processId"            (controller: "process", action: "publishOptions")
        "/process/finish/$processId"                    (controller: "process", action: "finish")
        // end Process API endpoints

        // begin moodle mappings
        "/moodle/confirm/$hash"                         (controller: "moodle", action: "confirm")
        "/moodle/link/$moodleId"                        (controller: "moodle", action: "link")
        "/moodle/unlink/$token"                         (controller: "moodle", action: "unlink")
        "/moodle/getLogFromResource/$resourceId"        (controller: "moodle", action: "getLogFromResource")
        // moodle mappings

        // begin Resource API endpoints
        "/resource/review/$id/$status?"                 (controller: "resource", action: "review")
        "/resource/customizableGames"                   (controller: "resource", action: "customizableGames")
        "/resource/show/$id"                            (controller: "resource", action: "show")
        "/resource/saveRating/$id"                      (controller: "resource", action: "saveRating")
        "/resource/deleteRating/$id"                    (controller: "resource", action: "deleteRating")
        "/resource/updateRating/$id"                    (controller: "resource", action: "updateRating")

        "/exported-resource/publicGames"                (controller: "exportedResource", action: "publicGames")
        "/exported-resource/myGames"                    (controller: "exportedResource", action: "myGames")
        "/exported-resource/stats"                      (controller: "exportedResource", action: "stats")
        "/exported-resource/_table/$resourceId"         (controller: "exportedResource", action: "_table")
        "/exported-resource/_table"                     (controller: "exportedResource", action: "_data")

        "/category/save"                                (controller: "category", action: "save")
        "/category/update/$id"                          (controller: "category", action: "update")
        "/category/delete/$id"                          (controller: "category", action: "delete")

        "/dspace/repository"                            (controller: "dspace", action: "index")
        "/dspace/repository/$communityId"               (controller: "dspace", action: "listCollections")
        "/dspace/repository/$communityId/$collectionId" (controller: "dspace", action: "listItems")
        "/dspace/bitstream/$id"                         (controller: "dspace", action: "bitstream")
        "/dspace/removeAll/$id"                         (controller: "dspace", action: "removeAll")
        // end Resource API endpoints

        "500"(view:"/error")
	}
}
