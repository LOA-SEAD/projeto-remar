package br.ufscar.sead.loa.remar

class MoodleAccount {
	static belongsTo = [owner: Moodle]
	String accountName
}
