import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_quimolecula_loginauth_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/login/auth.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',4,['gsp_sm_xmlClosingForEmptyTag':(""),'name':("layout"),'content':("new-main-external")],-1)
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',5,['gsp_sm_xmlClosingForEmptyTag':(""),'charset':("utf-8")],-1)
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',6,['gsp_sm_xmlClosingForEmptyTag':("/"),'name':("generator"),'content':("Bootply")],-1)
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',7,['gsp_sm_xmlClosingForEmptyTag':(""),'name':("viewport"),'content':("width=device-width, initial-scale=1, maximum-scale=1")],-1)
printHtmlPart(1)
createTagBody(2, {->
createClosureForHtmlPart(2, 3)
invokeTag('captureTitle','sitemesh',8,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',8,[:],2)
printHtmlPart(3)
invokeTag('javascript','g',10,['src':("../assets/js/jquery.min.js")],-1)
printHtmlPart(1)
invokeTag('javascript','g',11,['src':("../assets/js/jquery.validate.js")],-1)
printHtmlPart(4)
expressionOut.print(createLink(controller:'facebook', action:'auth'))
printHtmlPart(5)
})
invokeTag('captureHead','sitemesh',44,[:],1)
printHtmlPart(6)
createTagBody(1, {->
printHtmlPart(7)
expressionOut.print(postUrl)
printHtmlPart(8)
createTagBody(2, {->
printHtmlPart(1)
invokeTag('message','g',70,['code':("Login por Facebook")],-1)
printHtmlPart(1)
})
invokeTag('login-button','fb',71,['perms':("email,public_profile"),'scope':("public_profile,email,publish_actions,user_about_me"),'onlogin':("facebookLogin();"),'size':("large")],2)
printHtmlPart(9)
if(true && (flash.message)) {
printHtmlPart(10)
}
printHtmlPart(11)
})
invokeTag('captureBody','sitemesh',94,[:],1)
printHtmlPart(12)
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
