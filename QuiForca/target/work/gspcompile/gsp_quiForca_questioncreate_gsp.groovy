import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_quiForca_questioncreate_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/question/create.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',10,['gsp_sm_xmlClosingForEmptyTag':(""),'name':("layout"),'content':("main")],-1)
printHtmlPart(1)
invokeTag('javascript','g',10,['src':("scriptTheme.js")],-1)
printHtmlPart(2)
})
invokeTag('captureHead','sitemesh',10,[:],1)
printHtmlPart(2)
createTagBody(1, {->
printHtmlPart(3)
if(true && (flash.message)) {
printHtmlPart(4)
expressionOut.print(flash.message)
printHtmlPart(5)
}
printHtmlPart(6)
if(true && (flash.message)) {
printHtmlPart(7)
expressionOut.print(flash.message)
printHtmlPart(8)
}
printHtmlPart(9)
createTagBody(2, {->
printHtmlPart(10)
createTagBody(3, {->
printHtmlPart(11)
if(true && (error in org.springframework.validation.FieldError)) {
printHtmlPart(12)
expressionOut.print(error.field)
printHtmlPart(13)
}
printHtmlPart(14)
invokeTag('message','g',31,['error':(error)],-1)
printHtmlPart(15)
})
invokeTag('eachError','g',31,['bean':(questionInstance),'var':("error")],3)
printHtmlPart(16)
})
invokeTag('hasErrors','g',32,['bean':(questionInstance)],2)
printHtmlPart(9)
createTagBody(2, {->
printHtmlPart(17)
invokeTag('render','g',36,['template':("form")],-1)
printHtmlPart(18)
invokeTag('submitButton','g',41,['name':("create"),'class':("btn btn-success"),'value':(message(code: 'default.button.create.label', default: 'Create'))],-1)
printHtmlPart(19)
})
invokeTag('form','g',41,['url':([resource:questionInstance, action:'save'])],2)
printHtmlPart(20)
})
invokeTag('captureBody','sitemesh',43,[:],1)
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
