package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured


class IndexController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def index() {
        if (springSecurityService.isLoggedIn()) {
            redirect uri: "/dashboard"
        } else {
            render view: "index"
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def dashboard() {
        def gamesList = Game.list()
        def games = []
        gamesList.each {game ->
            def g = []
            g.push(game.name)
            g.push(game.platforms.asList())
            games.push(g)
        }
        render view: "dashboard", model: [games: games]


    }
}