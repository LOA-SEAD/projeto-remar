package br.ufscar.sead.loa.remar

import com.mongodb.Block
import com.mongodb.DBCursor
import grails.converters.JSON
import groovy.json.JsonBuilder
import org.apache.commons.lang.RandomStringUtils
import org.bson.Document
import java.util.concurrent.TimeUnit;
import org.grails.datastore.mapping.validation.ValidationException
import static java.util.Arrays.asList;


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
                def allStats = []
                def _stat
                for(int i=0; i<queryMongo.size(); i++){
                    println queryMongo.get(i)
                    def user = allUsersGroup.find { user -> user.id == queryMongo.get(i).userId }
                    _stat = [[user: user]]
                    queryMongo.get(i).stats.each {
                        if(it.exportedResourceId == exportedResource.id) {
                            _stat.push([levelId: it.levelId, win: it.win, gameSize: it.gameSize])
                        }
                    }
                    allStats.push(_stat)

                }

                if(!allStats.empty) {
                    allUsersGroup.each { member ->
                        if (!allStats.find { stat -> stat.get(0).user.id == member.id }) {
                            allStats.push(member)
                        }
                    }
                }
                println allStats
                render view: "stats", model: [allStats: allStats, group: group, exportedResource: exportedResource]
            }else{
                render (status: 401, view: "../401")
            }
        }else {
            println "fobbiden"
            render(status: 401, view: "../401")
        }

    }

    def userStats(){
        println params
        def user = User.findById(params.id)
        def exportedResource = ExportedResource.findById(params.exp)
        if(user){
            def queryMongo = MongoHelper.instance.getStats('stats', params.exp as int, user.id)
            def allStats = []
            def question = []
            queryMongo.forEach(new Block<Document>() {
                @Override
                void apply(Document document) {
                    println document.stats
                    document.stats.each {
                        println it.gameType
                        if(it.exportedResourceId == exportedResource.id){
                            println params.level
                            println it.levelId
                            if(it.levelId == params.level as int) {
                                if (question.empty)
                                    question.push([question: it.question, answer: it.answer, levelId: it.levelId])

                                if(it.gameType == "puzzleWithTime") {
                                    allStats.push([timeStamp    : it.timestamp, levelId: it.levelId, win: it.win,
                                                   points       : it.points, partialPoints: it.partialPoints,
                                                   gameSize     : it.gameSize, gameType: it.gameType,
                                                   remainingTime: String.format("%d min, %d sec",
                                                           TimeUnit.SECONDS.toMinutes(it.remainingTime),
                                                           (it.remainingTime - TimeUnit.MINUTES.toSeconds(TimeUnit.SECONDS.toMinutes(it.remainingTime as long)))
                                                   )])
                                }else if(it.gameType == "questionAndAnswer"){
                                    allStats.push([timeStamp    : it.timestamp, levelId: it.levelId, win: it.win,
                                                   points       : it.points, partialPoints: it.partialPoints, errors: it.errors,
                                                   gameSize     : it.gameSize, gameType: it.gameType ])
                                }
                            }
                        }
                    }

                }
            })

            render view: "userStats", model: [allStats: allStats, user: user, question: question, exportedResource: exportedResource]
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
