package br.ufscar.sead.loa.remar

import grails.plugin.mail.MailService
import org.apache.commons.lang.RandomStringUtils
import org.apache.commons.mail.Email
import org.camunda.bpm.engine.IdentityService
import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured;
import grails.transaction.Transactional


@Transactional(readOnly = true)
class UserController {
    def springSecurityService
    MailService mailService


    IdentityService identityService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", filteredList: "POST"]

    @Secured(["ROLE_ADMIN"])
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        respond User.list(params)
    }

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def show(User userInstance) {
        respond userInstance, model:[userInstance: userInstance]
    }

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def create() {
        respond new User(params), model:[admin: false, stud: false, dev: false, source: "create"]
    }

    @Transactional(readOnly=false)
    def saveCamundaDB(userInstance){

        org.camunda.bpm.engine.identity.User camundaUser = identityService.newUser(userInstance.username)
        camundaUser.setEmail(userInstance.email)
        camundaUser.setFirstName(userInstance.name)
        camundaUser.setPassword(userInstance.password)
        userInstance.camunda_id = camundaUser.getId()
        identityService.saveUser(camundaUser)

    }
    @Transactional(readOnly=false)
    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def confirmNewUser(){

        println params.Token
        if(EmailToken.findByToken(params.Token)){
            def userId = EmailToken.findByToken(params.Token).idOwner
            def currentNewUser = User.findById(userId)
            currentNewUser.accountLocked = false
            currentNewUser.enabled = true
            currentNewUser.save()
            saveCamundaDB(currentNewUser)
            println "Token correto - cadastro liberado"
            redirect(controller: "dashboard", action: "index")
        }
        else
            render "deu errado! :("
    }

    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
    def sendConfirmationMail(userEmail,userId){


        String charset =(('A') + ('0'..'9').join())
        Integer length = 9
        String randomString = RandomStringUtils.random(length, charset.toCharArray())
        def newToken = new EmailToken(token: randomString, idOwner: userId)
        newToken.save flush: true

        mailService.sendMail {
            async true
            to userEmail
            subject "Confirmação de Cadastro"
            html '<h3>Clique no link abaixo para confirmar o cadastro</h3> <br>' +
                    '<br>' +
                    'http://localhost:8080/user/email/confirm?Token=' + newToken.token
        }

        println "metodo do email"

    }
    @Secured(["IS_AUTHENTICATED_ANONYMOUSLY"])
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


        userInstance.accountExpired = false
        userInstance.accountLocked = true //Before user confirmation
        userInstance.enabled = false        // Before user confirmation
        userInstance.passwordExpired = false



        userInstance.save flush:true

        sendConfirmationMail(userInstance.getEmail(),userInstance.getId())
        println userInstance.getEmail()
        println userInstance.getId()

        UserRole.create(userInstance, Role.findByAuthority("ROLE_USER"), true)
        UserRole.create(userInstance, Role.findByAuthority("ROLE_STUD"), true)



//        if(params.ROLE_ADMIN) {
//            UserRole.create(userInstance, Role.findByAuthority("ROLE_ADMIN"), true)
//        }



//        if(params.ROLE_DESENVOLVEDOR) {
//            UserRole.create(userInstance, Role.findByAuthority("ROLE_DESENVOLVEDOR"), true)
//        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: CREATED] }
        }
    }


    @Secured(["ROLE_ADMIN"])
    def edit(User userInstance) {
        respond userInstance, model:[admin: userInstance.isAdmin(), prof: userInstance.isProf(), stud: userInstance.isStud(), editor: userInstance.isEditor(), dev: userInstance.isDev(), source: "create", userInstance: userInstance]
    }

    @Secured(["ROLE_ADMIN"])
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

        if(params.ROLE_EDITOR) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_EDITOR"), true)
        }

        if(params.ROLE_DESENVOLVEDOR) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_DESENVOLVEDOR"), true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*'{ respond userInstance, [status: OK] }
        }
    }

    @Secured(["ROLE_ADMIN"])
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

    @Transactional
    def filteredList(String filter) {
        def query = "from User where camunda_id LIKE '%" + filter + "%' OR email LIKE '%" + filter + "%' OR username LIKE '%" + filter + "%' OR name LIKE '%" + filter + "%'"
        def list = User.executeQuery(query)

        render(template: "grid", model:[userInstanceList: list])
    }
}