package br.ufscar.sead.loa.mathjong.remar

import grails.plugin.springsecurity.annotation.Secured


@Secured(['ROLE_PROF'])
class RefactorController {

    def index() {}
}
