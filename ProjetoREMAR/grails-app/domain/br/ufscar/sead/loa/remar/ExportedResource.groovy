package br.ufscar.sead.loa.remar

class ExportedResource {
	static belongsTo = [owner: User, resource: Resource]
    static hasMany = [platforms: Platform, accounts: MoodleAccount,groupExportedResources :GroupExportedResources]

    static constraints = {
    	moodleUrl nullable: true
        exported nullable: true
        license nullable: false
        contentArea nullable: false
        specificContent nullable: false
    }

//    Group group
    String moodleUrl
    boolean exported

    String name
    int width
    int height
    Date exportedAt

    String type //should be "public", "private" or "group"
    String processId
    String license
    String contentArea
    String specificContent

    // Método que retorna os níveis do jogo (fixos ou variáveis)

    Set<Level> getLevels() {
        if (resource.fixedLevels) {
            return Level.findAllByResource(resource, [sort: 'id'])
        } else {
            Set<Level> levels = new HashSet<>()
            for (LevelExportedResource ler: LevelExportedResource.findAllByExportedResource(this, [sort: 'id'])) {
                levels.add(ler.level)
            }
            return levels
        }
    }
}
