package net.nosegrind.restrpc

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import grails.converters.XML
import java.lang.reflect.Method
import org.springframework.core.annotation.AnnotationUtils

class ApidocController {

	def grailsApplication

	def index(){
		redirect(action:'show')
	}

	def show(){
		def apiOutput = []
		def inc = 0
		grailsApplication.controllerClasses.each { controllerClass ->
			String controllername = controllerClass.logicalPropertyName
			if(controllername!='aclClass'){

				def controller = grailsApplication.getArtefactByLogicalPropertyName('Controller', controllername)
				//def methods = controller?.getClazz().metaClass.methods*.name.sort().unique()
				for (Method method : controller.getClazz().getMethods()){
						if(method.isAnnotationPresent(Api)) {
							if(apiOutput[inc]?.parent!="${controllerClass.logicalPropertyName}"){
								inc++
							}
							if(!apiOutput[inc]){
								apiOutput[inc] = [parent:"${controllerClass.logicalPropertyName}",api:[],json:[]]
							}
							
							def action = method.getName()
							def api = method.getAnnotation(Api)

							def apiList = [path:"${controllername}/${method.getName()}",method:"${api.method()}",description:"${api.description()}",values:[],returns:[],errors:[]]

							// Params
							def params = api.values()
							params.each{ p ->
								if (p.paramType()) {
									def list = [type:"${p.paramType()}",name:"${p.name()}",description:"${p.description()}",required:"${p.required()}",values:[]]
									if(p?.values()){
										def params2 = p.params()
										params2.each{ p2 ->
											if (p2.paramType()) {
												def pm2 = [type:"${p2.paramType()}",name:"${p2.name()}",description:"${p2.description()}",required:"${p2.required()}"]
												list.values.add(pm2)
											}
										}
									}
									apiList.values.add(list)
								}
							}
							
							
							// Returns
							def returns = api.returns()
							def json = [:]
							returns.each{ p ->
								if (p.paramType()) {
									def list = [type:"${p.paramType()}",name:"${p.name()}",description:"${p.description()}",required:"${p.required()}",params:[]]
									def j = [:]
									if(p?.values()){
										j["${p.name()}"]=[]
									}else{
										if(p?.exampleData().trim()){
											j = ["${p.name()}":"${p.exampleData()}"]
										}else{
											j = ["${p.name()}":"${grailsApplication.config.restrpc.defaultData.(p.paramType())}"]
										}
									}
									if(p?.values()){
										def returns2 = p.values()
										returns2.each{ p2 ->
											if (p2.paramType()) {
												def pm2 = [type:"${p2.paramType()}",name:"${p2.name()}",description:"${p2.description()}",required:"${p2.required()}"]
												def j2 = ["${p2.name()}":"${grailsApplication.config.restrpc.defaultData.(p2.paramType())}"]
												j["${p.name()}"].add(j2)
												list.params.add(pm2)
											}
										}
									}
									j.each(){ key,val ->
										if(val instanceof List){
											def child = [:]
											val.each(){ it ->
												it.each(){ key2,val2 ->
													child["${key2}"] ="${val2}"
												}
											}
											json["${key}"] = child
										}else{
											json["${key}"]=val
										}
									}

									//json.add(j)
									apiList.returns.add(list)
								}
							}
							
							// Errors
							def errorList = []
							def errors = api.errors()
							errors.each{ p ->
								if (p.code()) {
									def list = [code:"${p.code()}",description:"${p.description()}"]
									apiList.errors.add(list)
								}
							}

							if(apiOutput[inc].parent && !apiList.isEmpty()){
								apiOutput[inc].json.add(json as JSON)
								apiOutput[inc].api.add(apiList)
							}
						}
				}
			}
			
		}
		apiOutput.remove(null)

		[apiList:apiOutput]
	}

}

