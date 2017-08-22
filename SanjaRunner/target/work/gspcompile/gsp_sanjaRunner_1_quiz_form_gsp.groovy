import sanjarunner_1.Quiz
import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_sanjaRunner_1_quiz_form_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/quiz/_form.gsp" }
public Object run() {
Writer out = getOut()
Writer expressionOut = getExpressionOut()
registerSitemeshPreprocessMode()
printHtmlPart(0)
expressionOut.print(hasErrors(bean: quizInstance, field: 'title', 'error'))
printHtmlPart(1)
invokeTag('message','g',7,['code':("quiz.title.label"),'default':("Title")],-1)
printHtmlPart(2)
invokeTag('textField','g',10,['name':("title"),'maxlength':("40"),'required':(""),'value':(quizInstance?.title)],-1)
printHtmlPart(3)
expressionOut.print(hasErrors(bean: quizInstance, field: 'answers', 'error'))
printHtmlPart(4)
invokeTag('message','g',16,['code':("quiz.answers.label"),'default':("Answers")],-1)
printHtmlPart(5)
expressionOut.print(hasErrors(bean: quizInstance, field: 'correctAnswer', 'error'))
printHtmlPart(6)
invokeTag('message','g',25,['code':("quiz.correctAnswer.label"),'default':("Correct Answer")],-1)
printHtmlPart(2)
invokeTag('field','g',28,['name':("correctAnswer"),'type':("number"),'value':(quizInstance.correctAnswer),'required':("")],-1)
printHtmlPart(3)
expressionOut.print(hasErrors(bean: quizInstance, field: 'ownerId', 'error'))
printHtmlPart(7)
invokeTag('message','g',34,['code':("quiz.ownerId.label"),'default':("Owner Id")],-1)
printHtmlPart(2)
invokeTag('field','g',37,['name':("ownerId"),'type':("number"),'value':(quizInstance.ownerId),'required':("")],-1)
printHtmlPart(3)
expressionOut.print(hasErrors(bean: quizInstance, field: 'taskId', 'error'))
printHtmlPart(8)
invokeTag('message','g',43,['code':("quiz.taskId.label"),'default':("Task Id")],-1)
printHtmlPart(2)
invokeTag('textField','g',46,['name':("taskId"),'required':(""),'value':(quizInstance?.taskId)],-1)
printHtmlPart(9)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1487276128000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'html'
public static final String TAGLIB_CODEC = 'none'
}
