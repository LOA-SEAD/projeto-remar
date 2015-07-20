package br.ufscar.sead.loa.remar

class MoodleGame {
	static belongsTo = [owner: Moodle]

	String name
    String image
    int width
    int height
    String url
}
