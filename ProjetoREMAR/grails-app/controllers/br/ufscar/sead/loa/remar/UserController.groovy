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
            } else { // User has clicked "forgot password" link
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
                    def userList = User.findAllByEmail(params.email)
                    if (userList.size() > 0) {
                        String message = "";

                        if (userList.size() == 1) {
                            def user = userList.get(0)
                            def token = new Token(token: RandomStringUtils.random(50, true, true), owner: user, type: 'password_reset')
                            token.save flush: true
                            log.debug token.errors
                            def url = "http://${request.serverName}/user/password/reset?t=${token.token}"

                            message += "<h3>Prezado(a) ${user.firstName} ${user.lastName},  </h3> <br>" +
                                    "<p>Voc&ecirc; encontra-se cadastrado(a) com o username: ${user.username} </p> <br>" +
                                    "<p>Para dar continuidade a sua solicita&ccedil;&atilde;o, acesse o link  abaixo. </p> <br>" +
                                    "<p> ${url} </p> <br>" +
                                    "Atenciosamente, <br>" +
                                    "<br>" +
                                    "Equipe REMAR <br>" +
                                    "Recursos Educacionais Multiplataforma Abertos na Rede <br>" +
                                    "<br>" +
                                    "<hr>" +
                                    "Este &eacute; um e-mail autom&aacute;tico. N&atilde;o &eacute; necess&aacute;rio respond&ecirc;-lo. <br>" +
                                    "<br>" +
                                    "Caso tenha recebido esta mensagem por engano, por favor, apague-a.  <br>" +
                                    "<br>" +
                                    "Agradecemos sua coopera&ccedil;&atilde;o. <br>" +
                                    "<hr>"
                       } else {
                            message += "<h3>Prezado(a), </h3> <br>" +
                                    "<p>Seu email ${param.email} encontra-se associado a diferentes usu&aacute;rios.</p><br>" +
                                    "<p>Para dar continuidade a sua solicita&ccedil;&atilde;o, acesse o link correspondente ao(s) usu&aacute;rio(s) desejado(s).</p> <br>" +
                                    "<table style=\"border: 1px solid black;\" border=\"1\">" +
                                    "<tbody>" +
                                    "<tr>" +
                                    "<td align=\"center\">username</td>" +
                                    "<td align=\"center\">link</td>" +
                                    "</tr>"

                            userList.each { user ->
                                def token = new Token(token: RandomStringUtils.random(50, true, true), owner: user, type: 'password_reset')
                                token.save flush: true
                                log.debug token.errors
                                def url = "http://${request.serverName}/user/password/reset?t=${token.token}"
                                message += "<tr>" +
                                        "<td align=\"center\">${user.username}</td>" +
                                        "<td>${url}</td>" +
                                        "</tr>"
                            }

                            message += "</tbody>" +
                                    "</table>" +
                                    "<br>" +
                                    "Atenciosamente, <br>" +
                                    "<br>" +
                                    "Equipe REMAR <br>" +
                                    "Recursos Educacionais Multiplataforma Abertos na Rede <br>" +
                                    "<br>" +
                                    "<hr>" +
                                    "Este &eacute; um e-mail autom&aacute;tico. N&atilde;o &eacute; necess&aacute;rio respond&ecirc;-lo. <br>" +
                                    "<br>" +
                                    "Caso tenha recebido esta mensagem por engano, por favor, apague-a.  <br>" +
                                    "<br>" +
                                    "Agradecemos sua coopera&ccedil;&atilde;o. <br>" +
                                    "<hr>"
                        }
                        println message

                        //Util.sendEmail(user.email, "Recuperar dados cadastrados", message)

                        render view: "/user/password/emailSent", model: [email: params.email]
                    } else {
                        flash.message = message(code: "error.mail")
                        render view: "/user/password/requestToken"
                    }
                    // User hasn't fullfiled the captcha.
                } else {
                    flash.message = message(code: "error.captcha")
                    render view: "/user/password/requestToken"
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
                    "${link} <br><br>" +
                    "Atenciosamente, <br>" +
                    "<br>" +
                    "Equipe REMAR <br>" +
                    "Recursos Educacionais Multiplataforma Abertos na Rede <br>" +
                    "<br>" +
                    "**********************************************************************<br>" +
                    "Este &eacute; um e-mail autom&aacute;tico. N&atilde;o &eacute; necess&aacute;rio respond&ecirc;-lo. <br>" +
                    "<br>" +
                    "Caso tenha recebido esta mensagem por engano, por favor, apague-a.  <br>" +
                    "<br>" +
                    "Agradecemos sua coopera&ccedil;&atilde;o. <br>" +
                    "**********************************************************************"

            Util.sendEmail(instance.email, "Cadastro - REMAR", mensagem)
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
    def updatePhoto(User user) {
        def root = servletContext.getRealPath("/")
        def f = new File("${root}data/users/${user.username}")
        f.mkdirs()

        println "Photo: ${params.photo}"
        def img = new File(servletContext.getRealPath("${params.photo}"))
        img.renameTo(new File(f, "profile-picture"))

        user.save flush: true
        session.user = user

        // Pausa necessária para que a foto de perfil seja trocada, a tempo, sem que o refresh sobrescreva a atualização
        // e volte a mostrar a foto antiga
        sleep(10)

        redirect uri: "/my-profile?photoUpdated=t";
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
        def user = springSecurityService.getCurrentUser() as User
        UserRole.create(user, Role.findByAuthority("ROLE_DEV"), true)
        log.debug("Usuário " + springSecurityService.getCurrentUser().firstName + " adicionado como desenvolvedor.")
        springSecurityService.reauthenticate user.username
        redirect(url: "/my-profile", params: [success: true])
    }

    @Transactional
    def updateUser() {
        render(view: "/static/updateUser")
    }

    @Transactional
    def unmakeDeveloper() {
        def user = springSecurityService.getCurrentUser() as User
        UserRole.remove(user, Role.findByAuthority("ROLE_DEV"), true)
        log.debug("Usuário " + springSecurityService.getCurrentUser().firstName + " não é mais um desenvolvedor")
        springSecurityService.reauthenticate user.username
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
            def allUsers = ((firstName + lastName + userName) as Set).sort { it.firstName.toUpperCase() }

            def group = Group.findById(params.group)
            def list = allUsers.collect {
                def inGroup = UserGroup.findByUserAndGroup(it, group) ? true : false
                [
                        label  : "${it.firstName} ${it.lastName} ($it.username)",
                        value  : it.id,
                        inGroup: inGroup
                ]
            }

            render list as JSON

        } else {
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

        UserRole.removeAll(userInstance, true)

        // Remove Tokens that belong to the user
        List<Token> tokens = Token.findAllByOwner(userInstance)
        for (int i = 0; i < tokens.size(); i++)
            tokens.get(i).delete()

        // Remove Resources that belong to the user
        List<Resource> resources = Resource.findAllByOwner(userInstance)
        for (int i = 0; i < resources.size(); i++)
            resources.get(i).delete()

        // Remove Exported Resources that belong to the user
        List<ExportedResource> exportedResources = ExportedResource.findAllByOwner(userInstance)
        for (int i = 0; i < exportedResources.size(); i++)
            exportedResources.get(i).delete()

        // Remove groups that belong to the user
        List<Group> groups = Group.findAllByOwner(userInstance)
        for (int i = 0; i < groups.size(); i++)
            groups.get(i).delete()

        // Remove user-group relationships
        UserGroup.removeAllByUser(userInstance, true)

        userInstance.delete flush: true
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

    def userProfile() {
        User user = User.get(params.id);
        render view: "_userProfileModal", model: [user: user]
    }
}
