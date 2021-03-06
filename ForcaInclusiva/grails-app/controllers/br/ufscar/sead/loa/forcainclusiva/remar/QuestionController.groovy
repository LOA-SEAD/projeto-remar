package br.ufscar.sead.loa.forcainclusiva.remar

import br.ufscar.sead.loa.remar.User
import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import groovy.json.JsonBuilder
import org.springframework.web.multipart.MultipartFile

import java.nio.file.StandardCopyOption

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import java.nio.file.Files

@Secured(["isAuthenticated()"])
@Transactional(readOnly = true)
class QuestionController {

    static allowedMethods = [save: "POST", delete: "DELETE", newQuestion:"POST"]

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

        // debug dos parâmetros vindos na chamada de ação
        println("newQuestion params: $params")

        if (questionInstance.author == null) {
            questionInstance.author = session.user.username
            println("$questionInstance.author")
        }

        questionInstance.author = session.user.username
        println("author: $questionInstance.author")


        // cria um objeto chamado newQuest do domínio Question e coloca nele os valores vindos nos parâmetros
        Question newQuest = new Question();
        newQuest.id = questionInstance.id
        newQuest.statement = questionInstance.statement
        newQuest.answer = questionInstance.answer
        newQuest.author = questionInstance.author
        newQuest.category = questionInstance.category
        newQuest.taskId = session.taskId as String
        newQuest.ownerId = session.user.id

        // salva no banco de dados
        newQuest.save flush: true

        // checa o newQuest (e, consequentemente, os parâmetros)
        if (newQuest.hasErrors()) {
            respond newQuest.errors, view: 'create' //TODO
            render newQuest.errors;
            return
        }

        // pega o id do usuário corrente (será usado para nomear os diretórios de armazenamento de arquivos)
        def userId = springSecurityService.getCurrentUser().getId()
        println("userId:  $userId")


        // definição do diretório de áudios: criado com a id do usuário corrente!
        def userPath = servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + newQuest.id)
        def userFolder = new File(userPath)
        userFolder.mkdirs()

        // audioA e audioB: gravações (pergunta e resposta, respectivamente)
        if(params.audioA != null) {
            def f1Recorded = request.getFile("audioA")
            def f1File = new File("$userPath/statement.wav")
            f1Recorded.transferTo(f1File)
            println "Running Script for Wav-to-Mp3 (Pergunta)"
            wavToMp3("$userPath/statement.wav", "$userPath/statement.mp3")
        }
        if(params.audioB != null) {
            def f1Recorded = request.getFile("audioB")
            def f1File = new File("$userPath/answer.wav")
            f1Recorded.transferTo(f1File)
            println "Running Script for Wav-to-Mp3 (Resposta)"
            wavToMp3("$userPath/answer.wav", "$userPath/answer.mp3")
        }

        // audio-1 e audio-2: uploads (pergunta e resposta, respectivamente)

        if(params["audio-1"] != null) {
            def f1Recorded = request.getFile("audio-1")
            def f1File = new File("$userPath/statement.mp3")
            f1Recorded.transferTo(f1File)
        }

        if(params["audio-2"] != null) {
            def f1Recorded = request.getFile("audio-2")
            def f1File = new File("$userPath/answer.mp3")
            f1Recorded.transferTo(f1File)
        }

        if (params["selectPerg"] == "gerar") {
            println "Text-to-Speech (Pergunta)"
            println "Running Script for Text-to-Speech (Pergunta)"
            textToSpeech("$questionInstance.statement", "$userPath/statement.mp3")
        }

        if (params["selectResp"] == "gerar") {
            println "Text-to-Speech (Resposta)"
            println "Running Script for Text-to-Speech (Resposta)"
            textToSpeech("$questionInstance.answer", "$userPath/answer.mp3")
        }

        println("question id: $newQuest.id")

        if (request.isXhr()) {
            def port = request.serverPort
            if (Environment.current == Environment.DEVELOPMENT) {
               port = 8010
            }   

            render("http://${request.serverName}:${request.serverPort}/forcainclusiva/question")
        } else {
            // TODO
        }
    }

    @Transactional
    def save(Question questionInstance) {
        println("params save: $params")
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

        println("params edit: $params")
        Question questionInstance = Question.findById(Integer.parseInt(params.questionID))

        questionInstance.statement = params.statement
        questionInstance.answer = params.answer
        questionInstance.category = params.category
        questionInstance.save flush: true

        // edição dos áudios:

        // pega o id do usuário corrente (será usado para nomear os diretórios de armazenamento de arquivos)
        def userId = springSecurityService.getCurrentUser().getId()
        println("userId:  $userId")

        // definição do diretório de áudios: criado com a id do usuário corrente!
        def userPath = servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + params.questionID)
        def userFolder = new File(userPath)
        userFolder.mkdirs()

        // audioA e audioB: gravações (pergunta e resposta, respectivamente)

        if(params["audioA"] != null) {
            def f1Recorded = request.getFile("audioA")
            def f1File = new File("$userPath/statement.wav")
            f1Recorded.transferTo(f1File)
            println "Running Script for Wav-to-Mp3 (Pergunta)"
            wavToMp3("$userPath/statement.wav", "$userPath/statement.mp3")
        }

        if(params["audioB"] != null) {
            def f1Recorded = request.getFile("audioB")
            def f1File = new File("$userPath/answer.wav")
            f1Recorded.transferTo(f1File)
            println "Running Script for Wav-to-Mp3 (Resposta)"
            wavToMp3("$userPath/answer.wav", "$userPath/answer.mp3")
        }

        // audio-1 e audio-2: uploads (pergunta e resposta, respectivamente)

        if(params["audio-1"] != null) {
            def f1Recorded = request.getFile("audio-1")
            def f1File = new File("$userPath/statement.mp3")
            f1Recorded.transferTo(f1File)
        }

        if(params["audio-2"] != null) {
            def f1Recorded = request.getFile("audio-2")
            def f1File = new File("$userPath/answer.mp3")
            f1Recorded.transferTo(f1File)
        }

        if (params["selectPerg"] == "gerar") {
            println "Text-to-Speech (Pergunta)"
            println "Running Script for Text-to-Speech (Pergunta)"
            textToSpeech("$questionInstance.statement", "$userPath/statement.mp3")
        }

        if (params["selectResp"] == "gerar") {
            println "Text-to-Speech (Resposta)"
            println "Running Script for Text-to-Speech (Resposta)"
            textToSpeech("$questionInstance.answer", "$userPath/answer.mp3")
        }

        if (request.isXhr()) {
            def port = request.serverPort
            if (Environment.current == Environment.DEVELOPMENT) {
               port = 8010
            }   
            render("http://${request.serverName}:${request.serverPort}/forcainclusiva/question")
        } else {
            // TODO
        }

        //redirect action: "index"
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

    def show(Question questionInstance) {
        println questionInstance
        respond questionInstance
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

    void textToSpeech(String text, String file) {
        def ant = new AntBuilder()
        def rootPath = servletContext.getRealPath('/')
        def script = "${rootPath}/scripts/gtts.py"
        ant.sequential {
            chmod(perm: "+x", file: script)
            exec(executable: script) {
                arg(value: "$text")
                arg(value: "$file")
            }
        }
    }

    void wavToMp3(String wavFile, String mp3File) {
        def ant = new AntBuilder()
        def rootPath = servletContext.getRealPath('/')
        def script = "${rootPath}/scripts/wav_mp3.sh"
        ant.sequential {
            chmod(perm: "+x", file: script)
            exec(executable: script) {
                arg(value: "$wavFile")
                arg(value: "$mp3File")
            }
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

        def files = "?"

        def fileName = "palavras.json"
        File file = new File("$userPath/$fileName");
        PrintWriter pw = new PrintWriter(file);
        pw.write('{ "nome": "Forca","palavras":' + builder.toString() + '}');
        pw.close();

        String id = MongoHelper.putFile(file.absolutePath)
        files += "files=${id}"

        println list

        def audioPath = new File(dataPath, "/" + springSecurityService.getCurrentUser().getId() + "/audios/")

//        def audioFolder = new File("$userPath/audio")
//        audioFolder.mkdirs()
//
//        id = MongoHelper.putFile(audioFolder.absolutePath)
//        files += "&files=${id}"

        for (int i = 0; i < list.size(); i++) {
            Question question = list.get(i);

            def currFile = new File("$audioPath/$question.id/statement.mp3")
            def destFile = new File("$userPath/S${i}.mp3")
            Files.copy(currFile.toPath(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING)

            id = MongoHelper.putFile(destFile.absolutePath)
            files += "&files=${id}"

            // def destFile = new File("$audioFolder/S${i}.wav")
            // Files.copy(currFile.toPath(), destFile.toPath())

            currFile = new File("$audioPath/$question.id/answer.mp3")
            destFile = new File("$userPath/A${i}.mp3")
            Files.copy(currFile.toPath(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING)

            id = MongoHelper.putFile(destFile.absolutePath)
            files += "&files=${id}"

            // destFile = new File("$audioFolder/A${i}.wav")
            // Files.copy(currFile.toPath(), destFile.toPath())
        }

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8010
        }

        def url = "http://${request.serverName}:${port}/process/task/complete/${session.taskId}${files}"
        println url
        redirect uri: "http://${request.serverName}:${port}/process/task/complete/${session.taskId}${files}"
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

    // A versão forca acessível do forca não tem exportação de csv
    def exportCSV() {
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
            port = 8010
        }

        render "/forcainclusiva/samples/export/exportQuestions.csv"


    }

    def MP3File(params) {

        InputStream contentStream

        def userId = springSecurityService.getCurrentUser().getId()

        def dir = new File(servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + params.id))

        File file = new File(dir, params.file + ".mp3")

        response.setHeader("Content-disposition", "attachment; filename=" + file.getName())
        response.setHeader("Content-Length", file.size().toString())
        response.setContentType("file-mime-type")
        contentStream = file.newInputStream()
        response.outputStream << contentStream
        webRequest.renderView = false
    }
}
