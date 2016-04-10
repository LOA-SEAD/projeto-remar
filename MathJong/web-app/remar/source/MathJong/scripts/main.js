require.config({
    paths: {
        "jquery": "./libs/jquery-1.8.1",
		"ui": "./libs/jquery.ui",
    }
});

require(['jquery', 'interface'], function ($, Interface) {
    $(document).ready(function () {
		Interface.iniciar();
    });
}); 
