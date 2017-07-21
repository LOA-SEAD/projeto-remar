package br.ufscar.sead.loa.quimolecula.remar

import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import groovy.json.JsonBuilder
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
@Transactional(readOnly = true)
class MoleculeController {

    static allowedMethods = [newMolecule: "POST", save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService


    def index(Integer max) {
        if (params.t) {
            session.taskId = params.t
        }
        session.user = springSecurityService.currentUser

        def list = Molecule.findAllByAuthor(session.user.username)

        render view: "index", model: [MoleculeInstanceList: list, MoleculeInstanceCount: list.size(),
                                      userName: session.user.username, userId: session.user.id]

    }

    def createMolecule() {
        render view:"create", model: [userName: session.user.username, userId: session.user.id]
    }

    @Transactional
    def newMolecule(Molecule MoleculeInstance) {
        if (MoleculeInstance.author == null) {
            MoleculeInstance.author = session.user.username
        }

        Molecule newMolecule  = new Molecule();
        newMolecule.id        = MoleculeInstance.id
        newMolecule.tip       = MoleculeInstance.tip
        newMolecule.name      = MoleculeInstance.name
        newMolecule.author    = MoleculeInstance.author
        newMolecule.xml       = MoleculeInstance.xml
        newMolecule.structure = MoleculeInstance.structure

        newMolecule.ownerId   = session.user.id
        newMolecule.taskId    = session.taskId as String

        if (newMolecule.hasErrors()) {
            respond newMolecule.errors, view: 'create' //TODO
            render newMolecule.errors;
            return
        }

        newMolecule.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + newMolecule.getId() + "}")
            }
        } else {
            // TODO
        }

        render("200 OK")
    }

    @Transactional
    def save(Molecule MoleculeInstance) {
        if (MoleculeInstance == null) {
            notFound()
            return
        }




        if (MoleculeInstance.hasErrors()) {
            respond MoleculeInstance.errors, view: 'create' //TODO
            render MoleculeInstance.errors;
            return
        }

        MoleculeInstance.taskId = session.taskId as String

        MoleculeInstance.save flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + MoleculeInstance.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())
    }

    def edit(Molecule MoleculeInstance) {
        respond MoleculeInstance
    }

    @Transactional
    def update() {

        Molecule MoleculeInstance = Molecule.findById(Integer.parseInt(params.MoleculeID))

        MoleculeInstance.statement = params.statement
        MoleculeInstance.answer = params.answer
        MoleculeInstance.category = params.category
        MoleculeInstance.save flush:true

        redirect action: "index"
    }

    @Transactional
    def delete(Molecule MoleculeInstance) {
        if (MoleculeInstance == null) {
            notFound()
            return
        }

        MoleculeInstance.delete flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + MoleculeInstance.getId() + "}")
            }
        } else {
            // TODO
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'Molecule.label', default: 'Molecule'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def toJson() {
        def list = Molecule.getAll(params.id ? params.id.split(',').toList() : null)
        def builder = new JsonBuilder()
        def json = builder(
                list.collect { p ->
                    ["palavra"     : p.getAnswer().toUpperCase(),
                     "dica"        : p.getStatement(),
                     "contribuicao": p.getAuthor()]
                }
        )

        log.debug builder.toString()

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + springSecurityService.getCurrentUser().getId() + "/" + session.taskId)
        userPath.mkdirs()

        def fileName = "palavras.json"
        File file = new File("$userPath/$fileName");
        PrintWriter pw = new PrintWriter(file);
        pw.write('{ "nome" : "Forca","palavras":' + builder.toString() + '}');
        pw.close();

        String id = MongoHelper.putFile(file.absolutePath)

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}", params: [files: id]
    }

    def returnInstance(Molecule MoleculeInstance){

        if (MoleculeInstance == null) {
            notFound()
        }
        else{
            render MoleculeInstance.statement + "%@!" +
                    MoleculeInstance.answer + "%@!" +
                    MoleculeInstance.author + "%@!" +
                    MoleculeInstance.category + "%@!" +
                    MoleculeInstance.version + "%@!" +
                    MoleculeInstance.ownerId + "%@!" +
                    MoleculeInstance.taskId + "%@!" +
                    MoleculeInstance.id
        }
    }

    @Transactional
    def generateMolecules() {
        MultipartFile csv = params.csv
        def user = springSecurityService.getCurrentUser()
        def userId = user.toString().split(':').toList()
        String username = User.findById(userId[1].toInteger()).username

        csv.inputStream.toCsvReader(['separatorChar': ';', 'charset':'UTF-8']).eachLine { row ->

            Molecule MoleculeInstance = new Molecule()

            try{
                String correct = row[6] ?: "NA";
                int correctAnswer = (correct.toInteger() -1)
                MoleculeInstance.statement = row[1] ?: "NA";
                MoleculeInstance.answer = row[(2 + correctAnswer)] ?: "NA";
                MoleculeInstance.category = row[8] ?: "NA";
            }
            catch (ArrayIndexOutOfBoundsException exception){
                //println("Not default .csv - Model: Title-Answer-Category")
                MoleculeInstance.statement = row[0] ?: "NA";
                MoleculeInstance.answer = row[1] ?: "NA";
                MoleculeInstance.category = row[2] ?: "NA";
            }

            MoleculeInstance.author = username
            MoleculeInstance.taskId = session.taskId as String
            MoleculeInstance.ownerId = session.user.id

            if (MoleculeInstance.hasErrors()) {

            }
            else{
                MoleculeInstance.save flush: true
            }

        }

        redirect(action: index())

    }

    def exportCSV(){
        /* Função que exporta as questões selecionadas para um arquivo .csv genérico.
           O arquivo .csv gerado será compatível com os modelos Escola Mágica, Forca e Responda Se Puder.
           O arquivo gerado possui os seguintes campos na ordem correspondente:
           Nível, Pergunta, Alternativa1, Alternativa2, Alternativa3, Alternativa4, Alternativa Correta, Dica, Tema.
           O campo Dica é correspondente ao modelo Responda Se Puder e o campo Tema ao modelo Forca.
           O separador do arquivo .csv gerado é o ";" (ponto e vírgula)
        */

        ArrayList<Integer> list_MoleculeId = new ArrayList<Integer>() ;
        ArrayList<Molecule> MoleculeList = new ArrayList<Molecule>();
        list_MoleculeId.addAll(params.list_id);
        for (int i=0; i<list_MoleculeId.size();i++){
            MoleculeList.add(Molecule.findById(list_MoleculeId[i]));

        }

        //println(MoleculeList)
        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportMolecules.csv"), "UTF-8"));

        for(int i=0; i<MoleculeList.size();i++){
            fw.write("1;" + MoleculeList.getAt(i).statement + ";" + MoleculeList.getAt(i).answer + ";"  + "Alternativa 2;" +
                    "Alternativa 3;" + "Alternativa 4;" + "1;" + "dica;" + MoleculeList.getAt(i).category +";\n" )
        }
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/forca/samples/export/exportMolecules.csv"


    }

}
