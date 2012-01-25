function addJs(jsname, pos) {
    if (!pos) {
        pos = 'head';
    }
    var th = document.getElementsByTagName(pos)[0];
    var s = document.createElement('script');
    s.setAttribute('type', 'text/javascript');
    s.setAttribute('src', jsname);
    th.appendChild(s);
}

/*  Example usage
var anything = findVar('window.parent.child.child') || 'default value';
*/
function findVar(v, defaultIfUndefined) {

    var notFound = false;
    try {
        notFound = eval('typeof ' + v + ' === "undefined"');
    } catch (error) {
        if (defaultIfUndefined) {
            return defaultIfUndefined;
        }
        return undefined;
    }

    if (notFound) {
        if (defaultIfUndefined) {
            return defaultIfUndefined;
        }
        return undefined;
    } else {
        return eval(v);
    }
}
/*
Example usage:
if(!findVar('window.anyParent.anyChild.nestedChild')){
putVar('window.anyParent.anyChild.nestedChild');
console.log(window.anyParent.anyChild.nestedChild);
}
*/
function putVar(a) {
    var arr = a.split('.');
    var q = '';
    for (var i = 0; i < arr.length; i++) {
        var c = arr[i];
        if (i > 0) {
            q = q + '.';
        }
        q = q + c;
        var notFound = eval('typeof ' + q + ' === "undefined"');
        if (notFound) {
            eval(q + ' = {level : ' + i + '}; ');
        }
    }
}
function bindTips() {
    if ($.fn.qtip) {
        $('a[title]').qtip(); //replace old browser tips to 'oldtip' attribute
        $('*[tip]').qtip({ content: { attr: 'tip'} });
    }
}
function log(item, options) {
    $.trace(item, options);
}
/*start framework*/
window.initFrameworkRetries = 1;
function initFramework() {
    try {
        initMain();
        initStorageRequest();
        initRoute();
        $.trace('Framework initiated on Try # ' + window.initFrameworkRetries, { title: 'Framework Successfully Initiated!' });
    } catch (error) {
        $.trace(error.toString(), { title: 'Error in initFramework' });
        window.initFrameworkRetries++;
        if (window.initFrameworkRetries < findVar('window.def.fw.initRetries', 20)) {
            window.setTimeout('initFramework()', (100 * window.initFrameworkRetries));
        } else {
            throw 'lots of tries to start framework';
        }
    }
}
/*end start framework*/

/*include framework*/
function includeFramework(view) {
    addJs('/content/js/framework/' + view + '/main.js');
    addJs('/content/js/framework/' + view + '/storage-request.js');
    addJs('/content/js/framework/' + view + '/route.js');
    addJs('/content/js/framework/' + view + '/init-framework.js', 'body');
}
/*end include framework*/
/*Options related functions
1. initOptions()
2.swapOptions(defaults, custom)
3.calcOptions(runtimeOptions)
*/
function swapOptions(defaultOpt, customOpt) {

    if (!defaultOpt) {
        defaultOpt = {};
    }
    if (!customOpt) {
        customOpt = {};
    }
    for (var prop in defaultOpt) {
        if (!defaultOpt.hasOwnProperty(prop)) {
            continue; //jump from prototype properties
        }
        var fromCustom = customOpt[prop];
        if (fromCustom != undefined) {
            defaultOpt[prop] = fromCustom;
        }
    }

    //if custom opts have additional properties those fill in default options
    for (var cprop in customOpt) {
        if (!customOpt.hasOwnProperty(cprop)) {
            continue; //jump from prototype properties
        }
        var fromDefault = defaultOpt[cprop];
        if (fromDefault == undefined) {
            defaultOpt[cprop] = customOpt[cprop];
        }
    }

    return defaultOpt;
}

//Strict Naming convention to calculate options
//a. methodNameDefaults
//b. methodNameGlobals
function calcOptions(runtimeOptions, name) {
    var cn = arguments.callee.caller.name;
    if (!cn || cn == '') {

    }
    var def = eval('window.' + cn + 'Defaults');
    if (!def) {
        def = {};
    }
    var glo = eval('window.' + cn + 'Globals');
    if (!glo) {
        glo = {};
    }
    glo = swapOptions(def, glo);
    var calced = swapOptions(glo, runtimeOptions);
    return calced;
}
function createForm() {
    var submitForm = document.createElement("FORM");
    document.body.appendChild(submitForm);
    return submitForm;
}
function createFormElement(inputForm, elementName, elementValue) {
    var newElement = document.createElement('input');
    newElement.name = elementName;
    newElement.id = elementName;
    newElement.type = 'hidden';
    inputForm.appendChild(newElement);
    newElement.value = elementValue;
    return newElement;
}
function submitForm(form, action, method) {
    if (method) {
        form.method = method;
    } else {
        form.method = "POST";
    }
    if (action) {
        form.action = action;
    } else {
        form.action = window.location;
    }

    form.submit();
}
function restfulSubmit(form) {
    //Decide options    
    var defaults = {
        redirect: null,
        onsuccess: null,
        onerror: null,
        onvalidationerrors: null,
        onunauthorize: null,
        showLoading: true,
        onClientSideInvalid: null,
        onClientSideValid: null,
        finalAction: null // function which HAS to be call at all cost no matter what is response type
    };
    var customOptions = {};
    var optionskey = form.attr('optionskey'); //get options string by the user
    if (!optionskey) {
        optionskey = form.attr('opt'); //get options string by the user
    }


    if (optionskey) {
        customOptions = eval(' window.' + optionskey + ';');
    }

    var options = swapOptions(defaults, customOptions);


    /*Find which validation engine is installed and validate the form*/
    var isFormValid = true;
    if ($.fn.validate) {
        isFormValid = form.valid();
    } else if ($.fn.validationEngine) {
        isFormValid = form.validationEngine('validate');
    }



    if (isFormValid) {
        if (options.onClientSideValid) {
            options.onClientSideValid();
            return;
        }

        if (options.showLoading) {
            $.wait();
        }


        /*$.getJSON(form.attr('action'), form.serialize(), function(res) {
        if (options.showLoading) {
        $.unwait();
        }
        processResponse(res, options);
        });
        */

        var formAction = form.attr('action');
        var formData = form.serialize();
        $.ajax({
            url: formAction,
            dataType: 'json',
            data: formData,
            success: function (res) {
                if (options.showLoading) {
                    $.unwait();
                }
                processResponse(res, options);
            },
            error: function (errorData) {
                var $ajaxErrorData = $.assure({ id: 'AjaxErrorData' });
                $ajaxErrorData.html(errorData.responseText);
                $ajaxErrorData.prepend($('<h2 style="padding: 5px; background-color: red; color: white; font-size: x-large; border: 1px double black;">Exception occured in Ajax request...</h2>'));
                $ajaxErrorData.pop();
                $.unwait();
            }
        });

    } else {
        if (options.onClientSideInvalid) {
            options.onClientSideInvalid();
            return;
        }
    }
}
/*
//{ level: 0, data: {productId:’abc-123’, productName:’Xbox-360’} }
//{ level: 1, message: ‘Product has been updated’ }
//{ level: 2, message: ‘Product has been updated’ , data: {productId:’abc-123’, productName:’Xbox-360’} }
//{ level: 3, message: ‘Product not found’ }
//{ level: 4, message: ‘Product not found’  , data: {productId:’abc-123’, productName:’Xbox-360’} }
//{ level: 5, errors: [{subject: 'ProdName', message: 'Product Name is required'},{subject: 'Zip', message: 'Incorrect Postal code format'}] }
//{ level : 401 , message: ‘Unauthorized’ }
*/
function processResponse(response, options) {
    if (response.data) { //restData
        window.restData = response.data;
    }
    if (response.message) { //restMessage
        window.restMessage = response.message;
    }
    if (response.errors) { //restMessage
        window.restErrors = response.errors;
    }
    var defaults = {
        redirect: null,
        onsuccess: null,
        onerror: null,
        onvalidationerrors: null,
        onunauthorize: null,
        finalAction: null
    };
    options = swapOptions(defaults, options);
    var level = response.level;
    switch (level) {
        case 0:
        case 1:
        case 2:
            if (options.redirect) {
                window.location = options.redirect;
            } else if (options.onsuccess) {
                options.onsuccess();
            } else {
                if (response.message) {
                    $.showMsg(response.message);
                }
            }
            break;
        case 3:
        case 4:
            if (options.onerror) {
                options.onerror();
            } else {
                $.showMsg(window.restMessage, 2);
            }
            break;
        case 5:
            if (options.onvalidationerrors) {
                options.onvalidationerrors();
            } else {
                var s = '<ul class="validation-summary">';
                var cnt = response.errors.length;
                for (var i = 0; i < cnt; i++) {
                    var err = response.errors[i];
                    s = s + '<li>' + err.message + '</li>';
                }
                s = s + '</ul>';
                $.showMsg(s, 3);
            }
            break;
        case 401:
            if (options.onunauthorize) {
                options.onunauthorize();
            } else {
                window.location = '/logon';
            }
            break;
        case 302:
            window.location = response.message;
            break;
    }
    if (options.finalAction) {
        options.finalAction();
    }
}
function getRestResponse(data) {
    var data = eval(data.jqXHR);
    return evalJson(data.responseText);
}
function evalJson(text) {
    var arr = eval('[' + text + ']');
    return arr[0];
}
//IsChecked
function isChecked(chkid) {
    var selector = $('#' + chkid + ':checked');
    if ($(selector).val() == 'on') return true;
    else
        return false;
}
//check the checkboxes
function checkOn(jqs) {
    $(jqs).attr('checked', true);
}
//remove check from checkboxes
function checkOff(jqs) {
    $(jqs).attr('checked', false);
}
function overlayOpt() {
    return {
        // some mask tweaks suitable for facebox-looking dialogs
        mask: {

            // you might also consider a "transparent" color for the mask
            color: '#000',

            // load mask a little faster
            loadSpeed: 200,

            // very transparent
            opacity: 0.7
        },
        effect: 'default',
        load: false
    };
}
/*
function initDynamic(options) {
var elements;
var inContext = false;
if (options) {
if (options.context) {
elements = $('.dynamic', options.context);
inContext = true;
}
}

if (!inContext) {
elements = $('.dynamic');
}

//Bind skins
elements.each(function () {
var el = $(this);
if (!el.data('viewModel')) {
var viewModel = new ViewModel();
el.data('viewModel', viewModel);
}
})
.dataBind({
'skin': "skinId" //Every container will be auto-bound with skinID of its hub
})
.each(function () {
$(this).bindViewModel();
});
}
*/
/* Guid */
function s4() {
    return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
}
function guid() {
    return (s4() + s4() + "-" + s4() + "-" + s4() + "-" + s4() + "-" + s4() + s4() + s4());
}
/* end guid */
function today() {
    return parseDate(new Date());
}
function parseDate(date) {
    return ((date.getMonth() + 1) + '/' + date.getDate() + '/' + date.getFullYear());
}
function stringToDate(date) {
    var arr = date.split('/');
    return new Date(arr[2], arr[0], arr[1]);
}
function dateFromSerialized(value) {
    value = value.toString();
    return new Date(parseInt(value.replace("/Date(", "").replace(")/", ""), 10));
}
function queryArray(array, prop) {
    var arr = new Array();
    for (var i = 0; i < array.length; i++) {
        arr[i] = array[i][prop];
    }
    return arr;
}
function hideVld() {
    $('form').vld('hideAll');
}
function jsonpCall(fullUrl, data, success) {

    $.ajax({
        url: fullUrl,
        dataType: 'jsonp',
        'data': data,
        contentType: "application/json; charset=utf-8",
        jsonp: 'jsonp',
        success: function (d) {
            if (typeof d.Success !== 'undefined' && !d.Success) {
                $.showMsg(d.Error, 2);
                //alert('StreetConnect API call failed, url:' + fullUrl);
                return;
            }
            success(d);
        },
        error: function (data) { alert('StreetConnect API call failed, url:' + fullUrl); }
    });

    return; //returned by asif

    $.ajax({
        'url': url
        , 'data': data
        , 'dataType': 'jsonp'
        , 'statusCode': window.decoders['def']
        , jsonp: 'jsonp'
        , async: false
        , 'success': function (d, e) {
            //debugger;
            if (success) {
                success(d, e);
            }
        }
        , 'error': function (ed, extra) {
            //debugger;
            if (error) {
                error(ed, extra);
            } else {
                $.showMsg('Operation failed', 2);
            }
        }
        , dataFilter: function (rawData) {
            //debugger;
        }
    });

}
function isArray(value){
    return typeof value === 'object';
}
/*
Binding to Scroll to bottom
$(window).scroll(function(){
if  ($(window).scrollTop() == $(document).height() - $(window).height()){
//Code here
}
}); 
*/
function loadJs(path){
	var script = $('<script type="text/javascript" src="'+path+'" />');
	script.appendTo('body');
 }
function watermark(){
	var elements = $('*[data-watermark]');
	var count = elements.length;
	for(var i = 0; i < count; i++){
		var el = $(elements[i]);
		var waterMark = el.attr('data-watermark');
		el.Watermark(waterMark);
	}
}
function removeWatermark(){
	var elements = $('*[data-watermark]');
	var count = elements.length;
	for(var i = 0; i < count; i++){
		var el = $(elements[i]);
		var waterMark = el.attr('data-watermark');
		if(el.val() === waterMark){
			el.val('');
		}
	}
}
function redirectToLoginPage(loginPageUrl){
	var url = window.location.href;
	url = url.substr((url.indexOf('://') + 3), url.length - (url.indexOf('://') + 3));
	url = url.substr((url.indexOf('/')), url.length - (url.indexOf('/')));
	window.location = loginPageUrl + '?ReturnUrl=' + url;
}

function scrollToTop(){
	$('html, body').animate({ scrollTop: 0 }, 1000);
}
function blockedWait(){
	$.blockUI({
	    message: '<img style="display: inline-block !important;" src="/Content/images/loading.gif"  /><span class="blockedMessageText">Please wait loading...</span>',
	    overlayCSS: {
	        opacity: 0.7
	    }
	});
}

function outlineAll() {
    $('*').css('outline', '1px dotted #3E3E3C');
    $('div').css('outline', '1px dotted Maroon');
    $('p').css('outline', '1px dotted DarkBlue');
    $('ul').css('outline', '1px dotted Orange');
    $('li').css('outline', '1px dotted DarkGreen');
    $('span').css('outline', '1px dotted Gray');
    $('img').css('outline', '1px dotted Pink');
    $('a').css('outline', '1px dotted SkyBlue');
}

function removeVideo() {
    var myVideo = document.getElementsByTagName('video')[0];
    if (myVideo) {
        myVideo.src = '';
        myVideo.load();
    }
}

function out(object, title){
	if(title){
		console.log(' --- ' + title + ' --- ');
	}
	console.log(object);
}