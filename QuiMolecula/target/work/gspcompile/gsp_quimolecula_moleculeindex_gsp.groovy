import br.ufscar.sead.loa.quimolecula.remar.Molecule
import org.codehaus.groovy.grails.plugins.metadata.GrailsPlugin
import org.codehaus.groovy.grails.web.pages.GroovyPage
import org.codehaus.groovy.grails.web.taglib.*
import org.codehaus.groovy.grails.web.taglib.exceptions.GrailsTagException
import org.springframework.web.util.*
import grails.util.GrailsUtil

class gsp_quimolecula_moleculeindex_gsp extends GroovyPage {
public String getGroovyPageFileName() { "/WEB-INF/grails-app/views/molecule/index.gsp" }
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
invokeTag('captureMeta','sitemesh',21,['gsp_sm_xmlClosingForEmptyTag':("/"),'property':("user-name"),'content':(userName)],-1)
printHtmlPart(2)
invokeTag('captureMeta','sitemesh',22,['gsp_sm_xmlClosingForEmptyTag':("/"),'property':("user-id"),'content':(userId)],-1)
printHtmlPart(4)
invokeTag('set','g',24,['var':("entityName"),'value':(message(code: 'Molecule.label', default: 'Molecule'))],-1)
printHtmlPart(5)
invokeTag('javascript','g',26,['src':("iframeResizer.contentWindow.min.js")],-1)
printHtmlPart(6)
})
invokeTag('captureHead','sitemesh',28,[:],1)
printHtmlPart(6)
createTagBody(1, {->
printHtmlPart(7)
loop:{
int i = 0
for( MoleculeInstance in (MoleculeInstanceList) ) {
printHtmlPart(8)
expressionOut.print(MoleculeInstance.id)
printHtmlPart(9)
expressionOut.print((i % 2) == 0 ? 'even' : 'odd')
printHtmlPart(10)
expressionOut.print(fieldValue(bean: MoleculeInstance, field: "id"))
printHtmlPart(11)
expressionOut.print(fieldValue(bean: MoleculeInstance, field: "ownerId"))
printHtmlPart(12)
if(true && (MoleculeInstance.author == userName)) {
printHtmlPart(13)
expressionOut.print(fieldValue(bean: MoleculeInstance, field: "name"))
printHtmlPart(14)
expressionOut.print(fieldValue(bean: MoleculeInstance, field: "structure"))
printHtmlPart(15)
expressionOut.print(fieldValue(bean: MoleculeInstance, field: "tip"))
printHtmlPart(16)
}
else {
printHtmlPart(17)
expressionOut.print(MoleculeInstance.id)
printHtmlPart(18)
expressionOut.print(fieldValue(bean: MoleculeInstance, field: "name"))
printHtmlPart(14)
expressionOut.print(fieldValue(bean: MoleculeInstance, field: "structure"))
printHtmlPart(15)
expressionOut.print(fieldValue(bean: MoleculeInstance, field: "tip"))
printHtmlPart(19)
}
printHtmlPart(20)
i++
}
}
printHtmlPart(21)
})
invokeTag('captureBody','sitemesh',142,[:],1)
printHtmlPart(22)
}
public static final Map JSP_TAGS = new HashMap()
protected void init() {
	this.jspTags = JSP_TAGS
}
public static final String CONTENT_TYPE = 'text/html;charset=UTF-8'
public static final long LAST_MODIFIED = 1500651093000L
public static final String EXPRESSION_CODEC = 'html'
public static final String STATIC_CODEC = 'none'
public static final String OUT_CODEC = 'html'
public static final String TAGLIB_CODEC = 'none'
}
