var lineStart = 0;
var lineEnd = 0;
var caretPositionStart = 0;
var caretPositionEnd = 0;

// Sets the location of the cursor in specified object to given position
function SetCaretTo(obj, pos) {
    if (obj != null) {
        if (obj.createTextRange) {
            var range = obj.createTextRange();
            range.move('character', pos);
            range.select();
        }
        else if (obj.selectionStart) {
            obj.focus();
            obj.setSelectionRange(pos, pos);
        }
    }
}

// Inserts the macro to caret position (in text area)
function InsertMacroPlain(text, txtAreaId) {
    var obj = document.getElementById(txtAreaId);
    if (obj != null) {
        if (document.selection) {
            // IE
            obj.focus();
            var orig = obj.value.replace(/\r\n/g, '\n');
            var range = document.selection.createRange();
            if (range.parentElement() != obj) {
                return false;
            }
            range.text = text;
            var actual = tmp = obj.value.replace(/\r\n/g, '\n');
            for (var diff = 0; diff < orig.length; diff++) {
                if (orig.charAt(diff) != actual.charAt(diff)) break;
            }
            for (var index = 0, start = 0; tmp.match(text) && (tmp = tmp.replace(text, '')) && index <= diff; index = start + text.length) {
                start = actual.indexOf(text, index);
            }
        } else {
            // Firefox
            var start = obj.selectionStart;
            var end = obj.selectionEnd;
            obj.value = obj.value.substr(0, start) + text + obj.value.substr(end, obj.value.length);
        }
        if (start != null) {
            SetCaretTo(obj, start + text.length);
        } else {
            obj.value += text;
        }
    }
}

// Inserts the macro to caret position (in syntax highlighter).
function InsertMacroExtended(macro, extendedAreaElem, txtAreaId) {

    if ((typeof (extendedAreaElem) != 'undefined') && (extendedAreaElem != null)) {
        // Check whether the ExtendedArea is used
        var pos = extendedAreaElem.getCursor();
        if ((pos.line == null) && (window.addEventListener)) {
            var start = { node: extendedAreaElem.getLine(lineStart), offset: caretPositionStart };
            var end = { node: extendedAreaElem.getLine(lineEnd), offset: caretPositionEnd };
            extendedAreaElem.editor.replaceRange(start, end, macro);
        }
        else {
            extendedAreaElem.replaceSelection(macro);
        }
        var newPos = { line: pos.line, ch: pos.ch + macro.length };
        extendedAreaElem.setSelection(newPos, newPos);
    }
    else {
        // If extended area is not used, try to insert to normal text area
        insertMacroPlain(macro, txtAreaId);
    }
}