import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_quiForca_loginauth2_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/login/auth2.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',10,['gsp_sm_xmlClosingForEmptyTag':(""),'charset':("utf-8")],-1)
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',12,['gsp_sm_xmlClosingForEmptyTag':("/"),'name':("generator"),'content':("Bootply")],-1)
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',13,['gsp_sm_xmlClosingForEmptyTag':(""),'name':("viewport"),'content':("width=device-width, initial-scale=1, maximum-scale=1")],-1)
printHtmlPart(1)
createTagBody(2, {->
createClosureForHtmlPart(2, 3)
invokeTag('captureTitle','sitemesh',13,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',14,[:],2)
printHtmlPart(3)
expressionOut.print(resource(dir: 'assets/img/logo', file: 'icone-remar_v2.ico'))
printHtmlPart(4)
expressionOut.print(resource(dir: 'assets/css', file: 'bootstrap.css'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'assets/css', file: 'bootstrap-social.css'))
printHtmlPart(5)
expressionOut.print(resource(dir: 'assets/css', file: 'external-styles.css'))
printHtmlPart(6)
invokeTag('javascript','g',24,['src':("../assets/js/jquery.min.js")],-1)
printHtmlPart(1)
invokeTag('javascript','g',26,['src':("../assets/js/jquery.validate.js")],-1)
printHtmlPart(7)
expressionOut.print(createLink(controller:'facebook', action:'auth'))
printHtmlPart(8)
invokeTag('resources','fbg',92,[:],-1)
printHtmlPart(9)
})
invokeTag('captureHead','sitemesh',93,[:],1)
printHtmlPart(10)
createTagBody(1, {->
printHtmlPart(10)
invokeTag('initJS','facebook',101,['appId':(facebookContext.app.id)],-1)
printHtmlPart(11)
createClosureForHtmlPart(12, 2)
invokeTag('ifAllGranted','sec',114,['roles':("ROLE_USER,ROLE_FACEBOOK")],2)
printHtmlPart(13)
createClosureForHtmlPart(14, 2)
invokeTag('ifNotGranted','sec',117,['roles':("ROLE_ADMIN,ROLE_USER_ROLE_FACEBOOK")],2)
printHtmlPart(13)
createTagBody(2, {->
printHtmlPart(15)
invokeTag('message','g',120,['code':("Login por Facebook")],-1)
printHtmlPart(13)
})
invokeTag('login-button','fb',120,['perms':("email,public_profile"),'scope':("public_profile,email,publish_actions,user_about_me"),'onlogin':("facebookLogin();"),'size':("large")],2)
printHtmlPart(16)
expressionOut.print(postUrl)
printHtmlPart(17)
expressionOut.print(rememberMeParameter)
printHtmlPart(18)
if(true && (flash.message)) {
printHtmlPart(19)
}
printHtmlPart(20)
createClosureForHtmlPart(21, 2)
invokeTag('link','g',176,['class':("footer-span"),'mapping':("resetPassword")],2)
printHtmlPart(22)
createClosureForHtmlPart(23, 2)
invokeTag('link','g',177,['class':("footer-span"),'controller':("user"),'action':("create")],2)
printHtmlPart(24)
})
invokeTag('captureBody','sitemesh',177,[:],1)
printHtmlPart(25)
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
