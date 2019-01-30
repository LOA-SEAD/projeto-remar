/**
 * Created by marcus on 11/05/16.
 */
$(function () {

    $('.license-info').each(function() {
        var $el = $(this);
        var license = $(this).data('license');
        var img, href;

        if (license == "cc-by-sa") {
            img = 'https://i.creativecommons.org/l/by-sa/4.0/88x31.png';
            href = 'http://creativecommons.org/licenses/by-sa/4.0/';
        } else if (license == "cc-by-nc-sa") {
            img = 'https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png';
            href = 'http://creativecommons.org/licenses/by-nc-sa/4.0/';
        }

        $el
        .empty()
        .append('<a target='_blank' rel="license" href="' + href + '">'
            + '<img alt="Creative Commons License" src="' + img + '">'
            + '</a>');

        if (!$el.hasClass('license-image-only')) {
            $el.append('Esta obra está licenciada com uma Licença <a target='_blank' rel="license" href="' + href + '">Creative Commons Atribuição-CompartilhaIgual 4.0 Internacional</a>.');
        }
    });
});

$('#submit').on('click', function() {
    if(!grecaptcha.getResponse().length) {
        return false;
    }
});

