package br.ufscar.sead.loa.forca.remar

import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import groovy.json.JsonBuilder
import org.imgscalr.Scalr
import org.springframework.web.multipart.MultipartFile

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(["isAuthenticated()"])
@Transactional(readOnly = true)
class QuestionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE", newQuestion:"POST"]

    def beforeInterceptor = [action: this.&check, only: ['index']]

    def springSecurityService

    private check() {
        if (springSecurityService.isLoggedIn())
            session.user = springSecurityService.currentUser
        else {
            log.debug "Logout: session.user is NULL !"
            session.user = null
            redirect controller: "login", action: "index"

            return false
        }
    }

    def index(Integer max) {
        if (params.t) {
            session.taskId = params.t
        }

        def list = Question.findAllByAuthor(session.user.username)

        render view: "index", model: [questionInstanceList: list, questionInstanceCount: list.size(),
                                      userName            : session.user.username, userId: session.user.id]

    }

    def create() {
        respond new Question(params)
    }

    @Transactional
    def newQuestion(Question questionInstance) {
    //def newQuestion() {
        // debug dos parâmetros vindos na chamada de ação
        println("params: $params")



        if (questionInstance.author == null) {
            questionInstance.author = session.user.username
        }

        // cria um objeto chamado newQuest do domínio Question e coloca nele os valores vindos nos parâmetros
        Question newQuest = new Question();
        newQuest.id = questionInstance.id
        newQuest.statement = questionInstance.statement
        newQuest.answer = questionInstance.answer
        newQuest.author = questionInstance.author
        newQuest.category = questionInstance.category
        newQuest.taskId = session.taskId as String
        newQuest.ownerId = session.user.id

        // checa o newQuest (e, consequentemente, os parâmetros)
        if (newQuest.hasErrors()) {
            respond newQuest.errors, view: 'create' //TODO
            render newQuest.errors;
            return
        }

        // salva no banco de dados
        newQuest.save flush: true


        // pega o id do usuário corrente (será usado para nomear os diretórios de armazenamento de arquivos)
        def userId = springSecurityService.getCurrentUser().getId()
        println("userId:  $userId")


        // def id = tileInstance.getId()
        // id = id do tileInstance = userId declarado acima = id do usuário da sessão >>> 4 itens armazenando a mesma coisa? pq?
        // definição do diretório de áudios: criado com a id do usuário corrente!
        def userPath = servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + newQuest.id)
        def userFolder = new File(userPath)
        userFolder.mkdirs()
to 

        // seletor da PERGUNTA; isso é, usuário seleciona se quer usar audio do upload ou de gravação para a pergunta
        if(("$params.audioPergunta") == "upload") {
            // pega os arquivos do form; esses são os de UPLOAD!!
            def f1Uploaded = request.getFile("audio-1")

            // coloca o áudio que foi pegado no diretório e transfere pra lá
            def f1 = new File("$userPath/pergunta.wav")

            f1Uploaded.transferTo(f1)
        }
        else if(("$params.audioPergunta") == "recording") {
            // aqui em baixo é tudo da GRAVAÇÃO
            // aparentemente o processo é o mesmo, então era pra funcionar pq "audioA" e "audioB" já são as identificações
            def f1Uploaded2 = request.getFile("audioA")

            def f12 = new File("$userPath/pergunta.wav")

            f1Uploaded2.transferTo(f12)
        }

        // seletor da RESPOSTA; isso é, usuário seleciona se quer usar audio do upload ou de gravação para a pergunta
        if(("$params.audioResposta") == "upload") {
            // pega os arquivos do form; esses são os de UPLOAD!!
            def f2Uploaded = request.getFile("audio-2")

            // coloca o áudio que foi pegado no diretório e transfere pra lá
            def f2 = new File("$userPath/resposta.wav")

            f2Uploaded.transferTo(f2)
        }
        else if(("$params.audioResposta") == "recording") {
            // aqui em baixo é tudo da GRAVAÇÃO
            // aparentemente o processo é o mesmo, então era pra funcionar pq "audioA" e "audioB" já são as identificações
            def f2Uploaded2 = request.getFile("audioB")

            def f22 = new File("$userPath/resposta.wav")

            f2Uploaded2.transferTo(f22)
        }

        /*
        Áudios sempre são salvos com o nome "audio$ID-a" para pergunta e "audio$ID-b" para resposta, independentemente de serem de upload ou gravação.
        O seletor acima basicamente verifica qual dos dois o usuário gostaria de usar como áudio descritor da pergunta transcrita.
        */

        println("question id: $newQuest.id")

        if (request.isXhr()) {
            render("http://localhost:8010/forca-acessivel/question")
        } else {
            // TODO
        }


    }

    @Transactional
    def salvarAudio() {

    }

    @Transactional
    def save(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }


        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view: 'create' //TODO
            render questionInstance.errors;
            return
        }

        questionInstance.taskId = session.taskId as String

        questionInstance.save flush: true

        def userId = springSecurityService.getCurrentUser().getId()
        def question = new Question(ownerId: userId).save flush: true
        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + userId + "/audios/" + question.getId())
        userPath.mkdirs()

        def audioUploaded = request.getFile('audio-1')

        audioUploaded.transferTo(new File("$userPath/audioteste.png"))


        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + questionInstance.getId() + "}")
            }
        } else {
            // TODO
        }

        redirect(action: index())
    }

    def edit(Question questionInstance) {
        respond questionInstance
    }

    @Transactional
    def update() {

        Question questionInstance = Question.findById(Integer.parseInt(params.questionID))

        questionInstance.statement = params.statement
        questionInstance.answer = params.answer
        questionInstance.category = params.category
        questionInstance.save flush: true

        redirect action: "index"
    }

    @Transactional
    def delete(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }

        questionInstance.delete flush: true

        if (request.isXhr()) {
            render(contentType: "application/json") {
                JSON.parse("{\"id\":" + questionInstance.getId() + "}")
            }
        } else {
            // TODO
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def toJson() {
        def list = Question.getAll(params.id ? params.id.split(',').toList() : null)
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
        pw.write('{ "nome": "Forca","palavras":' + builder.toString() + '}');
        pw.close();

        String id = MongoHelper.putFile(file.absolutePath)

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}", params: [files: id]
    }

    def returnInstance(Question questionInstance) {

        if (questionInstance == null) {
            notFound()
        } else {
            render questionInstance.statement + "%@!" +
                    questionInstance.answer + "%@!" +
                    questionInstance.author + "%@!" +
                    questionInstance.category + "%@!" +
                    questionInstance.version + "%@!" +
                    questionInstance.ownerId + "%@!" +
                    questionInstance.taskId + "%@!" +
                    questionInstance.id
        }
    }

    @Transactional
    def generateQuestions() {
        MultipartFile csv = params.csv
        def user = springSecurityService.getCurrentUser()
        def userId = user.toString().split(':').toList()
        String username = User.findById(userId[1].toInteger()).username

        csv.inputStream.toCsvReader(['separatorChar': ';', 'charset': 'UTF-8']).eachLine { row ->

            Question questionInstance = new Question()

            try {
                String correct = row[6] ?: "NA";
                int correctAnswer = (correct.toInteger() - 1)
                questionInstance.statement = row[1] ?: "NA";
                questionInstance.answer = row[(2 + correctAnswer)] ?: "NA";
                questionInstance.category = row[8] ?: "NA";
            }
            catch (ArrayIndexOutOfBoundsException exception) {
                //println("Not default .csv - Model: Title-Answer-Category")
                questionInstance.statement = row[0] ?: "NA";
                questionInstance.answer = row[1] ?: "NA";
                questionInstance.category = row[2] ?: "NA";
            }

            questionInstance.author = username
            questionInstance.taskId = session.taskId as String
            questionInstance.ownerId = session.user.id

            if (questionInstance.hasErrors()) {

            } else {
                questionInstance.save flush: true
            }

        }

        redirect(action: index())

    }

    def exportCSV() {
        /* Função que exporta as questões selecionadas para um arquivo .csv genérico.
           O arquivo .csv gerado será compatível com os modelos Escola Mágica, Forca e Responda Se Puder.
           O arquivo gerado possui os seguintes campos na ordem correspondente:
           Nível, Pergunta, Alternativa1, Alternativa2, Alternativa3, Alternativa4, Alternativa Correta, Dica, Tema.
           O campo Dica é correspondente ao modelo Responda Se Puder e o campo Tema ao modelo Forca.
           O separador do arquivo .csv gerado é o ";" (ponto e vírgula)
        */

        ArrayList<Integer> list_questionId = new ArrayList<Integer>();
        ArrayList<Question> questionList = new ArrayList<Question>();
        list_questionId.addAll(params.list_id);
        for (int i = 0; i < list_questionId.size(); i++) {
            questionList.add(Question.findById(list_questionId[i]));

        }

        //println(questionList)
        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportQuestions.csv"), "UTF-8"));

        for (int i = 0; i < questionList.size(); i++) {
            fw.write("1;" + questionList.getAt(i).statement + ";" + questionList.getAt(i).answer + ";" + "Alternativa 2;" +
                    "Alternativa 3;" + "Alternativa 4;" + "1;" + "dica;" + questionList.getAt(i).category + ";\n")
        }
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/forca-acessivel/samples/export/exportQuestions.csv"


    }


    def VerifyAndUpload(originalUpload,storagePath){

        def imageIn = ImageIO.read(originalUpload)
        def name = originalUpload.getName()


        if(originalUpload.toString().contains("icon")){

            int[] sizes = [36,48,72,96,144,192]

            for(int i=0; i<sizes.length; i++) {

                BufferedImage newImg = Scalr.resize(imageIn, Scalr.Method.ULTRA_QUALITY, sizes[i], sizes[i], Scalr.OP_ANTIALIAS)
                name = "icon" + sizes[i] + ".png"
                def newImgUploaded = new File("$storagePath/$name")
                ImageIO.write(newImg, 'png', newImgUploaded)

            }


        }


        if((imageIn.getWidth() > 800)||imageIn.getHeight() > 600){
            BufferedImage newImg = Scalr.resize(imageIn, Scalr.Method.ULTRA_QUALITY, 600, 800, Scalr.OP_ANTIALIAS)
            def newImgUploaded = new File("$storagePath/$name")
            ImageIO.write(newImg, 'png', newImgUploaded)
            return false
        }
        else{
            return true
        }

    }

    @Transactional
    def AudioManager() { // TODO: fix var names + optimize
        def userId = springSecurityService.getCurrentUser().getId()

        def theme = new Theme(ownerId: userId).save flush: true

        def dataPath = servletContext.getRealPath("/data")
        def userPath = new File(dataPath, "/" + userId + "/themes/" + theme.getId())
        userPath.mkdirs()

        def iconUploaded = request.getFile('audio-1')

        //if(!iconUploaded.isEmpty()) {

            def originalIconUploaded = new File("$userPath/audio.png")

            iconUploaded.transferTo(originalIconUploaded)

            VerifyAndUpload(originalIconUploaded, userPath)
        //}

        redirect(controller: "Question", action:"index")

    }

}