package br.ufscar.sead.loa.remar

class ShibbolethController {

    def connect() {

    	def shib_attributes = [
            "Shib-brEduPerson-brEduAffiliationType",
            "Shib-eduPerson-eduPersonAffiliation",
            "Shib-eduPerson-eduPersonPrincipalName",
            "Shib-inetOrgPerson-cn",
            "Shib-inetOrgPerson-mail",
            "Shib-inetOrgPerson-sn",
            "Shib-Application-ID",
            "Shib-Session-ID",
            "Shib-Identity-Provider",
            "Shib-Authentication-Instant",
            "Shib-Authentication-Method",
            "Shib-AuthnContext-Class",
            "Shib-Session-Index",
            "uid"
        ];

        def requestAttrs = []
        request.each {
            requestAttrs << it
        }

        shib_attributes.each {
            requestAttrs << [key: it, value: request.getAttribute(it)]
        }

        render view: "index", model: [requestAttrs: requestAttrs]
    }
}
