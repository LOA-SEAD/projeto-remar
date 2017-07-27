import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_quimolecula_layoutsnew_main_external_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/layouts/new-main-external.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
printHtmlPart(1)
createTagBody(1, {->
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',11,['gsp_sm_xmlClosingForEmptyTag':(""),'charset':("utf-8")],-1)
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',13,['gsp_sm_xmlClosingForEmptyTag':(""),'http-equiv':("X-UA-Compatible"),'content':("IE=edge")],-1)
printHtmlPart(2)
createTagBody(2, {->
createTagBody(3, {->
invokeTag('layoutTitle','g',13,[:],-1)
})
invokeTag('captureTitle','sitemesh',13,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',14,[:],2)
printHtmlPart(3)
expressionOut.print(assetPath(src: 'favicon.png'))
printHtmlPart(4)
invokeTag('captureMeta','sitemesh',18,['gsp_sm_xmlClosingForEmptyTag':(""),'content':("width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"),'name':("viewport")],-1)
printHtmlPart(5)
expressionOut.print(resource(dir: '/assets/css', file: 'bootstrap.css'))
printHtmlPart(6)
expressionOut.print(resource(dir: 'assets/css/inside-style', file: 'AdminLTE.css'))
printHtmlPart(7)
expressionOut.print(resource(dir: 'assets/css/inside-style', file: 'iCheck-styleBlue.css'))
printHtmlPart(8)
invokeTag('javascript','g',35,['src':("../assets/js/jquery.min.js")],-1)
printHtmlPart(9)
invokeTag('javascript','g',37,['src':("../assets/js/jquery.validate.js")],-1)
printHtmlPart(9)
invokeTag('layoutHead','g',37,[:],-1)
printHtmlPart(10)
})
invokeTag('captureHead','sitemesh',39,[:],1)
printHtmlPart(10)
createTagBody(1, {->
printHtmlPart(11)
createClosureForHtmlPart(12, 2)
invokeTag('link','g',48,['controller':("index"),'action':("index")],2)
printHtmlPart(13)
invokeTag('layoutBody','g',49,[:],-1)
printHtmlPart(14)
expressionOut.print(resource(dir: 'assets/js', file: 'jquery.min.js'))
printHtmlPart(15)
expressionOut.print(resource(dir: 'assets/js', file: 'bootstrap.min.js'))
printHtmlPart(16)
expressionOut.print(resource(dir: 'assets/js/inside-scripts', file: 'icheck.js'))
printHtmlPart(17)
invokeTag('javascript','g',61,['src':("../assets/js/jquery.validate.js")],-1)
printHtmlPart(10)
invokeTag('javascript','g',63,['src':("../assets/js/jquery.min.js")],-1)
printHtmlPart(0)
})
invokeTag('captureBody','sitemesh',63,['class':("hold-transition login-page")],1)
printHtmlPart(18)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1500649096000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'html'
public static final String TAGLIB_CODEC = 'none'
}
