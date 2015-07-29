package br.ufscar.sead.loa.remar

class MoodleGame {
	static hasMany = [moodles: Moodle]

	static mapping = {
		moodles cascade:"all,delete-orphan"
	}

	String name
    String image
    int width
    int height
    String url
    String game_id
}
