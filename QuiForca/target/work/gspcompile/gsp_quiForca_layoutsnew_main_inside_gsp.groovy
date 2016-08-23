import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_quiForca_layoutsnew_main_inside_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/layouts/new-main-inside.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',4,['gsp_sm_xmlClosingForEmptyTag':(""),'charset':("utf-8")],-1)
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',5,['gsp_sm_xmlClosingForEmptyTag':(""),'http-equiv':("X-UA-Compatible"),'content':("IE=edge")],-1)
printHtmlPart(1)
createTagBody(2, {->
createClosureForHtmlPart(2, 3)
invokeTag('captureTitle','sitemesh',6,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',6,[:],2)
printHtmlPart(3)
invokeTag('captureMeta','sitemesh',8,['gsp_sm_xmlClosingForEmptyTag':(""),'content':("width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"),'name':("viewport")],-1)
printHtmlPart(4)
expressionOut.print(resource(dir: 'assets/css', file: 'bootstrap.css'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'assets/css/inside-style', file: 'AdminLTE.css'))
printHtmlPart(6)
expressionOut.print(resource(dir: 'assets/css/inside-style', file: 'skin-black-light.css'))
printHtmlPart(7)
invokeTag('layoutHead','g',29,[:],-1)
printHtmlPart(8)
})
invokeTag('captureHead','sitemesh',29,[:],1)
printHtmlPart(1)
createTagBody(1, {->
printHtmlPart(9)
expressionOut.print(userName)
printHtmlPart(10)
expressionOut.print(userName)
printHtmlPart(11)
expressionOut.print(userName)
printHtmlPart(12)
createClosureForHtmlPart(13, 2)
invokeTag('link','g',217,['controller':("process"),'action':("userProcesses")],2)
printHtmlPart(14)
createClosureForHtmlPart(15, 2)
invokeTag('link','g',222,['controller':("process"),'action':("pendingTasks")],2)
printHtmlPart(16)
invokeTag('layoutBody','g',253,[:],-1)
printHtmlPart(17)
expressionOut.print(resource(dir: 'assets/js', file: 'jquery.min.js'))
printHtmlPart(18)
expressionOut.print(resource(dir: 'assets/js', file: 'bootstrap.min.js'))
printHtmlPart(19)
expressionOut.print(resource(dir: 'assets/js/inside-scripts', file: 'app.js'))
printHtmlPart(20)
})
invokeTag('captureBody','sitemesh',259,['class':("hold-transition skin-black-light sidebar-mini")],1)
printHtmlPart(21)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1466104025000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'html'
public static final String TAGLIB_CODEC = 'none'
}
