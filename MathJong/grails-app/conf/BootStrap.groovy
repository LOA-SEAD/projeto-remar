import javax.servlet.http.HttpServletRequest

class BootStrap {

    def init = { servletContext ->

        HttpServletRequest.metaClass.isXhr = {->
            'XMLHttpRequest' == delegate.getHeader('X-Requested-With')
        }
    }
    def destroy = {
    }
}
