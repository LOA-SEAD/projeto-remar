package br.ufscar.sead.loa.mathjong.remar

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_PROF'])
class TestController {

    def redisService

    def index() {
        redisService.publish("foo", "bar");
    }
}
