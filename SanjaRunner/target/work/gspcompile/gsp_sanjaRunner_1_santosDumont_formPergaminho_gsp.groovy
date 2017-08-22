import sanjarunner_1.Pergaminho
import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_sanjaRunner_1_santosDumont_formPergaminho_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/santosDumont/_formPergaminho.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
expressionOut.print(hasErrors(bean: pergaminhoInstance, field: 'texto', 'error'))
printHtmlPart(1)
invokeTag('message','g',7,['code':("pergaminho.texto.label"),'default':("Texto")],-1)
printHtmlPart(2)
invokeTag('textField','g',10,['name':("title"),'maxlength':("40"),'required':(""),'value':(pergaminhoInstance?.title)],-1)
printHtmlPart(3)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1487273290000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'html'
public static final String TAGLIB_CODEC = 'none'
}
