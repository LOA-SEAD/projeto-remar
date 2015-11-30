package br.ufscar.sead.loa.remar

//import com.daureos.facebook.FacebookGraphService
import grails.plugin.mail.MailService
import grails.util.Environment
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

    IdentityService identityService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", filteredList: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        respond User.list(params)
    }

    def signUpSuccess(User instance) {
        render view: "show", model: [email: instance.email]
    }

    def create() {
        respond new User(params), model:[admin: false, stud: false, dev: false, source: "create"]
    }

    def test() {
        render view: "test"
    }

    @Transactional(readOnly=false)
    def confirmAccount() {
        def token = EmailToken.findByTokenAndValid(params.token, true)
        if(token) {
            def user = User.findById(token.idOwner)

            user.accountLocked = false
            user.enabled = true
            token.valid = false
            user.save flush: true
            token.save flush: true

            SecurityContextHolder.context.authentication = new UsernamePasswordAuthenticationToken(user, null,
                    user.authoritiesHashSet())
            session.user = user

            render(view: '/static/welcome')
        } else {
            response.status = 400 // TODO
        }
    }

    def sendConfirmationMail(userEmail, userId) {
        def token = new EmailToken(token: RandomStringUtils.random(30, true, true), idOwner: userId, valid: true)
        token.save flush: true

        mailService.sendMail {
            async true
            to userEmail
            subject "REMAR – Confirmação de cadastro"
            html '<h3>Clique no link abaixo para confirmar seu cadastro</h3> <br>' +
                    '<br>' +
                    "http://${request.serverName}:${request.serverPort}/user/account/confirm/${token.token}"
        }
    }
    @Transactional(readOnly=false)
    def newPassword(){
        // vai receber aqui a nova senha por post


        if(params.newPassword == params.confirmPassword){
            def user = User.findById(params.userid)
//            user.passwordExpired = false      NAO!
            user.password = params.confirmPassword
            user.accountLocked = false
            user.accountExpired = false
            log.debug "password alterado"

        }


    }

    @Transactional(readOnly=false)
    def createPassword(){
        if(PasswordToken.findByToken(params.Token)){
            def userToChange = User.findById(PasswordToken.findByToken(params.Token).idOwner)
            respond("", model: [user: userToChange.id])

        }
        else{
            // renderizar pagina de erro, token errado
            render "token errado ou expirado"
        }
    }
    @Transactional(readOnly=false)
    def confirmEmail() {
        def userIP = request.getRemoteAddr()

        def captcha = params.get("g-recaptcha-response")

        def rest = new RestBuilder()

        def resp = rest.get("https://www.google.com/recaptcha/api/siteverify?secret=6LdA8QkTAAAAACHA9KoBPT1BXXBrJpQNJfCGTm9x&response=" + captcha + "&remoteip=" + userIP)
        println resp.json as JSON
        if (resp.json.success == true) {
            println params.email
            println User.findByEmail(params.email)
            if (User.findByEmail(params.email)) {
                log.debug User.findByEmail(params.email)
                //User.findByEmail(params.email).passwordExpired = true  NAO!
                String charset = (('A') + ('0'..'9').join())
                Integer length = 9
                String randomString = RandomStringUtils.random(length, charset.toCharArray())
                def newToken = new PasswordToken(token: randomString, idOwner: User.findByEmail(params.email).getId())
                newToken.save flush: true

                mailService.sendMail {
                    async true
                    to params.email
                    subject "Nova senha para o REMAR"
                    html '<h3>Clique no link abaixo para fazer uma nova senha</h3> <br>' +
                            '<br>' +
                            "http://${request.serverName}:${request.serverPort}/user/newpassword/confirm?Token=${newToken.getToken()}"

                }

                render(view: "/static/emailsent")

            } else {
                // TODO EXIBIR FLASH MESSAGE DE EMAIL  NAO ENCONTRADO
                flash.message = message(code: 'error.mail')
                redirect(uri: '/password/reset')
            }

        }
    }

    @Transactional
    def save(User instance) {

        def userIP = request.getRemoteAddr()
        def recaptchaResponse = params.get("g-recaptcha-response")
        def rest = new RestBuilder()
        def resp = rest.get("https://www.google.com/recaptcha/api/siteverify?" +
                "secret=6LdA8QkTAAAAACHA9KoBPT1BXXBrJpQNJfCGTm9x&response=${recaptchaResponse}&remoteip=${userIP}")
        def test = params.email.contains('@remar') // bypass captcha & email validation

        if(resp.json.success || test){
            if (instance == null) {
                notFound()
                return
            }

            if (instance.hasErrors()) { // TODO
                respond instance.errors, view:'create'
                return
            }

            def root = servletContext.getRealPath("/")
            def f = new File("${root}data/users/${instance.username}")
            f.mkdirs()
            def destination = new File(f, "profile-picture")
            def photo = params.photo as CommonsMultipartFile

            if(!photo.isEmpty()) {
                photo.transferTo(destination)
            } else {
                new AntBuilder().copy(file: "${root}images/avatars/${instance.gender}.png", tofile: destination)
            }

            instance.enabled = test

            instance.save flush: true
            sendConfirmationMail(instance.getEmail(), instance.getId())

            redirect uri: "/signup/success/$instance.id"
        } else {
            // TODO
        }

    }


    def edit(User userInstance) {
        respond userInstance, model:[admin: userInstance.isAdmin(), prof: userInstance.isProf(), stud: userInstance.isStud(), editor: userInstance.isEditor(), dev: userInstance.isDev(), source: "create", userInstance: userInstance]
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
        camundaUser.setFirstName(userInstance.firstName)
        camundaUser.setLastName(userInstance.lastName)
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
    def makeDeveloper() {
        UserRole.create(springSecurityService.getCurrentUser() as User, Role.findByAuthority("ROLE_DEV"), true)
        log.debug("Deu Certo")
        log.debug(params.fullName)
        render(view:"/static/newDeveloper")

    }



    @Transactional
    def filteredList(String filter) {
        def query = "from User where camunda_id LIKE '%" + filter + "%' OR email LIKE '%" + filter + "%' OR username LIKE '%" + filter + "%' OR name LIKE '%" + filter + "%'"
        def list = User.executeQuery(query)

        render(template: "grid", model:[userInstanceList: list])
    }

    def filteredUserList(String filter) {
        filter = "%"+filter+"%"
        def filteredUserList = User.findAllByFirstNameOrLastNameIlikeOrEmailIlikeOrUsernameIlike(filter, filter, filter, filter, null)

        if(filteredUserList.isEmpty()) {
            render "Nenhum usuário encontrado.";
        }
        else {
            render template: 'filteredUsers', model: [filteredUserList: filteredUserList]
        }
    }

    def usernameAvailable(){
        println params.username
        render User.findByUsername(params.username) == null
    }

    def autocomplete() {
        List<User> allUsers = User.getAll();
        String autocompleteAlternatives = "";
        if (params.autocomplete !="") {
            for (User users : allUsers) {
                if (users.getUsername().contains(params.autocomplete)) {
                    autocompleteAlternatives +=users.getUsername() + ",";
                }
            }
            log.debug(autocompleteAlternatives)
            render autocompleteAlternatives
        }
    }

    def emailAvailable(){
        render User.findByEmail(params.email) == null
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
                      photo.contentType.contains('png')? 'png' : 'jpg', destination)
        println destination.name
        render destination.name
    }

}