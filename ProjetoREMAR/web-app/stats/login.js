	function submitLogin(_this){
		var online = navigator.onLine;
		if(online) {
			var choice = $(_this).attr('data-choice');
			$.ajax({
				type: 'POST',
				url: 'http://remar.dc.ufscar.br/group/isLogged', //TODO always change to remar.dc.ufscar.br later
				data: {
					username: $('#username').val(),
					password: $('#password').val(),
					choice: choice ? choice : "null"
				},
				success: function (data) {
					$('#check-login').remove();
				}, statusCode: {
					200: function (response) {
						console.log("200 ok");
						window.location.href = "./index.html"
					},
					401: function (response) {
						$('body').append(response.responseText);
					}
				}
			});
		} else{
			window.location.href = "./index.html"
		}
	}
		
