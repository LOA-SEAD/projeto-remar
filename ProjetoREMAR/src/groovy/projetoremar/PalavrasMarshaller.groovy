package projetoremar

import grails.converters.JSON
import projetoremar.Palavras

/**
 * Created by matheus on 4/1/15.
 */

class PalavrasMarshaller {

    void register() {
        JSON.registerObjectMarshaller(Palavras) {
        Palavras p -> return [
                palavra: p.resposta,
                dica: p.dica,
                contribuicao: p.contribuicao
        ]
        }
    }
}
