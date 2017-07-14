(function lerFases() {
	var i = 0;
	fases = new Array();
	dica = new Array();
	ok = true;
	while (ok) {
		file = xmlPath + i + ".xml";

		var request = $.ajax({
						url: file,
						type: "GET",
						dataType: "xml",
						async: false
					});

		request.done(function(xml) {
			$(xml).find('molecule').each(function() {
				fases[i] = $(this).attr('name');
				dica[i++] = $(this).attr('dica');
			});
		});

		request.fail(function(jqXHR, textStatus) {
			ok = false;
		});
	}
})()
