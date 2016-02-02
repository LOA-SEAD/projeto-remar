package br.ufscar.sead.loa.remar

//import com.daureos.facebook.FacebookGraphService
import grails.plugin.mail.MailService
import groovy.json.JsonBuilder
import org.apache.commons.lang.RandomStringUtils
import org.camunda.bpm.engine.IdentityService
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.multipart.commons.CommonsMultipartFile

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static org.springframework.http.HttpStatus.*

import grails.transaction.Transactional
import grails.plugins.rest.client.RestBuilder
import grails.converters.JSON


@Transactional(readOnly = true)
class UserController {
    def springSecurityService
    MailService mailService
//    FacebookGraphService facebookGraphService
    def grailsApplication

    IdentityService identityService
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", filteredList: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        respond User.list(params)
    }

    def signUpSuccess(User instance) {
        render view: "show", model: [email: instance.email]
    }

    def create() {
        respond new User(params), model: [admin: false, stud: false, dev: false, source: "create"]
    }

    @Transactional(readOnly = false)
    def confirmAccount() {
        log.debug params.token
        def token = Token.findByTokenAndExpiresAtGreaterThan(params.token, new Date())
        if (token) {

            token.owner.accountLocked = false
            token.owner.enabled = true
            token.owner.save flush: true
            token.save flush: true

            SecurityContextHolder.context.authentication = new UsernamePasswordAuthenticationToken(token.owner, null,
                    token.owner.authoritiesHashSet())
            session.user = token.owner

            render(view: '/static/welcome')
        } else {
            render ":("
            response.status = 400 // TODO
        }
    }

    @Transactional(readOnly = false)
    def resetPassword() {
        if (request.method == 'GET') {
            if (params.t) { // User is comming from an email with a token
                def token = Token.findByTokenAndExpiresAtGreaterThan(params.t, new Date())

                if (!token) { // Token !exists or is older than 1 day
                    render "Token expired or not found" // TODO
                } else {
                    render view: "createPassword", model: [user: token.owner, token: params.t]
                }
            } else { // User has clicked "forgot passowrd" link
                render view: "/user/password/requestToken"
            }

        } else if (request.method == 'POST') {
            if (params.password) { // User has already defined the new password
                // TODO: enhance security (recheck token expiration etc) & handle possible errors (password != password_confirmation etc)
                def token = Token.findByToken(params.token)
                token.owner.password = params.password
                token.owner.save flush: true
                token.delete flush: true
                render "ok" // TODO
            } else { // User has entered the email & captcha
                def userIP = request.getRemoteAddr()
                def captcha = params.get("g-recaptcha-response")
                def rest = new RestBuilder()

                def resp = rest.get("https://www.google.com/recaptcha/api/siteverify?secret=${grailsApplication.config.recaptchaSecret}&response=${captcha}&remoteip=${userIP}")
                if (resp.json.success == true) {
                    def user = User.findByEmail(params.email)
                    if (user) {
                        def token = new Token(token: RandomStringUtils.random(50, true, true), owner: user, type: 'password_reset')
                        token.save flush: true
                        log.debug token.errors
                        def url = "http://${request.serverName}:${request.serverPort}/user/password/reset?t=${token.token}"
                        Util.sendEmail(user.email, "Recuperar senha",
                                "<h3><a href=\"${url}\">Clique aqui</a> para redefinir sua senha :)</h3> <br>")

                        render view: "/user/password/emailSent", model: [email: user.email]

                    } else {
                        // TODO EXIBIR FLASH MESSAGE DE EMAIL NAO ENCONTRADO
                        flash.message = message(code: 'error.mail')
                        redirect(uri: '/password/reset')
                    }

                }
            }
        }
        response.status = 405 // TODO
    }

    @Transactional
    def save(User instance) {

        def userIP = request.getRemoteAddr()
        def recaptchaResponse = params.get("g-recaptcha-response")
        def rest = new RestBuilder()
        def resp = rest.get("https://www.google.com/recaptcha/api/siteverify?" +
                "secret=${grailsApplication.config.recaptchaSecret}&response=${recaptchaResponse}&remoteip=${userIP}")
        def test = params.email.contains('@remar') // bypass captcha & email validation

        if (resp.json.success || test) {
            if (instance == null) {
                notFound()
                return
            }

            if (instance.hasErrors()) { // TODO
                respond instance.errors, view: 'create'
                return
            }

            def root = servletContext.getRealPath("/")
            def f = new File("${root}data/users/${instance.username}")
            f.mkdirs()
            def destination = new File(f, "profile-picture")
            def photo = params.photo as CommonsMultipartFile

            if (!photo.isEmpty()) {
                photo.transferTo(destination)
            } else {
                new AntBuilder().copy(file: "${root}images/avatars/default.png", tofile: destination)
            }

            instance.enabled = test
            instance.firstAccess = true

            instance.save flush: true
            def token = new Token(token: RandomStringUtils.random(50, true, true), owner: instance, type: 'email_confirmation')
            token.save flush: true
            def link = "http://${request.serverName}:${request.serverPort}/user/account/confirm/${token.token}"

            //noinspection GroovyAssignabilityCheck
            Util.sendEmail(
                    instance.email,
                    "Confirme seu email",
                    "<h3><a href=\"${link}\">Clique aqui</a> para confirmar seu email</h3>")
            redirect uri: "/signup/success/$instance.id"
        } else {
            // TODO
        }

    }

    @Transactional
    def update(User userInstance) {
        def user = User.get(params.userId)
        user.firstName = params.firstName
        user.lastName = params.lastName
        user.email = params.email
        user.gender = params.gender

        if(params.password != null && params.password == params.confirm_password) {
            user.password = params.confirm_password
        }

        if(!params.photo.isEmpty()) {
            def root = servletContext.getRealPath("/")
            def f = new File("${root}data/users/${user.username}")
            f.mkdirs()
            def destination = new File(f, "profile-picture")
            def photo = params.photo as CommonsMultipartFile

            params.photo.transferTo(destination)
        }

        /*if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view: 'edit'
            return
        }

        //Remove user from camunda to insert it again
        identityService.deleteUser(userInstance.camunda_id)

        //Remove user roles to insert it again
        UserRole.removeAll(userInstance, true)

        //reinsert the user in the camunda BD
        org.camunda.bpm.engine.identity.User camundaUser = identityService.newUser(userInstance.username)
        camundaUser.setEmail(userInstance.email)
        camundaUser.setFirstName(userInstance.firstName)
        camundaUser.setLastName(userInstance.lastName)
        camundaUser.setPassword(userInstance.password)
        identityService.saveUser(camundaUser)

        userInstance.camunda_id = camundaUser.getId()

        userInstance.save flush: true

        //Reinsert all the user roles
        if (params.ROLE_ADMIN) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_ADMIN"), true)
        }

        if (params.ROLE_PROF) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_PROF"), true)
        }

        if (params.ROLE_STUD) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_STUD"), true)
        }

        if (params.ROLE_EDITOR) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_EDITOR"), true)
        }

        if (params.ROLE_DESENVOLVEDOR) {
            UserRole.create(userInstance, Role.findByAuthority("ROLE_DESENVOLVEDOR"), true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: OK] }
        }*/
        log.debug "User " + user.username + " successfully updated"
    }

    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        UserRole.removeAll(userInstance, true)

        identityService.deleteUser(userInstance.camunda_id)

        userInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    @Transactional
    def makeDeveloper() {
        UserRole.create(springSecurityService.getCurrentUser() as User, Role.findByAuthority("ROLE_DEV"), true)
        log.debug("Usuário " + springSecurityService.getCurrentUser().firstName + " adicionado como desenvolvedor.")
        render(view: "/static/newDeveloper")
    }

    @Transactional
    def unmakeDeveloper() {
        UserRole.remove(springSecurityService.getCurrentUser() as User, Role.findByAuthority("ROLE_DEV"), true)
        log.debug("Usuário " + springSecurityService.getCurrentUser().firstName + " não é mais um desenvolvedor")
        redirect(url: "/my-profile", params: [success: true])
    }


    @Transactional
    def filteredList(String filter) {
        def query = "from User where camunda_id LIKE '%" + filter + "%' OR email LIKE '%" + filter + "%' OR username LIKE '%" + filter + "%' OR name LIKE '%" + filter + "%'"
        def list = User.executeQuery(query)

        render(template: "grid", model: [userInstanceList: list])
    }

    def filteredUserList(String filter) {
        filter = "%" + filter + "%"
        def filteredUserList = User.findAllByFirstNameOrLastNameIlikeOrEmailIlikeOrUsernameIlike(filter, filter, filter, filter, null)

        if (filteredUserList.isEmpty()) {
            render "Nenhum usuário encontrado.";
        } else {
            render template: 'filteredUsers', model: [filteredUserList: filteredUserList]
        }
    }

    def usernameAvailable() {
        println params.username
        render User.findByUsername(params.username) == null
    }

    def autocomplete() {
        List<User> allUsers = User.getAll();
        String autocompleteAlternatives = "";
        if (params.autocomplete != "") {
            for (User users : allUsers) {
                if (users.getUsername().contains(params.autocomplete)) {
                    autocompleteAlternatives += users.getUsername() + ",";
                }
            }
            log.debug(autocompleteAlternatives)
            render autocompleteAlternatives
        }
    }

    def emailAvailable() {
        render User.findByEmail(params.email) == null
    }

    def updateEmailVerifier() {
        render (User.get(params.userId).email == params.email || (User.findByEmail(params.email) == null))
    }

    def cropProfilePicture() {
        def root = servletContext.getRealPath("/")
        def f = new File("${root}data/tmp")
        f.mkdirs()
        def destination = new File(f, RandomStringUtils.random(50, true, true))
        def photo = params.photo as CommonsMultipartFile
        photo.transferTo(destination)

        def x = Math.round(params.float('x'))
        def y = Math.round(params.float('y'))
        def w = Math.round(params.float('w'))
        def h = Math.round(params.float('h'))
        BufferedImage img = ImageIO.read(destination)
        ImageIO.write(img.getSubimage(x, y, w, h),
                photo.contentType.contains('png') ? 'png' : 'jpg', destination)
        println destination.name
        render destination.name
    }

    @Transactional
    def setFalseFirstAccess(){
        String username = session.user.username;
        User userInstance = User.findByUsername(username)
        println(userInstance.firstAccess)
        userInstance.firstAccess = false;
        session.user.firstAccess = false;
        userInstance.save flush: true
    }

    @Transactional
    def setTrueFirstAccess(){
        String username = session.user.username;
        User userInstance = User.findByUsername(username)
        userInstance.firstAccess = true;
        session.user.firstAccess = true;
        userInstance.save flush: true
    }

    def myProfile() {
        def model = Moodle.findAll()

        render view: "/user/edit.gsp", model: [moodleList: model]
    }

    def getMoodleAccount(int moodleId) {
        def data = MoodleAccount.findByMoodle(Moodle.findById(moodleId))

        if(data != null) {
            if(data.owner.id == session.user.id) {
                return data
            }
            else {
                return ""
            }
        }
        else {
            return ""
        }
    }
}