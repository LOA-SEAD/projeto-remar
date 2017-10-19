package br.ufscar.sead.loa.remar

import org.springframework.http.HttpMethod

class RequestMap {

    String url
    String configAttribute
    HttpMethod httpMethod

    static mapping = {
        cache false
    }

    static constraints = {
        url blank: false, unique: 'httpMethod'
        configAttribute blank: false
        httpMethod nullable: true
    }
}
