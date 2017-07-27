import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_quimolecula_moleculecreate_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/molecule/create.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',4,['gsp_sm_xmlClosingForEmptyTag':(""),'name':("layout"),'content':("main")],-1)
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',5,['gsp_sm_xmlClosingForEmptyTag':(""),'http-equiv':("X-UA-Compatible"),'content':("IE=9"),'charset':("ISO-8859-1")],-1)
printHtmlPart(2)
})
invokeTag('captureHead','sitemesh',7,[:],1)
printHtmlPart(3)
createTagBody(1, {->
printHtmlPart(4)
invokeTag('javascript','g',18,['src':("engine/jquery-1.7.2.js")],-1)
printHtmlPart(5)
invokeTag('javascript','g',19,['src':("engine/jquery-ui.js")],-1)
printHtmlPart(5)
invokeTag('javascript','g',20,['src':("engine/jquery-ui.punch.js")],-1)
printHtmlPart(5)
invokeTag('javascript','g',21,['src':("engine/save.js")],-1)
printHtmlPart(5)
invokeTag('javascript','g',22,['src':("engine/fases.js")],-1)
printHtmlPart(5)
invokeTag('javascript','g',23,['src':("engine/classe.js")],-1)
printHtmlPart(5)
invokeTag('javascript','g',24,['src':("engine/tutorial.js")],-1)
printHtmlPart(5)
invokeTag('javascript','g',25,['src':("engine/jogo.js")],-1)
printHtmlPart(6)
invokeTag('javascript','g',27,['id':("ancora"),'src':("engine/controle.js")],-1)
printHtmlPart(7)
createClosureForHtmlPart(8, 2)
invokeTag('link','g',29,['controller':("molecule")],2)
printHtmlPart(9)
})
invokeTag('captureBody','sitemesh',34,['oncontextmenu':("return false;")],1)
printHtmlPart(10)
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
