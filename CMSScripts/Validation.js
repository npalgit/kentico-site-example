function GetHTMLContent(url) {
    if (url) {
        return $j.ajax({
            url: url,
            async: false
        }).responseText;
    }
    return null;
}

function LoadHTMLToElement(elementId,url) {
    var element = document.getElementById(elementId);
    var content = GetHTMLContent(url);
    if (content && content != '' && content != 'null') {
        element.value = escape(content);
    }
}

function LoadHTMLToElementAsync(elementId, url) {
    var element = document.getElementById(elementId);
    if (element && url) {
        $j.ajax({
            url: url,
            async: true,
            success: function(data) {
                if (data && (data != '') && (data != 'null')) {
                    element.value = escape(data.toString());

                }
            },
            complete: function() {
                if (window.LoadHTMLToElementAsyncCompleted) {
                    window.LoadHTMLToElementAsyncCompleted();
                }
            }
        })
    }
}