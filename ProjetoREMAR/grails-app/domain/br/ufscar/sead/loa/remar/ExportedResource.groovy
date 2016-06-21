package br.ufscar.sead.loa.remar

class ExportedResource {
	static belongsTo = [owner: User, resource: Resource]
    static hasMany = [platforms: Platform, accounts: MoodleAccount]

    static constraints = {
    	moodleUrl nullable: true
        exported nullable: true
        license nullable: false
        contentArea nullable: false
        specificContent nullable: false
    }


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
}
