var tablesConfigurations = {};

$.fn.pageMe = function(opts) {
    var $table = this,
        defaults = {
            activeColor: 'blue',
            perPage: 10,
            showPrevNext: false,
            nextText: '',
            prevText: '',
            hidePageNumbers: false,
            perPageOptions: [5, 10, 15]
        },
        settings = $.extend(defaults, opts);
    var $pager         = $('.pager');
    var $select        = $('.pager-select');
    var $children      = $table.children().not('.hidden');
    var perPage        = settings.perPage;
    var perPageOptions = settings.perPageOptions;

    tablesConfigurations[$table] = settings;

    if (typeof settings.childSelector != 'undefined') {
        $children = $table.find(settings.childSelector);
    }

    if (typeof settings.pagerSelector != 'undefined') {
        $pager = $(settings.pagerSelector);
    }

    if (typeof settings.searchSelector != 'undefined') {

    }

    var numItems = $children.size();
    var numPages = Math.ceil(numItems / perPage);

    $("#total_reg").html(numItems);

    $pager.data("curr", 1);

    if(numPages > 1) {
        if (settings.showPrevNext) {
            $('<li class="prev_link"><a href="#!" title="' + settings.prevText + '"><i class="material-icons">chevron_left</i></a></li>').appendTo($pager);
        }

        var curr = 0;
        while (numPages > curr && (settings.hidePageNumbers == false)) {
            $('<li class="page_link waves-effect waves-light"><a href="#!">' + (curr + 1) + '</a></li>').appendTo($pager);
            curr++;
        }

        if (settings.showPrevNext) {
            $('<li class="next_link"><a href="#!" title="' + settings.nextText + '"><i class="material-icons">chevron_right</i></a></li>').appendTo($pager);
        }
    }

    $pager.find('.page_link:first').addClass('active');
    $pager.find('.prev_link').disable();

    if (numPages <= 1) {
        $pager.find('.next_link').disable();
    }

    if (numPages >= 1) {
        $pager.children().eq(1).addClass("active " + settings.activeColor);
    }

    $children.hide();
    $children.slice(0, perPage).show();

    $('.page_link').click(function () {
        var clickedPage = $(this).children('a').html().valueOf();
        goTo(clickedPage);
        return true;
    });

    $('.prev_link').click(function () {
        if ($(this).hasClass('disabled')) return false;

        previous();
        return true;
    });

    $('.next_link').click(function () {
        if ($(this).hasClass('disabled')) return false;

        next();
        return true;
    });

    if ($select) {
        for (var i = 0; i < perPageOptions.length; i++) {
            var option = perPageOptions[i];
            var $el = $('<option value="' + option + '">' + option + '</option>');

            if ($el)

            $el.appendTo($select);
        }

        $select.material_select();
        $select.change(function () {
            var selectedValue = this.value;

            settings.perPage = selectedValue;

            $select.material_select('destroy');
            $select.unbind('change');
            $select.empty();
            $pager.empty();

            $table.pageMe(settings);
        });
    }

    $table.addClass('active');

    function previous() {
        var page = parseInt($pager.data("curr")) - 1;
        goTo(page);
    }

    function next() {
        var page = parseInt($pager.data("curr")) + 1;
        goTo(page);
    }

    function goTo(page) {
        var startAt = (page - 1) * perPage,
            endOn = startAt + perPage;

        $children.css('display', 'none').slice(startAt, endOn).show();

        if (page > 1) {
            $pager.find('.prev_link').enable();
        }
        else {
            $pager.find('.prev_link').disable();
        }

        if (page < numPages) {
            $pager.find('.next_link').enable();
        }
        else {
            $pager.find('.next_link').disable();
        }

        $pager.data("curr", page);
        $pager.children().removeClass("active");
        $pager.children().eq(page).addClass("active " + settings.activeColor);
    }
};

$.fn.reloadMe = function() {
    if (!this.hasClass('active')) return;

    var $select = this.closest('.table-container').siblings().find('.pager-select');
    var $pager  = this.closest('.table-container').siblings().find('.pager');

    $select.material_select('destroy');
    $select.unbind('change');
    $select.empty();
    $pager.empty();

    this.pageMe(tablesConfigurations[this]);
    this.children('.hidden').each(function() {
        $(this).hide();
    });

    return true;
};

$.fn.disable = function() {
    $(this).addClass('disabled');
};

$.fn.enable = function() {
    $(this).removeClass('disabled');
};
