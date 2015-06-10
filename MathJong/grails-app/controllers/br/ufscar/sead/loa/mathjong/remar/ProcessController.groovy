package br.ufscar.sead.loa.mathjong.remar

import com.sun.tools.javac.comp.Flow
import grails.plugin.springsecurity.annotation.Secured
import org.camunda.bpm.engine.RuntimeService
import org.camunda.bpm.engine.TaskService
import org.camunda.bpm.engine.delegate.DelegateExecution
import org.camunda.bpm.engine.delegate.ExecutionListener
import org.camunda.bpm.engine.runtime.ProcessInstance
import org.camunda.bpm.model.bpmn.Bpmn
import org.camunda.bpm.model.bpmn.BpmnModelInstance
import org.camunda.bpm.model.bpmn.instance.FlowNode
import org.camunda.bpm.model.bpmn.instance.SequenceFlow

@Secured(['ROLE_PROF'])

class ProcessController implements ExecutionListener {

    RuntimeService runtimeService
    ProcessInstance processInstance
    TaskService taskService
    def springSecurityService

    def start() {
        session.processId = runtimeService.startProcessInstanceByKey("MathJongProcess").getId()
        session.userId = springSecurityService.getCurrentUser().getId()
        println "process started"

    }

    def complete() {
        def task = taskService.createTaskQuery().processInstanceId(session.processId).taskDefinitionKey(params.id).singleResult()

        if (task != null) {
            taskService.complete(task.id)
            println params.id + " completed "
        }
    }

    def test() {
        BpmnModelInstance modelInstance = Bpmn.readModelFromFile(new File("/Users/matheus/Desktop/a"));
        SequenceFlow sequenceFlow = (SequenceFlow) modelInstance.getModelElementById("SequenceFlow_4");
        FlowNode math = (FlowNode) modelInstance.getModelElementById("math")

        println math.getId() + " <<<"
        Collection<SequenceFlow> outgoing =  math.getOutgoing()

        print outgoing.getAt(0).getTarget().getId() + " aaa"

        FlowNode source = sequenceFlow.getSource()
        FlowNode target = sequenceFlow.getTarget()

        println source.getId()
        println target.getId()

    }

    void notify(DelegateExecution delegateExecution) throws Exception {

        redirect controller: delegateExecution.currentActivityId


//        if(delegateExecution.currentActivityId == "CreateLevels" && delegateExecution.eventName == EVENTNAME_START) {
//            redirect controller: "math"
//        } else if(delegateExecution.currentActivityId == "RefactorTask" && delegateExecution.eventName == EVENTNAME_START) {
//            redirect controller: "refactor"
//        }
    }
}
