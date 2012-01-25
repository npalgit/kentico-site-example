$(function () {
    //link-button and linkButton prevent default
    $('.linkButton, .link-button').live('click', function (event) {
        event.preventDefault();
    });
    $('.linkButton, .link-button').css('cursor', 'pointer');


    //table even odd class
    $('.styled-table tbody tr').hover(function () {
        $(this).addClass('odd');
    }, function () {
        $(this).removeClass('odd');
    });

    //click and hide msg
    $('.info-message').live('click', function () {
        $.hideMsg();
    });
});
