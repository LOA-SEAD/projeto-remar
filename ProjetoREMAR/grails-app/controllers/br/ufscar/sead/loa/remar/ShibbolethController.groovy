package br.ufscar.sead.loa.remar

class ShibbolethController {

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

        log.info "Starting Shibboleth Authentication for" + request.getAttribute("Shib-eduPerson-eduPersonPrincipalName");

        def u = request.getAttribute("Shib-eduPerson-eduPersonPrincipalName")? User.findByUsername(request.getAttribute("Shib-eduPerson-eduPersonPrincipalName")) : null;

        if (u) {
        	session.user = u;

			log.info "Successfully logged in using Shibboleth Authentication;"

        	render view: "success", model: [user: u]
        } else{
        	log.info "Creating new Shibboleth-authenticated user;"
        	u = new User(
        		username: request.getAttribute("Shib-eduPerson-eduPersonPrincipalName"),
                password: request.getAttribute("Shib-Session-ID"),
                email: request.getAttribute("Shib-inetOrgPerson-mail"),
                firstName: request.getAttribute("Shib-inetOrgPerson-cn"),
                lastName: request.getAttribute("Shib-inetOrgPerson-sn"),
                ssl_cipher: "???",
                firsAccess: true,
                enabled: true
            )

            if (u.save(flush: true)) {
            	UserRole.create u, Role.findByAuthority("ROLE_USER"), true
            	session.user = u;

            	log.info "Successfully created new Shibboleth-authenticated user;"
            	render view: "success", model: [user: u]
            } else {
            	respond status: 500
            }
        }

    }
}
