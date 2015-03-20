package projetoremar

class Palavras {

    static constraints = {
        resposta (blank: false)
        dica (blank: false)
        contribuicao (blank: true)
    }

    String resposta

    String dica

    String contribuicao

    String toJSON() {
        StringBuffer sb = new StringBuffer();
        sb.append("\"palavra\": \"${resposta}\",\n");
        sb.append("\"dica\": \"${dica}\",\n");
        sb.append("\"contribuicao\": \"${contribuicao}\"");
    }
}
