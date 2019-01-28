package br.ufscar.sead.loa.remar

import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContext
import org.springframework.security.core.context.SecurityContextHolder

class ShibbolethController {

    def AuthenticationManager authenticationManager;
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
        def redirectUrl = "http://alfa.remar.online/j_spring_security_check"
        def user = request.getAttribute("Shib-eduPerson-eduPersonPrincipalName") ? User.findByUsername(request.getAttribute("Shib-eduPerson-eduPersonPrincipalName")) : null;

        if (user) {
            log.info "Successfully logged in using Shibboleth Authentication;"

            render view: "success", model: [user: user, password: "changeit", redirectUrl: redirectUrl]
        } else {
            log.info "Creating new Shibboleth-authenticated user;"
            user = new User(
                    username: request.getAttribute("Shib-eduPerson-eduPersonPrincipalName"),
                    password: "changeit",
                    email: request.getAttribute("Shib-inetOrgPerson-mail"),
                    firstName: request.getAttribute("Shib-inetOrgPerson-cn"),
                    lastName: request.getAttribute("Shib-inetOrgPerson-sn"),
                    firsAccess: true,
                    enabled: true
            )
            user.save(flush: true)

            if (!user.hasErrors()) {
                UserRole.create user, Role.findByAuthority("ROLE_USER"), true
                log.info "Successfully created new Shibboleth-authenticated user;"
                render view: "success", model: [user: user, password: "changeit", redirectUrl: redirectUrl]
            } else {
                render user.errors
            }
        }
    }

    def authorize(LoginShibboleth user) {
		log.info "User: ${user.username} issued Shibboleth login;"

        UsernamePasswordAuthenticationToken authReq = new UsernamePasswordAuthenticationToken(user.username, "changeit");
        Authentication auth = authenticationManager.authenticate(authReq);
        SecurityContext sc = SecurityContextHolder.getContext();
        sc.setAuthentication(auth);

        session.user = User.findByUsername(user.username);

		log.info "Shibboleth flow succesfully authorized;"

		redirect(controller: "index", action: "index")
    }

}

class LoginShibboleth {
	String username;
}
