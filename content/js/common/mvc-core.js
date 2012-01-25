if (!window.decoders) {
    window.decoders = {
        def: {
            200: function () {
                console.log('OK 200');
            }
            , 204: function () {
                console.log('204 No Content');
            }

            , 301: function () {
                console.log('301 Moved Permanently');
            }
            , 302: function (a, b) {
                debugger;
                console.log('302 Found');
            }
            , 307: function () {
                console.log('307 Temporary Redirect (since HTTP/1.1)');
            }

            , 400: function () {
                console.log('Bad request 400');
            }
            , 401: function () {
                $.showMsg('You are not authorized to perform this action', 2);
                window.ajaxCallHandledByStatusCode = true;
                console.log('Unauthorized 401');
            }
            , 403: function () {
                console.log('Forbidden 403');
            }
            , 404: function () {
                console.log('Not found 404');
            }
            , 405: function () {
                console.log('405 Method Not Allowed');
            }


            , 500: function () {
                console.log('Internal Error 500');
            }
            , 501: function () {
                console.log('501 Not Implemented');
            }
            , 502: function () {
                console.log('502 Bad Gateway');
            }
            , 503: function () {
                console.log('503 Service Unavailable');
            }
            , 504: function () {
                console.log('504 Gateway Timeout');
            }

        }
    };
}
if (!window.store) {
    window.store = {
        ajax: function (type, url, data, successFunction, decoderName) {
            if (typeof data === 'function') {
                successFunction = data;
                data = {};
            }

            if (!decoderName) {
                decoderName = 'def';
            }
            var decoder = window.decoders[decoderName];
            decoder['200'] = successFunction;
            window.ajaxOK = true;            
            $.wait();
            
            $.ajax({
                'url': url,
                'type': type,
                'data': data,                
                'statusCode': decoder,
                complete: function (jqXHR, textStatus) {
                    $.unwait();
                    if (jqXHR.statusText === 'error' && !window.ajaxCallHandledByStatusCode) {
                        window.ajaxOK = false;
                        $.showMsg('There was an error in processing of this action', 2);
                    } else {
                        if (jqXHR.responseText != '') {
                            try {
                                var jsonResponse = $.parseJSON(jqXHR.responseText);
	                            //respond to special codes
	                            if(jsonResponse.status === 'code'){
		                            if(jsonResponse.code){
			                            if(jsonResponse.code == '401'){
				                            redirectToLoginPage('/home/login');
			                            }
		                            }
	                            }
                            } catch (exception) {
                                var authenticationFlag = jqXHR.responseText.indexOf('authenticationFlag') > -1;
                                if (authenticationFlag) {
                                    redirectToLoginPage('/home/login');
                                }
                                return;
                            }
                        }
                    }

                    //Stadard way to show error which was coming from backend
                    if (jqXHR.responseText) {
                        var responseData = $.parseJSON(jqXHR.responseText);
                        if (responseData.Status) {
                            if (responseData.Status === 'error') {
                                window.ajaxOK = false;
                                if (responseData.Message) {
                                    $.showMsg(responseData.Message, 2);
                                }
                            }
                        }
                    }

                    window.ajaxCallHandledByStatusCode = null;
                },
                error: function () {
                    $.showMsg('Operation failed', 2);
                }
            });
        }
        , get: function (url, data, successFunction, decoderName) {
            window.store.ajax('get', url, data, successFunction, decoderName);
        }
        , post: function (url, data, successFunction, decoderName) {
            window.store.ajax('post', url, data, successFunction, decoderName);
        }
    };
}
if (!window.view) {
    window.view = {};
}
if (!window.routing) {
    window.routing = {
        content: function (url, templateId, loadingFuncName){ //load content
	        //add version to the file
	        url = url + '?_=' + window.version;
            var template = $('#' + templateId);
            if (template.size() < 1) {
                $.wait();
                store.get(url, function (html) {
                    
                    $(html).appendTo('body');                    
                    
                    if (loadingFuncName) {
                        if(typeof loadingFuncName === 'function'){
                            loadingFuncName();                            
                        }else{
                            if (window[loadingFuncName]) {
                                window[loadingFuncName]();
                            }
                        }
                    }
                    
                    $.unwait();
                });
            } else {


                if (loadingFuncName) {
                    if (typeof loadingFuncName === 'function') {
                        loadingFuncName();
                    } else {
                        if (window[loadingFuncName]) {
                            window[loadingFuncName]();
                        }
                    }
                }



            }
        } //end load content
        , before: function (routingRequest) { //before 
            window.req = routingRequest;
            window.query = {};
            (function () {
                var e,
                a = /\+/g,  // Regex for replacing addition symbol with a space
                r = /([^&=]+)=?([^&]*)/g,
                d = function (s) { return decodeURIComponent(s.replace(a, " ")); },
                q = window.location.search.substring(1);

                while (e = r.exec(q))
                    window.query[d(e[1])] = d(e[2]);
            })();
            $.assure({ id: 'popup' });
        }
        , root: function () {
            $.unmodal();
            $('#popup').html('');
        }
    };
}
/* Routing Template
$(function () {
window.router = Sammy(function () {
this.before(function (req) {
window.routing.before(req);            
});

this.get('#/', function () {
            
});

});
    
window.router.run('#/');
});
*/
