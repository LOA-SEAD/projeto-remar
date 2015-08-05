package br.ufscar.sead.loa.remar

class ExportedGame {
	static belongsTo = [owner: User]
    static hasMany = [platforms: Platform, accounts: MoodleAccount]

    static constraints = {
    	moodleUrl nullable: true
    	linuxUrl nullable: true
    	windowsUrl nullable: true
    	webUrl nullable: true
    	androidUrl nullable: true
    }

    String moodleUrl
    String linuxUrl
    String windowsUrl
    String webUrl
    String androidUrl

    String name
    String image
    int width
    int height
    Date exportedAt

    String type //should be "public", "private" or "group"
    //We should handle when professor wants to make the game available only for a group of students. How to do that?
}
