import br.ufscar.sead.loa.quiforca.remar.Question
import br.ufscar.sead.loa.quiforca.remar.Theme

import javax.servlet.http.HttpServletRequest

class BootStrap {

    def init = { servletContext ->

        HttpServletRequest.metaClass.isXhr = {->
            'XMLHttpRequest' == delegate.getHeader('X-Requested-With')
        }

//        def springContext = WebApplicationContextUtils.getWebApplicationContext(servletContext)
//        springContext.getBean('marshallers').register();


        // *************************


        println "Bootstrap: done"

    }
    def destroy = {
    }
}
