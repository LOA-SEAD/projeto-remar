import br.ufscar.sead.loa.quiforca.remar.Theme
import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_quiForca_themeindex_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/theme/index.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
printHtmlPart(1)
createTagBody(1, {->
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',6,['gsp_sm_xmlClosingForEmptyTag':(""),'name':("layout"),'content':("main")],-1)
printHtmlPart(2)
invokeTag('javascript','g',7,['src':("scriptTheme.js")],-1)
printHtmlPart(2)
invokeTag('javascript','g',8,['src':("iframeResizer.contentWindow.min.js")],-1)
printHtmlPart(3)
invokeTag('set','g',10,['var':("entityName"),'value':(message(code: 'Theme.label', default: 'Theme'))],-1)
printHtmlPart(4)
})
invokeTag('captureHead','sitemesh',12,[:],1)
printHtmlPart(5)
createTagBody(1, {->
printHtmlPart(6)
if(true && (themeInstanceListMy.size() < 1)) {
printHtmlPart(7)
}
else {
printHtmlPart(8)
loop:{
int i = 0
for( themeInstance in (themeInstanceListMy) ) {
printHtmlPart(9)
expressionOut.print(fieldValue(bean: themeInstance, field: "id"))
printHtmlPart(10)
expressionOut.print((i % 2) == 0 ? 'even' : 'odd')
printHtmlPart(11)
expressionOut.print(i)
printHtmlPart(12)
expressionOut.print(fieldValue(bean: themeInstance, field: "id"))
printHtmlPart(13)
expressionOut.print(i == 0 ? "checked" : "")
printHtmlPart(14)
expressionOut.print(i)
printHtmlPart(15)
expressionOut.print(fieldValue(bean: themeInstance, field: "ownerId"))
printHtmlPart(16)
expressionOut.print(fieldValue(bean: themeInstance, field: "id"))
printHtmlPart(17)
expressionOut.print(fieldValue(bean: themeInstance, field: "ownerId"))
printHtmlPart(16)
expressionOut.print(fieldValue(bean: themeInstance, field: "id"))
printHtmlPart(18)
expressionOut.print(fieldValue(bean: themeInstance, field: "ownerId"))
printHtmlPart(16)
expressionOut.print(fieldValue(bean: themeInstance, field: "id"))
printHtmlPart(19)
expressionOut.print(i)
printHtmlPart(20)
i++
}
}
printHtmlPart(21)
}
printHtmlPart(22)
loop:{
int i = 0
for( themeInstance in (themeInstanceListPublic) ) {
printHtmlPart(23)
expressionOut.print(fieldValue(bean: themeInstance, field: "id"))
printHtmlPart(10)
expressionOut.print((i % 2) == 0 ? 'even' : 'odd')
printHtmlPart(24)
expressionOut.print(i)
printHtmlPart(25)
expressionOut.print(fieldValue(bean: themeInstance, field: "id"))
printHtmlPart(13)
expressionOut.print(i == 0 ? "checked" : "")
printHtmlPart(26)
expressionOut.print(i)
printHtmlPart(27)
expressionOut.print(fieldValue(bean: themeInstance, field: "ownerId"))
printHtmlPart(16)
expressionOut.print(fieldValue(bean: themeInstance, field: "id"))
printHtmlPart(28)
expressionOut.print(fieldValue(bean: themeInstance, field: "ownerId"))
printHtmlPart(16)
expressionOut.print(fieldValue(bean: themeInstance, field: "id"))
printHtmlPart(29)
expressionOut.print(fieldValue(bean: themeInstance, field: "ownerId"))
printHtmlPart(16)
expressionOut.print(fieldValue(bean: themeInstance, field: "id"))
printHtmlPart(30)
i++
}
}
printHtmlPart(31)
invokeTag('submitButton','g',104,['name':("save"),'class':("save btn btn-success btn-lg my-orange"),'value':("Enviar")],-1)
printHtmlPart(32)
createClosureForHtmlPart(33, 2)
invokeTag('link','g',105,['class':("btn btn-success btn-lg my-orange"),'action':("create")],2)
printHtmlPart(34)
})
invokeTag('captureBody','sitemesh',111,[:],1)
printHtmlPart(35)
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
