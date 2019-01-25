package br.ufscar.sead.loa.remar

class ShibbolethController {

    def springSecurityService

    def connect() {

    	/* Shibboleth attributes available:
            "Shib-brEduPerson-brEduAffiliationType", -- userType : [student, teacher, employee, ...];
            "Shib-eduPerson-eduPersonAffiliation",   -- userType custom identifier
            "Shib-eduPerson-eduPersonPrincipalName", -- UNIQUE name identifier for user within the federation; Used as username;
            "Shib-inetOrgPerson-cn",			     -- user complete name
            "Shib-inetOrgPerson-mail",				 -- user email
            "Shib-inetOrgPerson-sn",				 -- user surname
            "Shib-Application-ID",
            "Shib-Session-ID",
            "Shib-Identity-Provider",				 -- Authorizing IDP identifier
            "Shib-Authentication-Instant",           -- Authentication timestamp
            "Shib-Authentication-Method",            -- Auth method
            "Shib-AuthnContext-Class",
            "Shib-Session-Index",					 -- unique session identifier
        */
        log.info "Starting Shibboleth Authentication for " + request.getAttribute("Shib-eduPerson-eduPersonPrincipalName");
        def redirectUrl = "http://alfa.remar.online/shibboleth/authorize"
        def user = request.getAttribute("Shib-eduPerson-eduPersonPrincipalName")? User.findByUsername(request.getAttribute("Shib-eduPerson-eduPersonPrincipalName")) : null;

        if (user) {
        	session.user = user;
        	flash.user = user;
			log.info "Successfully logged in using Shibboleth Authentication;"

        	render view: "success", model: [user: user, redirectUrl: redirectUrl]
        } else{
        	log.info "Creating new Shibboleth-authenticated user;"
        	user = new User(
        		username: request.getAttribute("Shib-eduPerson-eduPersonPrincipalName"),
                password: request.getAttribute("Shib-Session-ID"),
                email: request.getAttribute("Shib-inetOrgPerson-mail"),
                firstName: request.getAttribute("Shib-inetOrgPerson-cn"),
                lastName: request.getAttribute("Shib-inetOrgPerson-sn"),
                firsAccess: true,
                enabled: true
            )
            user.save(flush: true)

            if (!user.hasErrors()) {
            	UserRole.create user, Role.findByAuthority("ROLE_USER"), true
            	session.user = user;
            	flash.user = user;
            	log.info "Successfully created new Shibboleth-authenticated user;"
            	log.info "${user.username}, ${user.password}"
            	render view: "success", model: [user: user, redirectUrl: redirectUrl]
            } else {
            	render user.errors
            }
        }

    }

    def authorize(username, password) {
    	def user = flash.user;
		log.info "User: ${user?.username} issued login with password ${user?.password};"

		springSecurityService.reauthenticate(user?.username, user?.password)

		log.info "Shibboleth flow succesfully authorized;"

		redirect(controller: "index", action: "index")
    }
}
