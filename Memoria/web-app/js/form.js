/**
 * Created by garciaph on 29/08/17.
 */

$(document).ready(function() {

    // Disable send button after submit the form
    $('form.sendForm').submit(function(){
        $(this).find(':input[type=submit]').prop('disabled', true);
    });

    $('select').material_select();

    // textarea behavior
    $('textarea')
    // stops accepting input after reaching it's maximum length
        .keypress(function(e) {
            if (e.which < 0x20) {
                // e.which < 0x20, then it's not a printable character
                // e.which === 0 - Not a character
                return;     // Do nothing
            }
            if (this.value.length == $(this).data('length')) {
                e.preventDefault();
            } else if (this.value.length > $(this).data('length')) {
                // Maximum exceeded
                this.value = this.value.substring(0, $(this).data('length'));
            }
        })
        // slices input if pasted content exceeds character limit
        .on('paste', function(e) {
            e.clipboardData.getData('text/plain').slice(0, $(this).data('length'));
        });

    // preview selected image on form's image input section
    $(".previewed-image").change(function() {
        readURL($(this), $(this).data('preview-target'));
    });

    // resize already initialized images (edit mode)
    $("img.edit").materialbox().each(function() {
       resizeImageOrientationWise($(this), 180, 180);
    });
});

// function used in image preview
function readURL($input, previewTarget) {
    var $preview = $('#' + previewTarget);

    // read filename from file input and create a new file reader to it
    if ($input.prop('files') && $input.prop('files')[0]) {
        var reader = new FileReader();

        // load file and change 'src' attribute of preview <img> element
        reader.onload = function (e) {
            $preview.attr('src', e.target.result);
            // resize to 180px height (if portrait) or 180px width (if landscape)s
            resizeImageOrientationWise($preview, 180, 180);
            $preview.show();
        };

        reader.readAsDataURL($input.prop('files')[0]);
    }
}

function resizeImageOrientationWise($el, height, width) {
    $el.load(function () {
        if ($el.width() > $el.height()) {
            // landscape
            $el.removeAttr('height');
            $el.attr('width', width);
        } else {
            //portrait or square
            $el.removeAttr('width');
            $el.attr('height', height);
        }
    });
}