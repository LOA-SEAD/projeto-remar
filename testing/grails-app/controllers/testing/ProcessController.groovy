package testing

import org.camunda.bpm.engine.delegate.DelegateExecution
import org.camunda.bpm.engine.delegate.ExecutionListener
import org.camunda.bpm.engine.impl.RuntimeServiceImpl
import org.camunda.bpm.engine.impl.TaskServiceImpl
import org.camunda.bpm.engine.runtime.ProcessInstance

class ProcessController implements ExecutionListener{

    RuntimeServiceImpl runtimeService
    TaskServiceImpl taskService
    ProcessInstance processInstance

    def start() {
        if(params.start) {
            session.processId = runtimeService.startProcessInstanceByKey("TestProcess").getId()
        }
    }

    def task() {
        respond new String("eauheau"), model: [taskId: params.id, test: "kkk"]
    }

    def complete() {
        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()

        if (task != null) {
            taskService.complete(task.id)
            render params.id + " completed"
        } else {
            render params.id + " isn't the current task"
        }
    }

    def end() {
        respond new String("eauheua"), model: [processId: session.processId]
    }

    def test() {
        println "uehauhea"
    }

    @Override
    void notify(DelegateExecution delegateExecution) throws Exception {
        if(delegateExecution.eventName == EVENTNAME_START && delegateExecution.currentActivityId != "EndEvent") {
            redirect action: "task", id: delegateExecution.currentActivityId
        } else if(delegateExecution.currentActivityId == "EndEvent") {
            redirect action: "end"
        }
    }

    def startTask(id) {
         redirect action: "task", id: id
    }
}


/*
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes
import org.springframework.context.ApplicationContext

ApplicationContext applicationContext = (ApplicationContext) ServletContextHolder.getServletContext().getAttribute(GrailsApplicationAttributes.APPLICATION_CONTEXT)

applicationContext.getBean('testing.ProcessController').startTask(execution.currentActivityId)


 */
