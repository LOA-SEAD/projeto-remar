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
import org.springframework.transaction.annotation.Transactional
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

        if (!params.groupname || params.groupname.allWhitespace) {
            request.message = "blank_name"
            render view: "new"
            return
        } else if (params.groupname && Group.findByName(params.groupname)) {
            request.message = "name_already_exists"
            render view: "new"
            return
        } else {
            groupInstance.name = params.groupname
            groupInstance.owner = session.user
            groupInstance.token = RandomStringUtils.random(10, true, true)

            groupInstance.save flush: true, failOnError: true
        }

        redirect action: "show", id: groupInstance.id
    }

    def show(){
        def group = Group.findById(params.id)
        def userGroup = UserGroup.findByUserAndGroup(session.user,group)

        session.group = group

        if( group.owner.id == session.user.id ||  userGroup){
            def groupExportedResources = group.groupExportedResources.toList().sort({it.id})
            render(view: "show", model: [group: group, groupExportedResources: groupExportedResources])
            response.status = 200
        }else
            render status: 401, view: "../401"
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

                    /*if(!allStats.empty) {
                        allUsersGroup.each { member ->
                            if (!allStats.find { stat -> stat.get(0) != null && stat.get(0).user.id == member.id }) {
                                allStats.push(member)
                            }

                        }
                    }*/

                    allStats.sort({it.get(0).user.getName()})

                    render view: "stats", model: [allStats: allStats, group: group, exportedResource: exportedResource]

                }catch (NullPointerException e){
                    System.err.println(e.getClass().getName() + ": " + e.getMessage());
//                    redirect(action: 'stats', id: params.id)
                }

            }else{
                render status: 401, view: "../401"
            }
        }else {
            println "forbbiden"
            render status: 401, view: "../401"
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

    @Transactional
    def delete() {
        def group = Group.findById(params.id)

        if (group.owner.id == session.user.id) {
            // Delete all user-group relationships from database
            List<UserGroup> userGroups = UserGroup.findAllByGroup(group)
            for (int i = 0; i < userGroups.size(); i++)
                userGroups.get(i).delete()

            group.delete flush: true
            redirect(action: "list")
        } else
            render (status: 401, view: "../401")

    }

    @Transactional
    def update() {
        def group = Group.findById(params.groupid)
        def errors = [
                blank_name: false,
                name_already_exists: false,
                blank_token: false
        ]

        if (group == null) {
            println "GroupController.update() could not find group with id: " + params.groupid
            return
        }

        if (!params.groupname || params.groupname.allWhitespace) {
            errors.blank_name = true
        } else if (params.groupname && Group.findByName(params.groupname)) {
            errors.name_already_exists = true
        } else {
            group.name = params.groupname
        }

        if (!params.grouptoken || params.grouptoken.allWhitespace) {
            errors.blank_token = true
        } else {
            group.token = params.grouptoken
        }

        group.save flush: true
        request.error = errors

        forward action: "edit", id: params.groupid
    }

    def edit() {
        def group = Group.findById(params.id)
        def usersInGroup = []
        def usersNotInGroup= []
        session.groupid = params.id

        for (user in User.list().sort {it.getName().toLowerCase()}) {
            def userGroup = UserGroup.findByUserAndGroup(user, group)
            if (userGroup)
                usersInGroup.add([
                    userInstance: user,
                    isAdmin: userGroup.admin
                ])
            else
                usersNotInGroup.add(user)
        }
        render view: "manage", model: [group: group, usersInGroup: usersInGroup, usersNotInGroup: usersNotInGroup]
    }

    def addUsers() {
        def group = Group.findById(session.groupid)

        try {
            for (id in JSON.parse(params.users)) {
                def user = User.findById(id)
                def userGroup = new UserGroup(user: user, group: group)
                userGroup.save flush: true
            }
        } catch (e) {
            render (status: 410, text: "ERROR: Failed adding user from group")
            return
        }

        render (status: 200)
    }

    def removeUsers() {
        def group = Group.findById(session.groupid)

        try {
            for (id in JSON.parse(params.users)) {
                def user = User.findById(id)
                def userGroup = UserGroup.findByUserAndGroup(user, group)
                userGroup.delete flush: true
            }
        } catch (e) {
            render (status: 410, text: "ERROR: Failed removing user from group")
            return
        }

        render (status: 200)
    }

    def toggleUserAdminStatus() {
        def group = Group.findById(session.groupid)

        try {
            def user = User.findById(params.userid)
            def userGroup = UserGroup.findByUserAndGroup(user, group)

            userGroup.admin = !userGroup.admin
            userGroup.save flush:true
        } catch (e) {
            render (status: 410, text: "ERROR: Failed toggling user admin status")
        }
    }

    def leaveGroup(){
        User user = session.user
        def group = Group.findById(params.id)
        def userGroup = UserGroup.findByUserAndGroup(user,group)
        userGroup.delete flush: true

        redirect status: 200, action: "list"
    }

    def addUserAutocomplete() {
        def group = Group.findById(params.groupid)

        if(group.owner.id == session.user.id || UserGroup.findByUserAndGroupAndAdmin(session.user, group, true)) {
            def user = User.findById(params.userid)
            println user
            log.debug ("Attempting to add user " + params.userid + " to group " + params.groupid)
            if(user) {
                if (!UserGroup.findByUserAndGroup(user, group) && !(group.owner.id == user.id)) {
                    def userGroup = new UserGroup()
                    userGroup.group = group
                    userGroup.user = user
                    userGroup.save flush: true

                    log.debug ("Success!")
                    render status: 200, template: "newUserGroup", model: [userGroup: userGroup]
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
                    redirect action: 'show', id: group.id
                } else {
                    flash.message = "Você já pertence a este grupo."
                    redirect action: "list"
                }

            } else {
                flash.message = "Grupo não encontrado"
                redirect action: "list"
            }
        } else {
            flash.message = "Grupo não encontrado"
            redirect action: "list"
        }
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

    def rankUsers() {
        /*
         *  Parâmetros:
         *      id -> identificador do grupo
         *      exp -> identificador do recurso exportado
         */
        println ("rankUsers() params: " + params)

        def group = Group.findById(params.groupId)
        def userGroups = UserGroup.findAllByGroup(group)
        def resourceName = ExportedResource.findById(params.exportedResourceId).name
        def resourceRanking = MongoHelper.instance.getRanking(params.exportedResourceId as Long)
        def groupRanking = []
        def rankingMax = 10
        def rankingPosition = 0

        for (o in resourceRanking) {
            if (userGroups.find { it.user.id == o.userId } != null) {
                def entry = [:]
                entry.user = User.findById(o.userId)
                entry.score = o.score
                entry.timestamp = o.timestamp.format("dd/MM/yyyy HH:mm:ss")

                groupRanking.add(entry)
                rankingPosition = rankingPosition + 1

                if (rankingPosition >= rankingMax)
                    break
            }
        }

        render(view: "ranking", model: [ranking: groupRanking, resource: resourceName])
    }
}
