package escolamagica

class Perguntas {



    String titulo
    String[] resp = new String[4]
    Integer respCorreta
    String classe

    String[] getAlternativas(){
        return this.resp

    }

    void setRespCorreta(Integer respCorreta){
        this.respCorreta = respCorreta
    }

    Integer getRespCorreta(){
        return this.respCorreta
    }

    static constraints = {
       classe inList: ['1','2','3','4']
        respCorreta nullable: true

    }

    String toString(){
        titulo
    }
}
