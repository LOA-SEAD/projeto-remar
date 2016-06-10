package br.ufscar.sead.loa.remar

import org.apache.commons.lang.RandomStringUtils
import org.grails.datastore.mapping.validation.ValidationException


class GroupController {

    def springSecurityService

    def list() {
        def model = [:]

        model.groupsIOwn = Group.findAllByOwner(session.user)
        model.groupsIBelong = UserGroup.findAllByUser(session.user).group

        render view: "list", model: model
    }

    def create(){
        println params
        def groupInstance = new Group()

        groupInstance.owner = session.user
        groupInstance.name = params.groupname

        try {
            groupInstance.token = RandomStringUtils.random(10, true, true)
            groupInstance.save flush: true, failOnError: true

        }catch(ValidationException e){
            //TODO
        }

    }

    def show(){
        def group = Group.findById(params.id)
        def userGroup = UserGroup.findByUserAndGroup(session.user,group)

        if( group.owner.id == session.user.id ||  userGroup){
            def groupExportedResources = group.groupExportedResources.toList()
            render(view: "show", model: [group: group, groupExportedResources: groupExportedResources])
            response.status = 200
        }else{
            response.status = 401
            render (status: 401, view: "/401")
        }

    }

    def delete(){
        def group = Group.findById(params.id)
        if(group.owner.id == session.user.id){
            group.delete flush: true
            redirect(action: "list")
        }else{

        }
    }

    def leaveGroup(){
        User user = session.user
        def group = Group.findById(params.id)
        def userGroup = UserGroup.findByUserAndGroup(user,group)
        userGroup.delete flush: true
        redirect(action: "list")
    }

    def addUserAutocomplete(){

        def group = Group.findById(params.groupid)
        if(group.owner.id == session.user.id) {
            println "entrou"
            def userGroup = new UserGroup()
            userGroup.group = Group.findById(params.groupid)
            userGroup.user = User.findById(params.userid)
            userGroup.admin = false;
            userGroup.save flush: true

            redirect(status: 200, action: "show", id: userGroup.groupId)
        }
    }

    def addUser(){
        if(params.membertoken != ""){
            def userGroup = new UserGroup()

            println params.token
            def group = Group.findByToken(params.membertoken)
            if(group) {
                userGroup.group = group
                userGroup.user = User.findById(session.user.id)
                userGroup.admin = false;
                userGroup.save flush: true
                println "salvou"
                redirect(status: 200, action: "show", id: userGroup.groupId)
            }else{
                render status: 400

            }
        }else {
//TODO
        }
    }


}
