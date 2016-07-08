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
        def groupInstance = new Group()

        groupInstance.owner = session.user
        groupInstance.name = params.groupname

        try {
            groupInstance.token = RandomStringUtils.random(10, true, true)
            groupInstance.save flush: true, failOnError: true

        }catch(ValidationException e){
            //TODO
        }

        redirect(action: "show", id: groupInstance.id)

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

    def stats() {

        def group = Group.findById(params.id)
        if(session.user.id == group.owner.id || UserGroup.findByUserAndAdmin(session.user, true)) {
            def exportedResource = ExportedResource.findById(params.exp)
            if (exportedResource) {
                def allUsersGroup = UserGroup.findAllByGroup(group).user
                def queryMongo = MongoHelper.instance.getStats("stats", exportedResource.id as Integer, allUsersGroup.id.toList())
                def allStats
                def ids = []
                allStats = queryMongo.collect {
                    if (!ids.contains(it.userId))
                        ids.add(it.userId)
                    [
                            date    : it.timestamp,
                            question: it.question,
                            answer  : it.answer,
                            level   : it.levelId,
                            points  : it.points,
                            errors  : it.errors,
                            userId  : it.userId
                    ]
                }
                render view: "stats", model: [allStats: allStats, group: group, ids: ids, exportedResource: exportedResource]
            }else{
                render (status: 401, view: "../401")
            }
        }else {
            println "fobbiden"
            render(status: 401, view: "../401")
        }

    }

    def delete(){
        def group = Group.findById(params.id)
        if(group.owner.id == session.user.id){
            group.delete flush: true
            redirect(action: "list")
        }else
            render (status: 401, view: "../401")

    }

    def edit(){
        def group = Group.findById(params.groupId)
        if(group.owner.id == session.user.id) {
            group.setName(params.newName);
            group.save flush: true

            render status: 200, text: "Nome atualizado!"
        }else
            render status: 403
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
        if(group.owner.id == session.user.id || UserGroup.findByUserAndGroupAndAdmin(session.user,group,true)) {
            def user = User.findById(params.userid)
            if(user) {
                if (!UserGroup.findByUserAndGroup(User.findById(user.id), group) && !(group.owner.id == user.id)) {
                    def userGroup = new UserGroup()
                    userGroup.group = Group.findById(group.id)
                    userGroup.user = user
                    userGroup.save flush: true

                    render template: "newUserGroup", model: [userGroup: userGroup]
                } else
                    render status: 403, text: "Usuário já pertence ao grupo."

            }else
                render status: 404, text: "Usuário não encontrado."


        }
    }

    def addUserByToken(){
        if(params.membertoken != ""){
            def userGroup = new UserGroup()
            def group = Group.findByToken(params.membertoken)
            if(group) {
                def user = User.findById(session.user.id)
                if(!UserGroup.findByUserAndGroup(User.findById(user.id), group)) {
                    userGroup.group = group
                    userGroup.user = user
                    userGroup.save flush: true
                    redirect(status: 200, action: "show", id: userGroup.groupId)
                }else
                    render status: 403, text: "Você ja pertence a este grupo."
            }else
                render status: 404, text: "Grupo não encontrado"

        }else
            render status: 404, text: "Grupo não encontrado"

    }


}
