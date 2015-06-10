package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_PROF'])
class TestController {

    RedisConnection redisHandler
    def redisService

    def index() {
        RedisConnection.reset() // for testing only
        redisHandler = RedisConnection.getInstance(redisService)
    }

    def psubscribe() {
        RedisConnection.getInstance(redisService).pSubscribe("complete*")
    }
}
