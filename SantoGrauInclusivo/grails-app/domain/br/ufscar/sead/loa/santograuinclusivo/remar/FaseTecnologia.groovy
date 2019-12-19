package br.ufscar.sead.loa.santograuinclusivo.remar

class FaseTecnologia {
    public static final String LINK_YOUTUBE = "Youtube"
    public static final String LINK_VIMEO = "Vimeo"
    public static final String LINK_PDF = "PDF"
    public static final String LINK_PAGINA_WEB = "Página Web"

    String link
    String tipoLink
    String[] palavras = new String[3]

    long ownerId
    String taskId

    static constraints = {
        link blank:false
        tipoLink blank:false, inList: [LINK_YOUTUBE, LINK_VIMEO, LINK_PDF, LINK_PAGINA_WEB]
        palavras nullable: false
    }
}
