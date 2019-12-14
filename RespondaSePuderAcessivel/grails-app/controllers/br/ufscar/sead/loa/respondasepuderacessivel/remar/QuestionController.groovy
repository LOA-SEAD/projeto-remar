package br.ufscar.sead.loa.respondasepuderacessivel.remar


import br.ufscar.sead.loa.remar.api.MongoHelper
import grails.util.Environment
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import java.nio.file.Files

@Secured(["isAuthenticated()"])
class QuestionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE", returnInstance: ["GET", "POST"]]

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

    @Secured(['permitAll'])
    def index() {
        if (params.t) {
            session.taskId = params.t
        }

        def list = Question.findAllByOwnerId(session.user.id)

        if (list.size() == 0) {


            for (int i = 1; i <= 3; i++) {
                for (int j = 1; j <= 4; j++) {
                    Question question = new Question(title: "Questão ${j} - Nível ${i}",
                            answers: ["Alternativa 1", "Alternativa 2", "Alternativa 3", "Alternativa 4"],
                            correctAnswer: 0, hint: "Dica ${j} - Nível ${i}", level: i,
                            ownerId: session.user.id, taskId: session.taskId);
                    question.save flush: true

                    def samplesPath = servletContext.getRealPath("/samples")
                    File samplesFolder = new File(samplesPath)

                    def userPath = servletContext.getRealPath("/data/" + session.user.id.toString() + "/audios/" + question.id)
                    def userFolder = new File(userPath)
                    userFolder.mkdirs()

                    if (samplesFolder.exists()) {
                        String[] fileNames = ["title.wav", "hint.wav", "answer1.wav",
                            "answer2.wav", "answer3.wav", "answer4.wav"]

                        File srcFolder = new File(samplesPath+"/${(i-1)*4+j}")
                        for (String fileName: fileNames) {
                            def srcFile = new File(srcFolder, fileName)
                            def destFile = new File(userFolder, fileName)
                            println srcFile.getAbsolutePath() + " => " + destFile.getAbsolutePath()
                            Files.copy(srcFile.toPath(), destFile.toPath())
                        }
                    }
                    else {
                        textToSpeech("${question.title}", "$userPath/title.wav")
                        textToSpeech("${question.answers[0]}", "$userPath/answer1.wav")
                        textToSpeech("${question.answers[1]}", "$userPath/answer2.wav")
                        textToSpeech("${question.answers[2]}", "$userPath/answer3.wav")
                        textToSpeech("${question.answers[3]}", "$userPath/answer4.wav")
                        textToSpeech("${question.hint}", "$userPath/hint.wav")
                    }
                }
            }

        }
        respond Question.findAllByOwnerId(session.user.id), model: [questionInstanceCount: Question.count()]
    }

    def show(Question questionInstance) {
        respond questionInstance
    }

    def create() {
        respond new Question(params)
    }

    @Transactional
    def save(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }

        def userId = session.user.id
        questionInstance.title = params.title
        questionInstance.level = Integer.parseInt(params.level)
        questionInstance.answers[0] = params.answer1
        questionInstance.answers[1] = params.answer2
        questionInstance.answers[2] = params.answer3
        questionInstance.answers[3] = params.answer4
        //questionInstance.correctAnswer = Integer.parseInt(params.correctAnswer) - 1
        questionInstance.correctAnswer = 0
        questionInstance.hint = params.hint
        questionInstance.ownerId = session.user.id as long
        questionInstance.taskId = session.taskId as String

        questionInstance.save flush: true

        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view: 'create'
            return
        }

        def questionID = questionInstance.getId()

        // definição do diretório de áudios: criado com a id do usuário corrente!
        def userPath = servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + questionID)
        def userFolder = new File(userPath)
        userFolder.mkdirs()

        // audioA e audioB: gravações (pergunta e resposta, respectivamente)
        if (params.audioA != null) {
            def f1Recorded = request.getFile("audioA")
            def f1File = new File("$userPath/title.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioB != null) {
            def f1Recorded = request.getFile("audioB")
            def f1File = new File("$userPath/answer1.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioC != null) {
            def f1Recorded = request.getFile("audioC")
            def f1File = new File("$userPath/answer2.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioD != null) {
            def f1Recorded = request.getFile("audioD")
            def f1File = new File("$userPath/answer3.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioE != null) {
            def f1Recorded = request.getFile("audioE")
            def f1File = new File("$userPath/answer4.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioF != null) {
            def f1Recorded = request.getFile("audioF")
            def f1File = new File("$userPath/hint.wav")
            f1Recorded.transferTo(f1File)
        }

        // audio-1 e audio-2: uploads (pergunta e resposta, respectivamente)
        if (params["audio-1"] != null) {
            def f1Recorded = request.getFile("audio-1")
            def f1File = new File("$userPath/title.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-2"] != null) {
            def f1Recorded = request.getFile("audio-2")
            def f1File = new File("$userPath/answer1.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-3"] != null) {
            def f1Recorded = request.getFile("audio-3")
            def f1File = new File("$userPath/answer2.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-4"] != null) {
            def f1Recorded = request.getFile("audio-4")
            def f1File = new File("$userPath/answer3.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-5"] != null) {
            def f1Recorded = request.getFile("audio-5")
            def f1File = new File("$userPath/answer4.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-6"] != null) {
            def f1Recorded = request.getFile("audio-6")
            def f1File = new File("$userPath/hint.wav")
            f1Recorded.transferTo(f1File)
        }

        if (params["selectTitle"] == "gerar") {
            println "Text-to-Speech (Title)"
            println "Running Script for Text-to-Speech (Title)"
            textToSpeech("${questionInstance.title}", "$userPath/title.wav")
        }
        if (params["selectAlt1"] == "gerar") {
            println "Text-to-Speech (Alt1)"
            println "Running Script for Text-to-Speech (Alt1)"
            textToSpeech("${questionInstance.answers[0]}", "$userPath/answer1.wav")
        }
        if (params["selectAlt2"] == "gerar") {
            println "Text-to-Speech (Alt2)"
            println "Running Script for Text-to-Speech (Alt2)"
            textToSpeech("${questionInstance.answers[1]}", "$userPath/answer2.wav")
        }
        if (params["selectAlt3"] == "gerar") {
            println "Text-to-Speech (Alt3)"
            println "Running Script for Text-to-Speech (Alt3)"
            textToSpeech("${questionInstance.answers[2]}", "$userPath/answer3.wav")
        }
        if (params["selectAlt4"] == "gerar") {
            println "Text-to-Speech (Alt4)"
            println "Running Script for Text-to-Speech (Alt4)"
            textToSpeech("${questionInstance.answers[3]}", "$userPath/answer4.wav")
        }
        if (params["selectHint"] == "gerar") {
            println "Text-to-Speech (Hint)"
            println "Running Script for Text-to-Speech (Hint)"
            textToSpeech("${questionInstance.hint}", "$userPath/hint.wav")
        }


        redirect(action: "index")
    }

    def edit(Question questionInstance) {
        respond questionInstance
    }

    @Transactional
    def update() {

        def userId = session.user.id

        Question questionInstance = Question.findById(Integer.parseInt(params.questionID))
        questionInstance.title = params.title
        questionInstance.level = Integer.parseInt(params.level)
        questionInstance.answers[0] = params.answer1
        questionInstance.answers[1] = params.answer2
        questionInstance.answers[2] = params.answer3
        questionInstance.answers[3] = params.answer4
        //questionInstance.correctAnswer = Integer.parseInt(params.correctAnswer) - 1
        questionInstance.correctAnswer = 0
        questionInstance.hint = params.hint
        questionInstance.ownerId = session.user.id as long
        questionInstance.taskId = session.taskId as String
        questionInstance.save flush: true

        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view: 'create'
            return
        }

        def questionID = questionInstance.getId()

        // definição do diretório de áudios: criado com a id do usuário corrente!
        def userPath = servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + questionID)
        def userFolder = new File(userPath)
        userFolder.mkdirs()

        // audioA e audioB: gravações (pergunta e resposta, respectivamente)
        if (params.audioA != null) {
            def f1Recorded = request.getFile("audioA")
            def f1File = new File("$userPath/title.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioB != null) {
            def f1Recorded = request.getFile("audioB")
            def f1File = new File("$userPath/answer1.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioC != null) {
            def f1Recorded = request.getFile("audioC")
            def f1File = new File("$userPath/answer2.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioD != null) {
            def f1Recorded = request.getFile("audioD")
            def f1File = new File("$userPath/answer3.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioE != null) {
            def f1Recorded = request.getFile("audioE")
            def f1File = new File("$userPath/answer4.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params.audioF != null) {
            def f1Recorded = request.getFile("audioF")
            def f1File = new File("$userPath/hint.wav")
            f1Recorded.transferTo(f1File)
        }

        // audio-1 e audio-2: uploads (pergunta e resposta, respectivamente)
        if (params["audio-1"] != null) {
            def f1Recorded = request.getFile("audio-1")
            def f1File = new File("$userPath/title.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-2"] != null) {
            def f1Recorded = request.getFile("audio-2")
            def f1File = new File("$userPath/answer1.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-3"] != null) {
            def f1Recorded = request.getFile("audio-3")
            def f1File = new File("$userPath/answer2.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-4"] != null) {
            def f1Recorded = request.getFile("audio-4")
            def f1File = new File("$userPath/answer3.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-5"] != null) {
            def f1Recorded = request.getFile("audio-5")
            def f1File = new File("$userPath/answer4.wav")
            f1Recorded.transferTo(f1File)
        }
        if (params["audio-6"] != null) {
            def f1Recorded = request.getFile("audio-6")
            def f1File = new File("$userPath/hint.wav")
            f1Recorded.transferTo(f1File)
        }

        if (params["selectTitle"] == "gerar") {
            println "Text-to-Speech (Title)"
            println "Running Script for Text-to-Speech (Title)"
            textToSpeech("${questionInstance.title}", "$userPath/title.wav")
        }
        if (params["selectAlt1"] == "gerar") {
            println "Text-to-Speech (Alt1)"
            println "Running Script for Text-to-Speech (Alt1)"
            textToSpeech("${questionInstance.answers[0]}", "$userPath/answer1.wav")
        }
        if (params["selectAlt2"] == "gerar") {
            println "Text-to-Speech (Alt2)"
            println "Running Script for Text-to-Speech (Alt2)"
            textToSpeech("${questionInstance.answers[1]}", "$userPath/answer2.wav")
        }
        if (params["selectAlt3"] == "gerar") {
            println "Text-to-Speech (Alt3)"
            println "Running Script for Text-to-Speech (Alt3)"
            textToSpeech("${questionInstance.answers[2]}", "$userPath/answer3.wav")
        }
        if (params["selectAlt4"] == "gerar") {
            println "Text-to-Speech (Alt4)"
            println "Running Script for Text-to-Speech (Alt4)"
            textToSpeech("${questionInstance.answers[3]}", "$userPath/answer4.wav")
        }
        if (params["selectHint"] == "gerar") {
            println "Text-to-Speech (Hint)"
            println "Running Script for Text-to-Speech (Hint)"
            textToSpeech("${questionInstance.hint}", "$userPath/hint.wav")
        }

        redirect action: "index"
    }

    @Transactional
    def delete(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }
        questionInstance.delete flush: true
        render "delete ok!"
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

    def returnInstance(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
        } else {
            render questionInstance.level + "%@!" +
                    questionInstance.title + "%@!" +
                    questionInstance.answers[0] + "%@!" +
                    questionInstance.answers[1] + "%@!" +
                    questionInstance.answers[2] + "%@!" +
                    questionInstance.answers[3] + "%@!" +
                    questionInstance.correctAnswer + "%@!" +
                    questionInstance.hint + "%@!" +
                    questionInstance.id
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

    @Transactional
    def exportQuestions() {

        int randomQuestion = Integer.parseInt(params.randomQuestion) + 1

        ArrayList<Question> questionList = new ArrayList<Question>();

        //Criando lista de questões do level 1

        ArrayList<Integer> list_questionId_level1 = new ArrayList<Integer>();
        list_questionId_level1.addAll(params.list_id_level1);
        for (int i = 0; i < list_questionId_level1.size(); i++) {
            questionList.add(Question.findById(list_questionId_level1[i]));
        }

        //Criando lista de questões do level 2

        ArrayList<Integer> list_questionId_level2 = new ArrayList<Integer>();
        list_questionId_level2.addAll(params.list_id_level2);
        for (int i = 0; i < list_questionId_level2.size(); i++) {
            questionList.add(Question.findById(list_questionId_level2[i]));

        }

        //Criando lista de questões do level 3

        ArrayList<Integer> list_questionId_level3 = new ArrayList<Integer>();
        list_questionId_level3.addAll(params.list_id_level3);
        for (int i = 0; i < list_questionId_level3.size(); i++) {
            questionList.add(Question.findById(list_questionId_level3[i]));
        }

        String files = "?"

        // Criação do arquivo JSON

        def userId = session.user.id
        def dataPath = servletContext.getRealPath("/data/")
        def instancePath = new File("${dataPath}/${userId}/${session.taskId}")
        instancePath.mkdirs()

        File jsonFile = new File("$instancePath/" + "DadosResponda.json");
        def bw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(jsonFile), "UTF-8"))

        for (int i = 0; i < questionList.size(); i++) {
            bw.write("{ ")
            Question question = questionList.getAt(i)
            bw.write("\"pergunta\":\"" + question.title.replace("\"", "\\\"") + "\", ")
            bw.write("\"resposta\":\"" + question.answers[0].replace("\"", "\\\"") + "\", ")
            for (int j = 1; j <= 3; j++) {
                bw.write("\"r" + (j + 1) + "\":\"" + question.answers[j].replace("\"", "\\\"") + "\",")
            }
            bw.write("\"dica\":\"" + question.hint.replace("\"", "\\\"") + "\", ")
            bw.write("\"nivel\":")
            switch (question.level) {
                case 1: bw.write("\"facil\""); break
                case 2: bw.write("\"medio\""); break
                case 3: bw.write("\"dificil\""); break
            }
            bw.write(" }\n")
        }
        bw.close();

        def id
        id = MongoHelper.putFile(jsonFile.getAbsolutePath())
        files += "files=${id}"

        // Cópia dos arquivos Wav

        def userPath = servletContext.getRealPath("/data/" + userId.toString())
        def destFolder = new File(userPath, "${session.taskId}")
        def srcFolder = new File(userPath, "audios")

        String levels = "fmd";

        for (int i = 0; i < questionList.size(); i++) {
            int contador = i % randomQuestion;
            Question q = questionList.getAt(i);
            int level = q.level;

            def srcFile = new File(srcFolder, "${q.id}/title.wav")
            def fileName = "p" + levels.charAt(level - 1) + contador + ".wav"
            def destFile = new File(destFolder, fileName)
            Files.copy(srcFile.toPath(), destFile.toPath())
            id = MongoHelper.putFile(destFile.absolutePath)
            files += "&files=${id}"

            for (int j = 0; j < 4; j++) {
                srcFile = new File(srcFolder, "${q.id}/answer${j + 1}.wav")
                fileName = "r" + levels.charAt(level - 1) + contador + "_" + j + ".wav"
                destFile = new File(destFolder, fileName)
                Files.copy(srcFile.toPath(), destFile.toPath())
                id = MongoHelper.putFile(destFile.absolutePath)
                files += "&files=${id}"
            }

            srcFile = new File(srcFolder, "${q.id}/hint.wav")
            fileName = "d" + levels.charAt(level - 1) + contador + ".wav"
            destFile = new File(destFolder, fileName)
            Files.copy(srcFile.toPath(), destFile.toPath())
            id = MongoHelper.putFile(destFile.absolutePath)
            files += "&files=${id}"
        }

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "http://${request.serverName}:${port}/process/task/complete/${session.taskId}" + files
    }

    @Transactional
    def generateQuestions() {
        MultipartFile csv = params.csv
        csv.inputStream.toCsvReader(['separatorChar': ';', 'charset': 'UTF-8']).eachLine { row ->
            Question questionInstance = new Question()
            String levelQuestion = row[0] ?: "NA";
            questionInstance.level = levelQuestion.toInteger()
            questionInstance.title = row[1] ?: "NA";
            questionInstance.answers[0] = row[2] ?: "NA";
            questionInstance.answers[1] = row[3] ?: "NA";
            questionInstance.answers[2] = row[4] ?: "NA";
            questionInstance.answers[3] = row[5] ?: "NA";
            String correct = row[6] ?: "NA";
            questionInstance.correctAnswer = (correct.toInteger() - 1)
            questionInstance.hint = row[7] ?: "NA";
            questionInstance.taskId = session.taskId as String
            questionInstance.ownerId = session.user.id as long
            questionInstance.save flush: true

        }
        redirect action: "index"
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

        def dataPath = servletContext.getRealPath("/samples")
        def instancePath = new File("${dataPath}/export")
        instancePath.mkdirs()
        log.debug instancePath

        def fw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("$instancePath/exportQuestions.csv"), "UTF-8"))

        for (int i = 0; i < questionList.size(); i++) {
            fw.write(questionList.getAt(i).level + ";" + questionList.getAt(i).title + ";" + questionList.getAt(i).answers[0] + ";" + questionList.getAt(i).answers[1] + ";" +
                    questionList.getAt(i).answers[2] + ";" + questionList.getAt(i).answers[3] + ";" + (questionList.getAt(i).correctAnswer + 1) + ";" + questionList.getAt(i).hint + ";tema" + ";\n")
        }
        fw.close()

        def port = request.serverPort
        if (Environment.current == Environment.DEVELOPMENT) {
            port = 8080
        }

        render "/respondasepuderacessivel/samples/export/exportQuestions.csv"
    }

    def WAVFile(params) {

        InputStream contentStream

        def userId = springSecurityService.getCurrentUser().getId()

        def dir = new File(servletContext.getRealPath("/data/" + userId.toString() + "/audios/" + params.id))

        File file = new File(dir, params.file + ".wav")

        response.setHeader("Content-disposition", "attachment; filename="+file.getName())
        response.setHeader("Content-Length", file.size().toString())
        response.setContentType("file-mime-type")
        contentStream = file.newInputStream()
        response.outputStream << contentStream
        webRequest.renderView = false
    }
}
