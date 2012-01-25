/* form data to json and json string */
(function ($) {
    function track($obj) {
        if (window.console && window.console.log)
            window.console.log('unbindHover selection count: ' + $obj.size());
    };
    $.fn.toJson = function () {
        return form2object($(this)[0], '.', false, null);
    };
    $.fn.toJsonString = function () {
        return JSON.stringify($(this).toJson(), null, '\t');
    }; /* ====== unbindHover (asif.log@gmail.com :: 8/19/2011) === */
    //call $(selector).unbindHover({})***defaults: $.unbindHover.defaults.debug = false***override: $.unbindHover.func = function(element,opt){}
    $.fn.unbindHover = function (options) {
        if (options) {
            if (options.debug) {
                track(this);
            }
        }

        var opts = $.extend({}, $.fn.unbindHover.defaults, options);
        return this.each(function () {
            opt = $.meta ? $.extend({}, opts, $this.data()) : opts;
            $this = $(this);
            $.fn.unbindHover.func($this, opt);
        });
    };
    $.fn.unbindHover.func = function (element, opt) {
        if (opt.debug) {
            debugger;
        }
        /* Implementation */
        element.unbind('mouseover');
        element.unbind('mouseenter');
        element.unbind('mouseleave');
        /* End Implementation */
    };
    $.fn.unbindHover.defaults = {
        debug: false
    };
    /* ||||||||||||||||||| end unbindHover |||||||||||||||||||| */
    /* ====== trace  .............  (asif.log@gmail.com :: 8/19/2011) === */
    //call $(selector).trace({})***defaults: $.trace.defaults.debug = false***override: $.trace.func = function(element,opt){}
    $.fn.trace = function (options) {
        track(this);
        var opts = $.extend({}, $.fn.trace.defaults, options);
        return this.each(function () {
            opt = $.meta ? $.extend({}, opts, $this.data()) : opts;
            $this = $(this);
            $.fn.trace.func($this, opt);
        });
    };
    $.fn.trace.func = function (element, opt) {
        if (opt.debug) {
            debugger;
        }
        /* Implementation */
        if (window.console) {
            if (opt.title) {
                window.console.log('--- ' + opt.title + '--- ');
            }
            window.console.log(element);
        }
        /* End Implementation */
    };
    $.fn.trace.defaults = {
        debug: false,
        title: ''
    };
    //call $.trace({})***defaults $.trace.defaults.debug = false***override $.trace.func = function(opt){}
    $.trace = function (obj, opt) {
        var options = $.trace.defaults;
        $.extend(options, opt);
        if (options.debug) {
            debugger;
        }
        /* Implementation */
        if (window.console) {
            if (options.title) {
                window.console.log('--- ' + options.title + '---');
            }
            window.console.log(obj);
        }
        /* End Implementation */
    };
    $.trace.defaults = {
        debug: false
    };
    /* ||||||||||||||||||| end trace ||||||||||||||||||| */
    /* ||||||||||||||||||| end trace ||||||||||||||||||| */
    /* ====== block  .............  (asif.log@gmail.com :: 8/15/2011) === */
    //call $.block({})***defaults $.block.defaults.debug = false***override $.block.func = function(opt){}

    $.wait = function (options) {
        //$('#wait-popup').hide();
        var o = $.wait.defaults;
        $.extend(o, options);
        //$.block(o.maskCss);
        var element = $.assure({ id: 'wait-popup' });
        var inner = $('<div class="text">' + o.text + '</div>');
        inner.css(o.textCss);
        element.html('');
        inner.appendTo(element);
        element.center();
        o.css.top = '10px';
        element.css(o.css);
        element.show();
    };
    $.wait.defaults = { text: 'Please wait loading...', css: {}, textCss: {}, maskCss: {} };
    $.unwait = function () {
        $('#wait-popup').hide();

        if (window.elementOnModal) {

        } else {
            //$.unblock();
        }
    }; ////////////end mask/////////////
    /* positioning extensions */
    /*
    1. $(selector).center()
    2. $(selector).centerX()
    3. $(selector).centerY()
    */
    jQuery.fn.center = function (options) {

        this.css("position", "fixed");
        this.centerY(options);
        this.centerX(options);
        return this;
    };
    jQuery.fn.centerY = function (options) {
        var opt = { context: window };
        $.extend(opt, options);
        this.css("position", "fixed");
        this.css("top", ($(opt.context).height() - this.height()) / 2 + $(opt.context).scrollTop() + "px");
        return this;
    };
    jQuery.fn.centerX = function (options) {

        var opt = { context: window };
        $.extend(opt, options);
        this.css("position", "fixed");
        this.css("left", ($(opt.context).width() - this.width()) / 2 + $(opt.context).scrollLeft() + "px");
        return this;
    };
    jQuery.showMsg = function (msg, code) {
        $('.info-message').hide();
        jQuery.fn.centerHorizontally = function () {
            this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
            return this;
        };
        var background = '#4485AD';
        var fontSize = '17px';
        if (code === 2) {
            background = 'Maroon';
        }
        if (code === 3) {
            background = 'Maroon';
            fontSize = '13px';
        }

        //send an array of string errors
        if (code === 4) {
            var arr = msg;
            var arrCnt = arr.length;
            var sb = '<ul>';
            for (var i = 0; i < arrCnt; i++) {
                var current = arr[i];
                sb = sb + '<li>' + current + '</li>';
            }
            sb = sb + '</ul>';
            msg = sb;

            background = 'Maroon';
            fontSize = '13px';
        }

        if ($('.info-message').size() < 1) {
            var $n = $('<div class="info-message">' + msg + '</div>');
            $n.css('display', 'none');
            $('body').append($n);
        }

        var $m = $('.info-message');
        $m.css({
            'background-color': background,
            'font-size': fontSize
        });
        $('.info-message').html(msg);
        $m.centerHorizontally();
        $('.info-message').fadeIn('slow');
        $m.addClass('info-message-style');
        if (window.infoTimeout) {
            window.clearTimeout(window.infoTimeout);
        }
        window.infoTimeout = setTimeout('jQuery.hideMsg()', 5000);
    };
    jQuery.hideMsg = function () {
        var $m = $('.info-message');
        $m.fadeOut('slow');
    }; ////////////////////* Overlay functions  *////////////////////////////
    // 1. $(selector).pop({css:{}}); //all over lay options work by options object
    // 2. $(selector).popLoad(url, {css:{}});//all over lay options work by options object
    // 3. $.popLoad(url, {css:{}});//all over lay options work by options object
    // 4. $.popClose();
    //this only works when jquery.tools overlay is referred, we can even send all supporting options
    /*help: $('#id').pop({ css:{top: '1px'} }); //pop with ANY jquery element   */
    jQuery.fn.pop = function (options) {
        $(this).addClass('overlay');
        var myopt = {
            speed: 500,
            mask: {
                color: '#000',
                // load mask a little faster
                loadSpeed: 200,
                // very transparent
                opacity: 0.5
            }
        };
        var swappedOpt = $.extend(myopt, options);
        $(this).overlay(swappedOpt);
        $(this).data("overlay").load();
        if (options) {
            if (options.css) {
                $(this).css(options.css);
            }
        }
    }; /*help: $('#id').popLoad('/list/show', { css:{top: '1px'} }); //popLoad with url for ajax load */
    jQuery.fn.popLoad = function (url, options) {
        $.wait();
        $(this).addClass('overlay');
        $(this).load(url, function () {
            var myopt = {
                speed: 500,
                mask: {
                    color: '#000',
                    // load mask a little faster
                    loadSpeed: 200,
                    // very transparent
                    opacity: 0.5
                }
            };
            var swappedOpt = swapOptions(myopt, options);
            $(this).overlay(swappedOpt);
            $(this).data("overlay").load();
            if (options) {
                if (options.css) {
                    $(this).css(options.css);
                }
            }
            $(this).show();
            $.unwait();
        });
    }; /*help: $.popLoad('/items', { css:{top: '1px'} }); //$.popLoad with url, no container needed */
    jQuery.popLoad = function (url, options) {
        var $container = $.assure({ class: 'pop-container' });
        $container.text('please wait loading');
        $container.popLoad(url, options);
    };
    jQuery.pop = function (html, options) {
        var $container = $.assure({ class: 'pop-container' });
        $(html).appendTo($container);
        $container.pop();
    };
    $.popClose = function () {
        $('.close').trigger('click');
    }; ////////////////////*End of Overlay functions.........*////////////////////////////
    $.fn.modal = function (options) {

        var el = $(this);
        window.elementOnModal = el;
        $.block();
        var cnt = $.assure({ id: 'modal-wrap' });
        cnt.html('');
        cnt.centerX();
        var cnv = $('<div id="modal-canvas"></div>');
        var cls = $('<img class="modal-close" src="/Content/images/close.png" />');
        cls.appendTo(cnt);
        cnv.appendTo(cnt);
        el.appendTo(cnv);
        cnt.show();
        window.elementOnModal.show();

        if (!options) {
            options = {};
        }
        if (!options.unmodalUrl) {
            options.unmodalUrl = '#/';
        }
        window.unmodalUrl = options.unmodalUrl;

        $('.modal-close').live('click', function () {
            $.unmodal();
        });
        $('#modal-wrap').center();
    };
    $.unmodal = function () {
        $('#modal-wrap form').validationEngine('hide');
        $('#modal-wrap').hide();
        if (window.elementOnModal) {
            window.elementOnModal.appendTo('body');
            window.elementOnModal.hide();
            window.elementOnModal = null;
        }
        $.unblock();
        if (window.unmodalUrl) {
            var url = window.unmodalUrl;
            window.unmodalUrl = null;
            window.location = url;
        }
    };
    $.assure = function (options) {
        var def = {
            'id': null,
            'class': null
        };
        $.extend(def, options);
        var selector = def.id ? '#' + def.id : '.' + def.class;
        var $existing = $(selector);
        if ($existing.size() > 0) { //if found return
            return $existing;
        }
        else {
            var html = '<div';
            if (def.id) {
                html = html + ' id="' + def.id + '" ></div>';
            } else {
                html = html + ' class="' + def.class + '" ></div>';
            }
            $(html).appendTo('body');
        }
        return $(selector);
    }; /* Takes viewModel from data collection and use ko.applyBindings(viewMode,this) */

    /*
    $.fn.bindViewModel = function () {
    var el = $(this);
    var viewModel = el.data('viewModel');
    if (viewModel) {
    ko.applyBindings(viewModel, el[0]);
    }
    };
    */
    /* call setSkin method from viewModel and provides given skin ID and options */
    /*$.fn.skin = function (skinId, options) {
    var el = $(this);
    var viewModel = el.data('viewModel');
    if (viewModel) {
    viewModel.setSkin(''); //remove id to empty the element
    viewModel.setSkin(skinId, options); //apply id
    }
    };*/

    $.fn.skin = function (id, options) {
        var element = this;
        var el = $(element);
        if (!options) {
            options = {};
        }
        /* if DOM element does not exist we need to set template path */
        var elementExists = $('#' + id).size() > 0;
        //Decide template path
        if (!elementExists) {
            if (!el.attr('skins') && !options.templateUrl) {
                throw 'Since ' + id + ' could not be found, the dynamic element should have skins attribute which is missing currently. Or add templateUrl option';
            }
            if (options.templateUrl) {
                options.templateUrl = win.def.ko.cdnUrl(options.templateUrl);
            }
        }

        if (!id) {
            $(element).html('');
            return;
        }
        //load options
        var opt = {
            templateUrl: el.attr('skins') ? win.def.ko.cdnUrl(el.attr('skins')) : null,
            data: null
        };

        $.extend(opt, ww.def.ko); //Extend from runtime options
        $.extend(opt, options); //Extend from runtime options
        if (elementExists) {
            opt.templateUrl = null;
        }
        var $el = $(element);
        $el.applyTemplate(id, opt.data, opt);
    }

    $.fn.layout = function (id, data) {
        var el = $(this);
        if (!data) {
            data = {};
        }
        el.html(''); //emptying
        $(id).tmpl(data).appendTo(el); //refilling
    }
    $.fn.popup = function (id, data, unmodalUrl) {
        $.assure({ id: 'popup' });
        $(this).layout(id, data);
        if (!unmodalUrl) {
            unmodalUrl = '#/';
        }
        $('#popup').modal({ 'unmodalUrl': unmodalUrl });
    }
    /* ====== applyTemplate  .............  (asif.log@gmail.com :: 8/27/2011) === */
    /*
    (1)id [requierd]: the Id of the template
    (2)data [Nullable]: data is a function which is basically Data to apply
    (3)options: {
    debug: break if needed
    templateUrl: if template was not found then it will be loaded from the given url
    loadDataByAjax: whether to load data by ajax or not
    dataOptions: {
    url: url to load data
    data: post data
    type: POST or GET or PUT or DELETE
    },
    viewModel: ViewModel to settle current dataModel
    callback: callback function after skin application}
    */
    $.fn.applyTemplate = function (id, data, options) {
        if (options) {
            if (options.debug) {
                track(this);
            }
        }
        var opts = $.extend({}, $.fn.applyTemplate.defaults, options);
        return this.each(function () {
            opt = $.meta ? $.extend({}, opts, $this.data()) : opts;
            $this = $(this);
            $.fn.applyTemplate.func($this, id, data, opt);
        });
    };
    $.fn.applyTemplate.func = function (element, id, data, opt) {
        if (opt.debug) {
            debugger;
        }
        /* Implementation */
        if (opt.waitHandler) {
            opt.waitHandler();
        }
        if (opt.debug) {
            $.trace('--applyTemplate extension--');
            $.trace({ 'element': element, 'id': id, 'opt': opt, 'data': data });
        }


        var template = $('#' + id);
        if (template.size() > 0) { // if template found
            if (data) { //both template Data found

                var container = $(element); //container element
                var html = template.tmpl(data); //extract html from template
                container.html(''); // empty container
                html.appendTo(container); // append html to the container

                var dataBindgsFound = findVar('window.' + id + 'Bindings');
                if (dataBindgsFound) {
                    dataBindgsFound();
                }

                //if localBindTip
                try {
                    eval(id + 'BindTip(); ');
                } catch (error) { }

                try {
                    eval(id + 'Validation(); ');
                } catch (error) { }
                if (opt.debug) {
                    debugger;
                }
                if (opt.unwaitHandler) {
                    opt.unwaitHandler();
                }

                /* Callback */
                if (opt.callback) {
                    /*id, element, data, opt*/
                    opt.callback({
                        'id': id,
                        'element': element,
                        'data': data,
                        'options': opt
                    });
                }
            } else { //if data was not present		
                throw 'data loading mechanism is not defined yet';
            }
        } else { //element not found
            (function (__element, __id, __data, __options) {
                $.ajax({
                    url: __options.templateUrl.indexOf('?') != -1 ?
                    __options.templateUrl.indexOf('?') : __options.templateUrl + '?' + s4() + '=' + s4(),
                    success: function (html) {
                        $(html).appendTo('body'); // Append html to body
                        //..... after appending to body code
                        $(__element).applyTemplate(__id, __data, __options);
                        //.........end after appending code to body
                    }
                });
            })(element, id, data, opt);
        }
        /* End Implementation */
    };
    $.fn.applyTemplate.defaults = {
        debug: false,
        templateUrl: '',
        data: null,
        viewModel: null,
        callback: null,
        waitHandler: null,
        unwaitHandler: null,
        dataLoaded: false
    };
    /* ============================ end applyTemplate============================= */
    $.fn.reach = function () {
        return this.each(function () {
            $('html, body').animate({
                scrollTop: $(this).offset().top
            }, 500);
        });
    }


    /*Loading on a specific element*/
    $.fn.isLoading = function (bool, opts) {
        $.hideAllLoadings();
        var options = $.extend({}, $.fn.isLoading.defaults, opts);
        $.trace(bool, { title: 'is loading? ', 'debugging': options.debugging });
        var el = $(this);
        $.assure({ id: 'swirl' });
        var swirl = $('#swirl');
        swirl.addClass('swirl');
        if (bool) {
            //el.attr('disabled','disabled');
            $.trace(swirl.size(), { title: 'number of swirl elements ', 'debugging': options.debugging });
            var img = $('<img src="/content/images/loading.gif" />');
            swirl.html('');
            img.appendTo(swirl);
            swirl.position({
                my: 'left',
                at: 'right',
                of: el,
                offset: options.offset
            });
            swirl.show();
        } else {
            el.removeAttr('disabled');
            swirl.hide();
        }
    };
    /*End isLoading*/
    $.fn.isLoading.defaults = {
        debugging: false,
        offset: '0 0'
    };
    $.hideAllLoadings = function () {
        $('.swirl').remove();
    }


    /*first parameter message and second the class name to apply*/
    $.fn.message = function (msg, code) {
        var el = $(this);
        el.removeClass();
        el.addClass('messages');
        el.addClass(code);
        el.text(msg);
        el.show();
    }

    $.fn.alive = function (eventName, handlerFunction) {
        var el = $(this);
        el.die(eventName);
        el.live(eventName, handlerFunction);
    }

    //click on the validation error should hide it
    $('.formErrorContent').live('click', function () {
        $(this).fadeOut();
    });

    $.fn.validateField = function () {
        var el = $(this);
        var result = el.closest('form').validationEngine('validateField', '#' + el.attr('id'));
        return !result;
    }

    $.fn.showValidationError = function (text) {
        $(this).validationEngine('showPrompt', text, 'load', 'topRight', true);
    }

    $('img[href],div[href],span[href],live[href],td[href],button[href],input[href]').live('click', function () {
        var el = $(this);
        window.location = el.attr('href');
    });

})(jQuery);
