import sanjarunner_1.SantosDumontController
import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_sanjaRunner_1_santosDumontindex_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/santosDumont/index.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
printHtmlPart(1)
createTagBody(1, {->
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',8,['gsp_sm_xmlClosingForEmptyTag':(""),'name':("layout"),'content':("main")],-1)
printHtmlPart(3)
createTagBody(2, {->
createClosureForHtmlPart(4, 3)
invokeTag('captureTitle','sitemesh',9,[:],3)
})
invokeTag('wrapTitleTag','sitemesh',9,[:],2)
printHtmlPart(5)
invokeTag('captureMeta','sitemesh',13,['gsp_sm_xmlClosingForEmptyTag':("/"),'name':("viewport"),'content':("width=device-width, initial-scale=1.0")],-1)
printHtmlPart(6)
})
invokeTag('captureHead','sitemesh',17,[:],1)
printHtmlPart(7)
createTagBody(1, {->
printHtmlPart(8)
invokeTag('set','g',35,['var':("entityName"),'value':(message(code: 'pergaminho.label', default: 'Pergaminho'))],-1)
printHtmlPart(9)
invokeTag('message','g',36,['code':("default.list.label"),'args':([entityName])],-1)
printHtmlPart(10)
loop:{
int i = 0
for( pergaminhoInstance in (pergaminhoInstanceList) ) {
printHtmlPart(11)
expressionOut.print(pergaminhoInstance.id)
printHtmlPart(12)
expressionOut.print(pergaminhoInstance.id)
printHtmlPart(13)
expressionOut.print(pergaminhoInstance.id)
printHtmlPart(14)
expressionOut.print(fieldValue(bean: pergaminhoInstance, field: "title"))
printHtmlPart(15)
i++
}
}
printHtmlPart(16)
createTagBody(2, {->
printHtmlPart(17)
invokeTag('submitButton','g',107,['name':("updatePergaminho"),'class':("btn btn-success btn-lg my-orange"),'value':("Salvar")],-1)
printHtmlPart(18)
invokeTag('submitButton','g',111,['name':("update"),'class':("btn btn-success btn-lg my-orange"),'value':("Salvar")],-1)
printHtmlPart(19)
})
invokeTag('form','g',113,['method':("post"),'action':("updatePergaminho"),'resource':(pergaminhoInstance)],2)
printHtmlPart(20)
createTagBody(2, {->
printHtmlPart(21)
invokeTag('submitButton','g',131,['name':("createPergaminho"),'class':("btn btn-success btn-lg my-orange"),'value':("Criar")],-1)
printHtmlPart(19)
})
invokeTag('form','g',133,['action':("savePergaminho"),'resource':(pergaminhoInstance)],2)
printHtmlPart(22)
loop:{
int i = 0
for( quizInstance in (quizInstanceList) ) {
printHtmlPart(11)
expressionOut.print(quizInstance.id)
printHtmlPart(12)
expressionOut.print(quizInstance.id)
printHtmlPart(13)
expressionOut.print(quizInstance.id)
printHtmlPart(14)
expressionOut.print(fieldValue(bean: quizInstance, field: "title"))
printHtmlPart(23)
expressionOut.print(fieldValue(bean: quizInstance, field: "answers"))
printHtmlPart(23)
expressionOut.print(quizInstance.answers[quizInstance.correctAnswer])
printHtmlPart(24)
i++
}
}
printHtmlPart(25)
createTagBody(2, {->
printHtmlPart(26)
invokeTag('submitButton','g',293,['name':("updateQuiz"),'class':("btn btn-success btn-lg my-orange"),'value':("Salvar")],-1)
printHtmlPart(19)
})
invokeTag('form','g',295,['method':("post"),'action':("updateQuiz"),'resource':(quizInstance)],2)
printHtmlPart(27)
createTagBody(2, {->
printHtmlPart(28)
invokeTag('submitButton','g',354,['name':("create"),'class':("btn btn-success btn-lg my-orange"),'value':("Criar")],-1)
printHtmlPart(19)
})
invokeTag('form','g',356,['action':("saveQuiz"),'resource':(quizInstance)],2)
printHtmlPart(29)
})
invokeTag('captureBody','sitemesh',399,[:],1)
printHtmlPart(30)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1489975142000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'html'
public static final String TAGLIB_CODEC = 'none'
}
