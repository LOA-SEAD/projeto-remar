package br.ufscar.sead.loa.remar

import grails.plugins.rest.client.RestBuilder
import grails.plugins.rest.client.RestResponse


@Singleton
class RestHelper{
    def rest = new RestBuilder()

    def get(String url){
        RestResponse getResponse = this.rest.get(url){
            contentType "application/json"
        }
        return getResponse.json
    }

    def post(String url,Object dataJson){
        try{
            RestResponse postResponse = this.rest.post(url){
                contentType "application/json"
                json(dataJson)
            }
            return postResponse
        }catch(Exception e){
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }
    }

    def put(String url,Object dataJson){
        RestResponse postResponse = this.rest.put(url){
            contentType "application/json"
            json(dataJson)
        }
    }
}