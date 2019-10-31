package br.ufscar.sead.loa.remar

class MoodleAccount {
	static belongsTo = [owner: User, moodle: Moodle]
	String accountName
	String token
}
