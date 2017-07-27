import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

@GrailsPlugin(name='spring-security-core', version='2.0-RC4')
class gsp_springSecurityCore_loginauth_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/plugins/spring-security-core-2.0-RC4/grails-app/views/login/auth.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',3,['gsp_sm_xmlClosingForEmptyTag':("/"),'name':("layout"),'content':("main")],-1)
printHtmlPart(1)
createTagBody(2, {->
createTagBody(3, {->
invokeTag('message','g',4,['code':("springSecurity.login.title")],-1)
})
invokeTag('captureTitle','sitemesh',4,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',4,[:],2)
printHtmlPart(2)
})
invokeTag('captureHead','sitemesh',85,[:],1)
printHtmlPart(3)
createTagBody(1, {->
printHtmlPart(4)
invokeTag('message','g',90,['code':("springSecurity.login.header")],-1)
printHtmlPart(5)
if(true && (flash.message)) {
printHtmlPart(6)
expressionOut.print(flash.message)
printHtmlPart(7)
}
printHtmlPart(8)
expressionOut.print(postUrl)
printHtmlPart(9)
invokeTag('message','g',98,['code':("springSecurity.login.username.label")],-1)
printHtmlPart(10)
invokeTag('message','g',103,['code':("springSecurity.login.password.label")],-1)
printHtmlPart(11)
expressionOut.print(rememberMeParameter)
printHtmlPart(12)
if(true && (hasCookie)) {
printHtmlPart(13)
}
printHtmlPart(14)
invokeTag('message','g',109,['code':("springSecurity.login.remember.me.label")],-1)
printHtmlPart(15)
expressionOut.print(message(code: "springSecurity.login.button"))
printHtmlPart(16)
})
invokeTag('captureBody','sitemesh',125,[:],1)
printHtmlPart(17)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1404829290000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'html'
public static final String TAGLIB_CODEC = 'none'
}
