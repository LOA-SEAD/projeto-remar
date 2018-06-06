package br.ufscar.sead.loa.remar

import br.ufscar.sead.loa.propeller.Propeller
import br.ufscar.sead.loa.remar.statistics.StatisticFactory
import br.ufscar.sead.loa.remar.statistics.Statistics
import com.mongodb.Block
import com.mongodb.DBCursor
import grails.converters.JSON
import groovy.json.JsonBuilder
import org.apache.commons.lang.RandomStringUtils
import grails.plugin.springsecurity.annotation.Secured
import org.bson.Document
import org.bson.types.ObjectId

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

    def create() {
        def groupInstance = new Group()

        groupInstance.owner = session.user
        groupInstance.name = params.groupname

        try {
            groupInstance.token = RandomStringUtils.random(10, true, true)
            groupInstance.save flush: true, failOnError: true

        } catch (ValidationException e) {
            //TODO
        }

        render groupInstance.id

    }

    def show() {
        def group = Group.findById(params.id)
        def userGroup = UserGroup.findByUserAndGroup(session.user, group)

        if (group.owner.id == session.user.id || userGroup) {
            def groupExportedResources = group.groupExportedResources.toList().sort({ it.id })
            render(view: "show", model: [group: group, groupExportedResources: groupExportedResources])
            response.status = 200
        } else
            render(status: 401, view: "../401")
    }

    def isLogged() {
        println params
        if (params.choice != "null") {
            if (params.choice == "offline") {
                println "ok"
                render status: 200
            } else if (params.choice == "login") {
                println "login in"
                springSecurityService.reauthenticate(params.username, params.password)
                if (springSecurityService.isLoggedIn()) {
                    session.user = springSecurityService.getCurrentUser()
                    println "logged!"
                    render status: 200
                } else {
                    println "didnt find user"
                    render status: 401, template: "stats/login"
                }
            }
        } else {
            render status: 401, template: "stats/login"
        }
    }

    def stats() {
        def group = Group.findById(params.id)
        def isMultiple = false //Variável para determinar se um jogo é multiplo ou não
        def hasContent = false //Variável para determinar se foi passado conteúdo à view
        def gameLevel = [:] //Usado apenas para games com multiplos levels

        if (session.user.id == group.owner.id || UserGroup.findByUserAndAdmin(session.user, true)) {
            def exportedResource = ExportedResource.findById(params.exp)
            def process = Propeller.instance.getProcessInstanceById(exportedResource.processId as String, session.user.id as long)
            if (exportedResource) {
                def allUsersGroup = UserGroup.findAllByGroup(group).user
                def queryMongo
                try {
                    queryMongo = MongoHelper.instance.getStats("stats", exportedResource.id as Integer, allUsersGroup.id.toList())

                    //Array que guardará os stats a serem enviados par a view
                    def allStats = []

                    //Array que guardará os stats especificos a serem guardados no allStats
                    def _stat

                    for (int i = 0; i < queryMongo.size(); i++) {
                        //Find em todos os usuários do grupo
                        def user = allUsersGroup.find { user -> user.id == queryMongo.get(i).userId || group.owner.id == queryMongo.get(i).userId }
                        _stat = [[user: user]]

                        queryMongo.get(i).stats.each {
                            //Para cada stats obtido, pega apenas o que o jogo para obter os stats for igual aos da consulta
                            if (it.exportedResourceId == exportedResource.id) {
                                //Popula um map gameLevel para enviar à view.
                                //Keys: numeros das fases no propeller (apenas as personalizadas)
                                //Values: respectivos nomes das fases no propeller (apenas as personalizadas)

                                if (it.gameLevel) {
                                    gameLevel.put(it.gameLevel, [name: it.gameLevelName, size: it.gameSize])
                                    //Se encontrar um gameLevel, então significa que o jogo é do tipo multiplo
                                    isMultiple = true
                                }
                                _stat.push([challengeId: it.challengeId, win: it.win, gameSize: it.gameSize, gameLevel: it.gameLevel])
                            }
                        }
                        // Ao fim de cada acumulo de estatistica de um respectivo usuario, dá-se o push dele e suas estatisticas no array allStats
                        allStats.push(_stat)
                        hasContent = true
                    }

                    // Se o jogo for multiplo, o array de estatísticas já obtido anteriormente precisa ser rearranjado.
                    // Para melhor manipulação na view, este array se tornará um map de maps.
                    // Main Map: key = user ids // values =  conjunto de estatisticas do usuario
                    // Sub Maps: key = numero da fase // values = estatisticas da respectiva fase
                    if (isMultiple) {

                        // Remove os usuários de cada array presente no array allStats
                        allStats.each {
                            it.remove(0)
                        }

                        // TreeMap (chave de ordenação nome do usuário)

                        def userStatsMap = new TreeMap(new Comparator() {
                            @Override
                            int compare(Object o1, Object o2) {
                                User u1 = ((ArrayList) o1).get(0).user;
                                User u2 = ((ArrayList) o2).get(0).user;

                                return u1.firstName.compareToIgnoreCase(u2.firstName)
                            }
                        })

                        // Novo percorrer da consulta para repopular os usuários, considerando agora o tipo multiplo

                        for (int i = 0; i < queryMongo.size(); i++) {
                            def statsMap = [:]
                            def user = allUsersGroup.find { user -> user.id == queryMongo.get(i).userId || group.owner.id == queryMongo.get(i).userId }
                            _stat = [[user: user]]

                            // Coleção com closure passado para remover os gameLevel das estatísticas, de forma que ele seja, agora, uma chave e não um atributo
                            def removeGI = allStats.get(i).collect() {
                                def tempMap = [:]
                                def gInd = it.gameLevel
                                it.remove("gameLevel")
                                tempMap.put(gInd, it)
                                tempMap // retorno do collect()
                            }

                            //Para cada numero de fase, busca-se na coleção se existe aquela chave, e cria-se um novo hash (combinando repetições), que será:
                            //Key = numero da fase
                            //Value = estatísticas da fase
                            gameLevel.keySet().each() {
                                def gInd = it
                                def indexList = removeGI.findAll() { it.containsKey(gInd) }
                                def valuesList = indexList.collect() { it.get(gInd) }
                                statsMap.put(gInd, valuesList)
                            }

                            // Por fim cria-se um hash cuja key será o id do usuário, e values todos seus stats
                            userStatsMap.put(_stat, statsMap)
                            hasContent = true
                        }

                        render view: "stats", model: [userStatsMap: userStatsMap, group: group, exportedResource: exportedResource,
                                                      gameLevel   : gameLevel, isMultiple: isMultiple, hasContent: hasContent]
                    } else {

                        // Ordena a lista antes de envio para a visão (chave de ordenação - nome do usuário)

                        Collections.sort(allStats, new Comparator() {
                            @Override
                            public int compare(Object o1, Object o2) {
                                User u1 = ((ArrayList) o1).get(0).user;
                                User u2 = ((ArrayList) o2).get(0).user;

                                return u1.firstName.compareToIgnoreCase(u2.firstName)
                            }
                        });

                        // Se não for multiplo, manda-se apenas os atributos necessários

                        render view: "stats", model: [allStats: allStats, group: group, exportedResource: exportedResource, isMultiple: isMultiple, hasContent: hasContent]
                    }

                    // Descomentar caso desejar mostrar os membros SEM estatísticas
                    /*if(!allStats.empty) {
                        allUsersGroup.each { member ->
                            if (!allStats.find { stat -> stat.get(0) != null && stat.get(0).user.id == member.id }) {
                                allStats.push(member)
                            }

                        }
                    }*/

                    //allStats.sort({it.get(0).user.getName()})

                } catch (NullPointerException e) {
                    System.err.println(e.getClass().getName() + ": " + e.getMessage());
//                    redirect(action: 'stats', id: params.id)
                }

            } else {
                render(status: 401, view: "../401")
            }
        } else {
            println "fobbiden"
            render(status: 401, view: "../401")
        }

    }

    def userStats() {
        def user = User.findById(params.id)
        def exportedResource = ExportedResource.findById(params.exp)

        // Os parâmetros abaixo são recebidos apenas quando o jogo é do tipo Multiplo
        def gameLevel = params.level; // Numero da fase
        def levelName = params.levelName; // Nome da fase

        if (user) {
            def queryMongo = MongoHelper.instance.getStats('stats', params.exp as int, user.id)
            def allStats = []
            queryMongo.forEach(new Block<Document>() {
                @Override
                void apply(Document document) {
                    document.stats.each {
                        if (it.exportedResourceId == exportedResource.id) {

                            //Verificação realizada para filtrar, tambem, pelo gameLevel quando o jogo é multiplo

                            if (gameLevel == null || it.gameLevel == gameLevel as int) {
                                if (it.challengeId == params.challenge as int) {

                                    // Estratégia utilizada para padronizar a população de dados e o respectivo retorno (economia de ifs e switches)
                                    StatisticFactory factory = StatisticFactory.instance;
                                    Statistics statistics = factory.createStatistics(it.gameType as String)

                                    def data = statistics.getData(it);

                                    allStats.push(data)
                                }
                            }
                        }
                    }
                }
            })

            render view: "userStats", model: [allStats : allStats, user: user, exportedResource: exportedResource,
                                              levelName: levelName]
        }
    }

    @Transactional
    def delete() {
        def group = Group.findById(params.id)
        if (group.owner.id == session.user.id) {
            group.delete flush: true
            redirect(action: "list")
        } else
            render(status: 401, view: "../401")

    }

    @Transactional
    def update() {
        def group = Group.findById(params.groupid)

        if (group == null) {
            println "GroupController.update() could not find group with id: " + params.groupid
            return
        }

        group.name = params.groupname
        group.token = params.grouptoken
        group.save flush: true

        forward action: "edit", id: params.groupid
    }

    def edit() {
        def group = Group.findById(params.id)

        def usersInGroup = []
        def usersNotInGroup = []

        for (user in User.list(sort: "firstName")) {
            if (UserGroup.findByUserAndGroup(user, group))
                usersInGroup.add(user)
            else
                usersNotInGroup.add(user)
        }

        render view: "manage", model: [group: group, usersInGroup: usersInGroup, usersNotInGroup: usersNotInGroup]
    }

    def addUsers() {
        def group = Group.findById(params.groupid)

        for (id in JSON.parse(params.users)) {
            def user = User.findById(id)
            def userGroup = new UserGroup(user: user, group: group)
            userGroup.save flush: true
        }

        forward action: "edit", id: params.groupid
    }

    def removeUsers() {
        def group = Group.findById(params.groupid)

        for (id in JSON.parse(params.users)) {
            def user = User.findById(id)
            def userGroup = UserGroup.findByUserAndGroup(user, group)
            userGroup.delete flush: true
        }

        forward action: "edit", id: params.groupid
    }

    def leaveGroup() {
        User user = session.user
        def group = Group.findById(params.id)
        def userGroup = UserGroup.findByUserAndGroup(user, group)
        userGroup.delete flush: true
        redirect(status: 200, action: "list")
    }

    def addUserAutocomplete() {
        def group = Group.findById(params.groupid)

        if (group.owner.id == session.user.id || UserGroup.findByUserAndGroupAndAdmin(session.user, group, true)) {
            def user = User.findById(params.userid)
            println user
            log.debug("Attempting to add user " + params.userid + " to group " + params.groupid)
            if (user) {
                if (!UserGroup.findByUserAndGroup(user, group) && !(group.owner.id == user.id)) {
                    def userGroup = new UserGroup()
                    userGroup.group = group
                    userGroup.user = user
                    userGroup.save flush: true

                    log.debug("Success!")
                    render status: 200, template: "newUserGroup", model: [userGroup: userGroup]
                } else {
                    log.debug("Failed! User is already in group.")
                    render status: 403, text: "Usuário já pertence ao grupo."
                }
            } else {
                log.debug("Failed! User not found.")
                render status: 404, text: "Usuário não encontrado."
            }
        }
    }

    def addUserByToken() {
        if (params.membertoken != "") {
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

    def addUserById() {
        def group = Group.findById(params.groupId)
        def user = User.findById(params.userId)
        def userGroup = new UserGroup()

        if (user) {
            userGroup.group = group
            userGroup.user = user
            userGroup.save flush: true
        }
    }

    def findGroup() {
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
        println("rankUsers() params: " + params)

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


