package br.ufscar.sead.loa.remar

import org.camunda.bpm.engine.IdentityService
import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured;
import grails.transaction.Transactional

@Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
@Transactional(readOnly = true)
class UserController {

    IdentityService identityService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        respond User.list(params)
    }

    def show(User userInstance) {
        //respond userInstance
        respond userInstance, model:[roles: UserRole.findAllByUser(userInstance).collect {it.role}]
    }

    def create() {
        respond new User(params), model:[admin: false, prof: false, stud: false, source: "create"]
    }

    @Transactional
    def save(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'create'
            return
        }

        org.camunda.bpm.engine.identity.User camundaUser = identityService.newUser(userInstance.username)
        camundaUser.setEmail(userInstance.email)
        camundaUser.setFirstName(userInstance.name)
        camundaUser.setPassword(userInstance.password)
        identityService.saveUser(camundaUser)

        userInstance.camunda_id = camundaUser.getId()

        userInstance.save flush:true

        if(params.ROLE_ADMIN) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_ADMIN"), true)
        }

        if(params.ROLE_PROF) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_PROF"), true)
        }

        if(params.ROLE_STUD) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_STUD"), true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: CREATED] }
        }
    }

    def edit(User userInstance) {
        respond userInstance, model:[admin: userInstance.isAdmin(), prof: userInstance.isProf(), stud: userInstance.isStud(), source: "create"]
    }

    @Transactional
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'edit'
            return
        }

        //Remove user from camunda to insert it again
        identityService.deleteUser(userInstance.camunda_id)

        //Remove user roles to insert it again
        UserRole.removeAll(userInstance, true)

        //reinsert the user in the camunda BD
        org.camunda.bpm.engine.identity.User camundaUser = identityService.newUser(userInstance.username)
        camundaUser.setEmail(userInstance.email)
        camundaUser.setFirstName(userInstance.name)
        camundaUser.setPassword(userInstance.password)
        identityService.saveUser(camundaUser)

        userInstance.camunda_id = camundaUser.getId()

        userInstance.save flush:true

        //Reinsert all the user roles
        if(params.ROLE_ADMIN) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_ADMIN"), true)
        }

        if(params.ROLE_PROF) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_PROF"), true)
        }

        if(params.ROLE_STUD) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_STUD"), true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*'{ respond userInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        UserRole.removeAll(userInstance, true)

        identityService.deleteUser(userInstance.camunda_id)

        userInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def filteredList(String filter) {
        def query = "from User where camunda_id LIKE '%" + filter + "%' OR email LIKE '%" + filter + "%' OR username LIKE '%" + filter + "%' OR name LIKE '%" + filter + "%'"
        def list = User.executeQuery(query)

        list.each { item ->
            println(item.username)
        }

        //respond list, model:[userInstanceCount: User.count(), filter: filter]
        render(template: "grid", model:[userInstanceList: list])
    }

    /*def index(String filter) {
        def query = "from User where camunda_id LIKE '%" + filter + "%'"
        def list = User.executeQuery(query)

        list.each { item ->
            println(item.username)
        }

        //respond list, model:[userInstanceCount: User.count(), filter: filter]
        render(template: "grid", model:[userInstanceList: list, userInstanceCount: 6, filter: filter])
    }*/
}