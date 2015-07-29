package br.ufscar.sead.loa.remar

class Moodle {
	static hasMany = [accounts: MoodleAccount]
	static mapping = {
		accounts cascade:"all,delete-orphan"
	}

	Date installedAt
    String domain
}
