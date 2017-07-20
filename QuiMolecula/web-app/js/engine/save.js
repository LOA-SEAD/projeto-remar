var xmlPath = "/quimolecula/xml/"
var imgPath = "/quimolecula/images/editor/"
var save = (function () {

    var Publico = {

		save: function(_levelMaximo) {

			localStorage.setItem('QuiMemoria', JSON.stringify(_levelMaximo));
		},

		load: function() {
			if(JSON.parse(localStorage.getItem('QuiMemoria')) == null)
				return 0;
			else
				return JSON.parse(localStorage.getItem('QuiMemoria'));
		}
	};

	return Publico;
}());
