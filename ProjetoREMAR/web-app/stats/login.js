	function submitLogin(_this){
		var choice = $(_this).attr('data-choice');
		console.log(choice)
		$.ajax({
				type: 'POST',
				url: 'http://localhost:8080/group/isLogged',
				data: {
					username: $('#username').val(),
					password: $('#password').val(),
					choice: choice? choice : "null"
				},
				success: function(data){
					$('#check-login').remove();
				}, statusCode: {
					200: function (response){
						console.log("200 ok");
						window.location.href = "./index.html"
					},
					401: function (response){
						$('body').html(response.responseText);
					}
				}
			});
	}
		
