import br.ufscar.sead.loa.remar.RequestMap

class BootStrap {

    def init = { servletContext ->

        new RequestMap(url: '/question/**', configAttribute: 'IS_AUTHENTICATED_FULLY').save()
        new RequestMap(url: '/theme/**', configAttribute: 'IS_AUTHENTICATED_FULLY').save()
        new RequestMap(url: '/data/samples/**', configAttribute: 'IS_AUTHENTICATED_FULLY').save()
        for (url in [
                '/', '/index', '/index/info', '/doc/**', '/assets/**', '/**/js/**', '/**/css/**', '/**/images/**',
                '/**/favicon.ico', '/data/**', '/**/scss/**', '/**/less/**', '/**/fonts/**', '/password/**',
                '/moodle/**', '/exportedGame/**', '/static/**', '/login/**', '/logout/**', '/user/**',
                '/facebook/**']) {
            new RequestMap(url: url, configAttribute: 'permitAll').save()
        }
    }
    def destroy = {
    }
}
