package br.ufscar.sead.loa.remar

import com.mongodb.util.JSON
import grails.converters.JSON
import groovy.json.JsonBuilder
import org.apache.commons.lang.RandomStringUtils
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.multipart.commons.CommonsMultipartFile

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static org.springframework.http.HttpStatus.*

import grails.transaction.Transactional
import grails.plugins.rest.client.RestBuilder


@Transactional(readOnly = true)
class UserController {
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", filteredList: "POST"]

    def springSecurityService
    def grailsApplication

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
                    render view: "/user/password/create", model: [user: token.owner, token: params.t]
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
                render view: "/user/password/done"
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
                        def mensagem = "<h3>Prezado(a) ${user.firstName} ${user.lastName},  </h3> <br>" +
                                "<p>Você encontra-se cadastrado(a) com o username: ${user.username} </p> <br>" +
                                "<p>Para dar continuidade a sua solicitação, acesse o link  abaixo. </p> <br>" +
                                "<p> ${url} </p> <br>" +
                                "Atenciosamente, <br>" +
                                "<br>" +
                                "Equipe REMAR <br>" +
                                "Recursos Educacionais Multiplataforma Abertos na Rede <br>" +
                                "<br>" +
                                "**********************************************************************<br>" +
                                "Este é um e-mail automático. Não é necessário respondê-lo. <br>" +
                                "<br>" +
                                "Caso tenha recebido esta mensagem por engano, por favor, apague-a.  <br>" +
                                "<br>" +
                                "Agradecemos sua cooperação. <br>" +
                                "**********************************************************************"
                        Util.sendEmail(user.email, "Recuperar dados cadastrados", mensagem)

                        render view: "/user/password/emailSent", model: [email: user.email]
                    } else {
                        flash.message = 'email not found'
                        render view: "/user/password/requestToken"
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

            if (params.photo != "/images/avatars/default.png") {
                def img1 = new File(servletContext.getRealPath("${params.photo}"))
                img1.renameTo(new File(f, "profile-picture"))

            } else {
                new AntBuilder().copy(file: "${root}images/avatars/default.png", tofile: destination)
            }

            instance.enabled = test
            instance.firstAccess = true

            instance.save flush: true
            def token = new Token(token: RandomStringUtils.random(50, true, true), owner: instance, type: 'email_confirmation')
            token.save flush: true
            def link = "http://${request.serverName}:${request.serverPort}/user/account/confirm/${token.token}"

            // noinspection GroovyAssignabilityCheck
            def mensagem = "<h3>Prezado(a) ${instance.firstName} ${instance.lastName},  </h3> <br>" +
                                "<p>Seu cadastro, username ${instance.username}, foi realizado com sucesso.</p> <br>" +
                                "<p>Para confirmar seu cadastro, acesse o link  abaixo. </p> <br>" +
                                "<p> ${link} </p> <br>" +
                                "Atenciosamente, <br>" +
                                "<br>" +
                                "Equipe REMAR <br>" +
                                "Recursos Educacionais Multiplataforma Abertos na Rede <br>" +
                                "<br>" +
                                "**********************************************************************<br>" +
                                "Este é um e-mail automático. Não é necessário respondê-lo. <br>" +
                                "<br>" +
                                "Caso tenha recebido esta mensagem por engano, por favor, apague-a.  <br>" +
                                "<br>" +
                                "Agradecemos sua cooperação. <br>" +
                                "**********************************************************************"
            Util.sendEmail(instance.email, "Confirmação de Cadastro", mensagem)
            redirect uri: "/signup/success/$instance.id"
        } else {
            // TODO
        }

    }

    @Transactional
    def update(User user) {

        if (params.password != "" && params.password == params.confirm_password) {
            user.password = params.confirm_password
        } else {
            user.password = user.getPersistentValue("password")
        }

        def root = servletContext.getRealPath("/")
        def f = new File("${root}data/users/${user.username}")
        f.mkdirs()

        if (params.photo != "/images/avatars/default.png") {
            def img1 = new File(servletContext.getRealPath("${params.photo}"))
            img1.renameTo(new File(f, "profile-picture"))

        }
        user.save flush: true

        session.user = user

        redirect uri: "/my-profile?profileUpdated=t";
    }

    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        UserRole.removeAll(userInstance, true)

        List<Token> list = Token.findAllByOwner(userInstance)
        for (int i = 0; i < list.size(); i++)
            list.get(i).delete()

        List<Resource> myResources = Resource.findAllByOwner(userInstance)
        for (int i = 0; i < myResources.size(); i++)
            myResources.get(i).delete()

        List<ExportedResource> myExportedResources = ExportedResource.findAllByOwner(userInstance)
        for (int i = 0; i < myExportedResources.size(); i++)
            myExportedResources.get(i).delete()


        userInstance.delete flush: true

        redirect view: "/index/index.gsp"
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
    def updateUser() {
        render(view: "/static/updateUser")
    }

    @Transactional
    def unmakeDeveloper() {
        UserRole.remove(springSecurityService.getCurrentUser() as User, Role.findByAuthority("ROLE_DEV"), true)
        log.debug("Usuário " + springSecurityService.getCurrentUser().firstName + " não é mais um desenvolvedor")
        redirect(url: "/my-profile", params: [success: true])
    }

    def usernameAvailable() {
        render User.findByUsername(params.username) == null
    }

    def autocomplete() {
        if (params.query != "") {
            def firstName = User.findAllByFirstNameRlike(params.query, params.query, params.query)
            def lastName = User.findAllByLastNameRlike(params.query, params.query, params.query)
            def userName = User.findAllByUsernameRlike(params.query, params.query, params.query)
            def allUsers = ((firstName + lastName + userName) as Set).sort{it.firstName.toUpperCase()}
            
            def group = Group.findById(params.group)
            def list = allUsers.collect {
                def inGroup = UserGroup.findByUserAndGroup(it, group) ? true : false
                    [
                            label: "${it.firstName} ${it.lastName}",
                            value: it.id,
                            inGroup: inGroup
                    ]
                }

            render list as JSON

        }else{
//            TODO
        }

    }

    def emailAvailable() {
        render User.findByEmail(params.email) == null
    }

    def updateEmailVerifier() {
        render(User.get(params.userId).email == params.email || (User.findByEmail(params.email) == null))
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
    def setFalseFirstAccess() {
        String username = session.user.username;
        User userInstance = User.findByUsername(username)
        println(userInstance.firstAccess)
        userInstance.firstAccess = false;
        session.user.firstAccess = false;
        userInstance.save flush: true
    }

    @Transactional
    def setTrueFirstAccess() {
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

    @Transactional
    def disableAccount() {
        User userInstance = springSecurityService.getCurrentUser()
        userInstance.enabled = false
        userInstance.save flush: true
        redirect uri: "/logout/index"
    }

    @Transactional
    def deleteAccount() {
        User userInstance = springSecurityService.getCurrentUser()
        delete(userInstance)
    }

    @Transactional
    def recoverUserAccount(String email) {
        User userInstance = User.findByEmail(email)

        if (userInstance != null) {
            userInstance.enabled = true
            userInstance.save flush: true
            render view: "../user/accountRecovered"

        } else
            render "E-mail inválido"
    }


    def getMoodleAccount(int moodleId) {
        def data = MoodleAccount.findByMoodleAndOwner(Moodle.findById(moodleId), User.findById(session.user.id))

        if (data != null) {
            return data
        } else {
            return ""
        }
    }

    @Transactional
    def userProfile() {
        User user = User.get(params.id);
        render view: "_userProfileModal", model: [user: user]
    }
}
