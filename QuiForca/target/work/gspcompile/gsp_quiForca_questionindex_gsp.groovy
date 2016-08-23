import br.ufscar.sead.loa.quiforca.remar.Question
import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_quiForca_questionindex_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/question/index.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
createTagBody(1, {->
printHtmlPart(1)
invokeTag('captureMeta','sitemesh',12,['gsp_sm_xmlClosingForEmptyTag':("/"),'name':("viewport"),'content':("width=device-width, initial-scale=1.0")],-1)
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',13,['gsp_sm_xmlClosingForEmptyTag':(""),'name':("layout"),'content':("main")],-1)
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',14,['gsp_sm_xmlClosingForEmptyTag':(""),'charset':("utf-8")],-1)
printHtmlPart(2)
invokeTag('javascript','g',15,['src':("editableTable.js")],-1)
printHtmlPart(2)
invokeTag('javascript','g',16,['src':("scriptTable.js")],-1)
printHtmlPart(2)
invokeTag('javascript','g',17,['src':("validate.js")],-1)
printHtmlPart(3)
invokeTag('captureMeta','sitemesh',20,['gsp_sm_xmlClosingForEmptyTag':("/"),'property':("user-name"),'content':(userName)],-1)
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',21,['gsp_sm_xmlClosingForEmptyTag':("/"),'property':("user-id"),'content':(userId)],-1)
printHtmlPart(4)
invokeTag('set','g',23,['var':("entityName"),'value':(message(code: 'question.label', default: 'Question'))],-1)
printHtmlPart(5)
invokeTag('javascript','g',25,['src':("iframeResizer.contentWindow.min.js")],-1)
printHtmlPart(6)
})
invokeTag('captureHead','sitemesh',27,[:],1)
printHtmlPart(6)
createTagBody(1, {->
printHtmlPart(7)
loop:{
int i = 0
for( questionInstance in (questionInstanceList) ) {
printHtmlPart(8)
expressionOut.print((i % 2) == 0 ? 'even' : 'odd')
printHtmlPart(9)
expressionOut.print(fieldValue(bean: questionInstance, field: "id"))
printHtmlPart(10)
expressionOut.print(fieldValue(bean: questionInstance, field: "ownerId"))
printHtmlPart(11)
if(true && (questionInstance.author == userName)) {
printHtmlPart(12)
expressionOut.print(fieldValue(bean: questionInstance, field: "statement"))
printHtmlPart(13)
expressionOut.print(fieldValue(bean: questionInstance, field: "answer"))
printHtmlPart(14)
expressionOut.print(fieldValue(bean: questionInstance, field: "category"))
printHtmlPart(13)
expressionOut.print(fieldValue(bean: questionInstance, field: "author"))
printHtmlPart(15)
}
else {
printHtmlPart(16)
expressionOut.print(questionInstance.id)
printHtmlPart(17)
expressionOut.print(fieldValue(bean: questionInstance, field: "statement"))
printHtmlPart(13)
expressionOut.print(fieldValue(bean: questionInstance, field: "answer"))
printHtmlPart(14)
expressionOut.print(fieldValue(bean: questionInstance, field: "category"))
printHtmlPart(13)
expressionOut.print(fieldValue(bean: questionInstance, field: "author"))
printHtmlPart(18)
}
printHtmlPart(19)
i++
}
}
printHtmlPart(20)
createTagBody(2, {->
printHtmlPart(21)
invokeTag('render','g',150,['template':("form")],-1)
printHtmlPart(22)
invokeTag('submitButton','g',154,['name':("create"),'class':("btn btn-success btn-lg my-orange"),'value':(message(code: 'default.button.create.label', default: 'Create'))],-1)
printHtmlPart(23)
})
invokeTag('form','g',155,['url':([resource: questionInstance, action: 'newQuestion'])],2)
printHtmlPart(24)
createTagBody(2, {->
printHtmlPart(25)
invokeTag('actionSubmit','g',189,['class':("save btn btn-success btn-lg my-orange"),'action':("update"),'value':(message(code: 'default.button.update.label', default: 'Salvar'))],-1)
printHtmlPart(26)
})
invokeTag('form','g',189,['url':([resource: questionInstance, action: 'update']),'method':("PUT")],2)
printHtmlPart(27)
createTagBody(2, {->
printHtmlPart(28)
invokeTag('submitButton','g',226,['class':("btn my-orange"),'name':("csv"),'value':("Enviar")],-1)
printHtmlPart(29)
})
invokeTag('uploadForm','g',227,['action':("generateQuestions")],2)
printHtmlPart(30)
})
invokeTag('captureBody','sitemesh',287,[:],1)
printHtmlPart(31)
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
