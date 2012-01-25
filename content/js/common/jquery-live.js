$(function () {
    $('#full-screen-mask').live('click', function () {
        //$.unmodal();
    });
    $('input[data-action],button[data-action]').live('click', function () {
        var el = $(this);
        if (el.attr('data-action')) {
            var metaData = el.metadata({ type: 'attr', name: 'data-action' });
            if (metaData.action) {
                metaData.action(metaData);
            }
        }
    });
    //buttons which send data to routes, change the action on their forms to the rel value and submit form for routes to catch
    $('input[type="submit"][rel],button[type="submit"][rel]').live('click', function () {
        var el = $(this);

        if (el.attr('data-route')) {
            window.routeData = el.metadata({ type: 'attr', name: 'data-route' });
        } else {
            window.routeData = null;
        }

        var form = el.closest('form');
        form.attr('method', 'post');
        var avoidVal = false;
        //Has route data, do something automatic
        if (window.routeData) {

            //confirmation
            if (window.routeData.confirm) {
                var confirmation = window.confirm(window.routeData.confirm);
                if (!confirmation) {
                    return false;
                }
            }

            //avoid validation
            if (window.routeData.noValidation) {
                form.attr('action', el.attr('rel'));
                form.validationEngine('detach');
                avoidVal = true;
            }
        }

        //Validate and submit form
        //do validation as default action
        if (!avoidVal) {
            form.vld();
            if (form.vld('validate')) {
                form.attr('action', el.attr('rel'));
            } else {
                return false;
            }
        }
    });

    //restful forms button automation
    $('.rest').live('click', function () {
        var btn = $(this);
        var form = btn.closest('form'); //get closest form element 
        restfulSubmit(form);
    });

    $('a[href^="#/"]').live('click', function () {
        var el = $(this);
        if (el.attr('data-route')) {
            window.routeData = el.metadata({ type: 'attr', name: 'data-route' });
        } else {
            window.routeData = null;
        }
    });

    $('.hide-vld').live('click', function () {
        $('form').validationEngine('hide');
    });

    $('.resetUrl').live('click', function () {
        window.location = '#/';
    });

	$.imgpreload(['/content/images/loading.gif'], function() {  });
});
