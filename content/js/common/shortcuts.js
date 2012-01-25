window.win = window;
window.ww = window;
window.id = function (elementId) {
    return $('#' + elementId);
}
window.q = function (elementId) {
    return $(elementId);
}
$.fn.vld = function (options) {
    return $(this).validationEngine(options);
}