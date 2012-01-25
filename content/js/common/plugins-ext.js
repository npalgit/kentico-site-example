//validation engine
$(function () {
    $.validationEngineLanguage.allRules["dateUS"] = {
        "regex": /^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$/,
        "alertText": "* Correct format mm/dd/yyyy"
    };
});
