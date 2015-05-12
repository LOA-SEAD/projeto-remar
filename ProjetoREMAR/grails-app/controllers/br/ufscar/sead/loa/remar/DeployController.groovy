package br.ufscar.sead.loa.remar

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured

@Secured(['ROLE_DESENVOLVEDOR'])
class DeployController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def springSecurityService
    def grailsApplication

    def index(Integer max) {
        
        render view: 'index', model:[deployInstanceList: Deploy.findAllByDesenvolvedor(springSecurityService.currentUser), deployInstanceCount: Deploy.count()]
    }

    def show(Deploy deployInstance) {
        if(deployInstance){
            if(deployInstance.desenvolvedor == springSecurityService.currentUser){
                render view: 'show', model:[deployInstance: deployInstance]
            }
            else{
                flash.message = "Você não tem acesso a esse deploy"
                redirect action: 'index'
            }
        }
        else{
            flash.message = "Esse deploy não existe"
            redirect action: 'index'
        }
    }

    def create() {
        respond new Deploy(params)
    }

    @Transactional
    def save(Deploy deployInstance) {
        deployInstance.data_deploy = new Date()
        deployInstance.desenvolvedor = springSecurityService.currentUser
        
        def downloadedFile = request.getFile("war_file")

        deployInstance.war_filename = downloadedFile.getOriginalFilename()
        
        deployInstance.save flush:true

        if(!deployInstance.hasErrors()){
            downloadedFile.transferTo(new File(grailsApplication.config.camundaWebapps+downloadedFile.getOriginalFilename()))
            
            flash.message = message(code: 'default.created.message', args: [message(code: 'deploy.label', default: 'Deploy'), deployInstance.id])
            redirect deployInstance
        }
        else{
            redirect controller: "deploy", action: "index"
        }
        
    }

    @Transactional
    def delete(Deploy deployInstance) {

        if (deployInstance == null) {
            notFound()
            return
        }

        if(deployInstance.desenvolvedor == springSecurityService.currentUser){        
            def war_dir = new File(grailsApplication.config.camundaWebapps+deployInstance.war_filename.minus(".war"))
            war_dir.mkdirs()

            if(war_dir.exists()){
                println "Removendo deploy da aplicação..."
                if(war_dir.deleteDir()){
                    println "Remoção ocorrida com sucesso!"
                    println "Removendo arquivo .war..."
                    def war_file = new File(grailsApplication.config.camundaWebapps+deployInstance.war_filename)
                    if(war_file.delete()){
                        println "Arquivo .war removido com sucesso!"
                    }
                    else{
                        println "Problemas ao remover .war!"
                        redirect controller: "deploy", action: "index"
                    }

                }
                else{
                    println "Problemas ao remover diretório!"
                    redirect controller: "deploy", action: "index"
                }
            }

            deployInstance.delete flush:true

            redirect controller: "deploy", action: "index"
        }
        else{
            flash.message = "Você não tem acesso a esse deploy"
            redirect action: 'index'
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'deploy.label', default: 'Deploy'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
