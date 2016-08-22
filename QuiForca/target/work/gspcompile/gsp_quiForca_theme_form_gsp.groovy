import br.ufscar.sead.loa.quiforca.remar.Theme
import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_quiForca_theme_form_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/theme/_form.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
printHtmlPart(1)
printHtmlPart(2)
createTagBody(1, {->
printHtmlPart(3)
invokeTag('javascript','g',7,['src':("iframeResizer.contentWindow.min.js")],-1)
printHtmlPart(3)
invokeTag('javascript','g',8,['src':("../assets/js/jquery.min.js")],-1)
printHtmlPart(4)
})
invokeTag('captureHead','sitemesh',10,['xmlns':("http://www.w3.org/1999/html")],1)
printHtmlPart(1)
createTagBody(1, {->
printHtmlPart(5)
createClosureForHtmlPart(6, 2)
invokeTag('uploadForm','g',140,['controller':("design"),'action':("ImagesManager")],2)
printHtmlPart(7)
invokeTag('javascript','g',144,['src':("imagePreview.js")],-1)
printHtmlPart(8)
})
invokeTag('captureBody','sitemesh',154,[:],1)
printHtmlPart(1)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1466104025000L
public static final String EXPRESSION_CODEC = 'raw'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'html'
public static final String TAGLIB_CODEC = 'none'
}
