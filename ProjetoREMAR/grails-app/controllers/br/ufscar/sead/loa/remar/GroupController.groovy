package br.ufscar.sead.loa.remar

import grails.converters.JSON
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
        }else
            render (status: 401, view: "../401")


    }

    def delete(){
        def group = Group.findById(params.id)
        if(group.owner.id == session.user.id){
            group.delete flush: true
            redirect(action: "list")
        }else
            render (status: 401, view: "../401")

    }

    def leaveGroup(){
        User user = session.user
        def group = Group.findById(params.id)
        def userGroup = UserGroup.findByUserAndGroup(user,group)
        userGroup.delete flush: true
        redirect(status: 200,action: "list")
    }

    def addUserAutocomplete(){

        def group = Group.findById(params.groupid)
        if(group.owner.id == session.user.id) {
            def user = User.findById(params.userid)
            if(!UserGroup.findByUserAndGroup(User.findById(user.id), group)) {
                def userGroup = new UserGroup()
                userGroup.group = Group.findById(group.id)
                userGroup.user = user
                userGroup.save flush: true

                render status: 200
            }
            else {
                println "ja ta no grupo"
                render status: 403
            }
        }
    }

    def addUser(){
        if(params.membertoken != ""){
            def userGroup = new UserGroup()
            def group = Group.findByToken(params.membertoken)
            if(group) {
                def user = User.findById(session.user.id)
                if(!UserGroup.findByUserAndGroup(User.findById(user.id), group)) {
                    userGroup.group = group
                    userGroup.user = user
                    println userGroup.admin
                    userGroup.save flush: true
                    redirect(status: 200, action: "show", id: userGroup.groupId)
                }else
                    render status: 400
            }else
                render status: 403

        }else {
//TODO
        }
    }


}
