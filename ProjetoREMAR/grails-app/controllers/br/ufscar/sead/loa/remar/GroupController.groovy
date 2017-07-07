package br.ufscar.sead.loa.remar

import com.mongodb.Block
import com.mongodb.DBCursor
import grails.converters.JSON
import groovy.json.JsonBuilder
import org.apache.commons.lang.RandomStringUtils
import grails.plugin.springsecurity.annotation.Secured
import org.bson.Document
import java.util.concurrent.TimeUnit;
import org.grails.datastore.mapping.validation.ValidationException
import static java.util.Arrays.asList;


class GroupController {

    def springSecurityService

    def beforeInterceptor = [action: this.&check, only: ['list', 'show']]

    private check() {
        if (!session.user) {
            log.debug "Logout: session.user is NULL !"
            redirect controller: "logout", action: "index"
            return false
        }
    }

    def list() {
        def model = [:]

        model.groupsIOwn = Group.findAllByOwner(session.user)
        model.groupsIAdmin = UserGroup.findAllByAdminAndUser(true, session.user).group
        model.groupsIBelong = UserGroup.findAllByAdminAndUser(false, session.user).group

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

        render groupInstance.id

    }

    def show(){
        def group = Group.findById(params.id)
        def userGroup = UserGroup.findByUserAndGroup(session.user,group)

        if( group.owner.id == session.user.id ||  userGroup){
            def groupExportedResources = group.groupExportedResources.toList().sort({it.id})
            render(view: "show", model: [group: group, groupExportedResources: groupExportedResources])
            response.status = 200
        }else
            render (status: 401, view: "../401")


    }

    def isLogged(){
        println params
        if(params.choice != "null") {
            if (params.choice == "offline") {
                println "ok"
                render status: 200
            } else if (params.choice == "login") {
                println "login in"
                springSecurityService.reauthenticate(params.username, params.password)
                if(springSecurityService.isLoggedIn()){
                    session.user = springSecurityService.getCurrentUser()
                    println "logged!"
                    render status: 200
                }else{
                    println "didnt find user"
                    render status: 401, template: "stats/login"
                }
            }
        }else{
            render status: 401, template: "stats/login"
        }
    }

    def stats() {
        def group = Group.findById(params.id)
        if(session.user.id == group.owner.id || UserGroup.findByUserAndAdmin(session.user, true)) {
            def exportedResource = ExportedResource.findById(params.exp)
            if (exportedResource) {
                def allUsersGroup = UserGroup.findAllByGroup(group).user
//                allUsersGroup.add(group.owner)
//                allUsersGroup.sort{it.id}
                def queryMongo
                try{
                    queryMongo = MongoHelper.instance.getStats("stats", exportedResource.id as Integer, allUsersGroup.id.toList())

                    def allStats = []
                    def _stat
                    for(int i=0; i<queryMongo.size(); i++){
                        def user = allUsersGroup.find { user -> user.id == queryMongo.get(i).userId || group.owner.id == queryMongo.get(i).userId }

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
                            if (!allStats.find { stat -> stat.get(0) != null && stat.get(0).user.id == member.id }) {
                                allStats.push(member)
                            }

                        }
                    }
                    println allStats

                    render view: "stats", model: [allStats: allStats, group: group, exportedResource: exportedResource]

                }catch (NullPointerException e){
                    System.err.println(e.getClass().getName() + ": " + e.getMessage());
//                    redirect(action: 'stats', id: params.id)
                }

            }else{
                render (status: 401, view: "../401")
            }
        }else {
            println "fobbiden"
            render(status: 401, view: "../401")
        }

    }

    def userStats() {
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
                    document.stats.each {
                        if(it.exportedResourceId == exportedResource.id){
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
                                } else if(it.gameType == "questionAndAnswer"){
                                    allStats.push([timeStamp    : it.timestamp, levelId: it.levelId, win: it.win,
                                                   points       : it.points, partialPoints: it.partialPoints, errors: it.errors,
                                                   gameSize     : it.gameSize, gameType: it.gameType ])
                                } else if(it.gameType == "multipleChoice"){
                                    allStats.push([timeStamp    : it.timestamp, levelId: it.levelId, win: it.win, choice: it.choice,
                                                choices: it.choices, errors: it.errors, gameSize: it.gameSize, gameType: it.gameType ])
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

        if(group.owner.id == session.user.id || UserGroup.findByUserAndGroupAndAdmin(session.user, group, true)) {
            def user = User.findByUsername(params.username)
            log.debug ("Attempting to add user " + params.username + " to group " + params.groupid)
            if(user) {
                if (!UserGroup.findByUserAndGroup(User.findById(user.id), group) && !(group.owner.id == user.id)) {
                    def userGroup = new UserGroup()
                    userGroup.group = Group.findById(group.id)
                    userGroup.user = user
                    userGroup.save flush: true

                    log.debug ("Success!")
                    render status:200, template: "newUserGroup", model: [userGroup: userGroup]
                } else {
                    log.debug ("Failed! User is already in group.")
                    render status: 403, text: "Usuário já pertence ao grupo."
                }
            } else {
                log.debug ("Failed! User not found.")
                render status: 404, text: "Usuário não encontrado."
            }
        }
    }

    def addUserByToken () {
        if(params.membertoken != ""){
            def userGroup = new UserGroup()
            def group = Group.findByToken(params.membertoken)
            if (group) {
                def user = User.findById(session.user.id)
                if (!UserGroup.findByUserAndGroup(User.findById(user.id), group)) {
                    userGroup.group = group
                    userGroup.user = user
                    userGroup.save flush: true
                    render status: 200, template: "newGroup", model: [group: group]
                } else
                    render status: 403, text: "Você já pertence a este grupo."
            } else
                render status: 404, text: "Grupo não encontrado"
        } else
            render status: 404, text: "Grupo não encontrado"

    }

    def addUserById () {
        def group = Group.findById(params.groupId)
        def user = User.findById(params.userId)
        def userGroup = new UserGroup()

        if (user) {
            userGroup.group = group
            userGroup.user = user
            userGroup.save flush:true
        }
    }

    def findGroup(){
        println(params.name)
        def group = Group.findByNameAndOwner(params.name, session.user)
        render group
    }

    def rankUsers() {
        /*
         *  Parâmetros:
         *      id -> identificador do grupo
         *      exp -> identificador do recurso exportado
         */
        println ("rankUsers() params: " + params)

        def group = Group.findById(params.groupId)
        def userGroups = UserGroup.findAllByGroup(group)
        def resourceRanking = MongoHelper.instance.getRanking(params.exportedResourceId as Long)
        def groupRanking = []
        def rankingMax = 10
        def rankingPosition = 0

        for (o in resourceRanking) {
            if (userGroups.find { it.user.id == o.userId } != null) {
                println o
                groupRanking.add(o)
                rankingPosition = rankingPosition + 1

                if (rankingPosition >= rankingMax)
                    break
            }
        }

        render groupRanking as JSON
    }
}
