function changeBanner(index) {
    var url = 'url("/content/images/home-banner-' + index + '.png")';
    console.log(url);
    console.log($('.topContent .banner').css('background-image'));
    $('.topContent .banner').css({
        'background-image': url
    });
}

window.config = {
    devMode: false
};

$(function () {
    if (config.devMode) {
        outlineAll();
    }

    $('#btnContact').live('click', function () {
        var el = $(this);
        var form = $('form');
        form.validationEngine('attach');
        if (form.validationEngine('validate')) {
            $.showMsg('Thank you! We will contact with you');
        }
        return false;
    });

    $('#btnLoginBot').live('click', function () {
        $.post('/cmsTemplates/sef/botlogin.ashx', {

            login: $('#login').val(),
            password: $('#password').val()

        }, function (data) {
            if (data == '0') {
                $.showMsg('Wrong username or password, Please try again.', 2);
            } else {
                window.location = '/Secure.aspx';
            }
        });
    });

    $('#btnLogoutBot').live('click', function () {
        $.post('/cmsTemplates/sef/botlogout.ashx', {}, function (data) {
            window.location = '/About-us/Board-of-Trustees.aspx';
        });
    });


    function popModal(jElement) {
        $.blockUI({ message: jElement, css: { top: '100px'} });
        $('<div class="close-modal">click here to close</div>').appendTo(jElement.parent());
        window.onModalItem = jElement;
    }

    $('.open-modal').live('click', function () {
        var el = $(this);
        popModal(el.find('.modal'));
    });

    $('.close-modal').live('click', function () {
        $.unblockUI();
    });

    //pre-load banner images
    $.imgpreload([
    '/content/images/home-banner-1.png',
    '/content/images/home-banner-2.png',
    '/content/images/home-banner-3.png'], function () { });

    $('.timeline a').live('click', function () {
        var other = $('.timeline a.active');
        var el = $(this);
        other.removeClass('active');
        el.addClass('active');
        var target = $('.' + el.parent().attr('data-rel'));
        if (target.size() > 0) {
            $('html, body').animate({
                scrollTop: target.offset().top
            }, 1000);
        }
    });

    $('.backToTopLink').live('click', function () {
        scrollToTop();
    });

    $('.banner .link').live('click', function () {
        var el = $(this);
        var index = el.attr('data-index');
        changeBanner(index);
    });

});
