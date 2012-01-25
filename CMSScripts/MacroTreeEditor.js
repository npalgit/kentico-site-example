var documentOnClick = null;
var macroTreeHasFocus = false;
var rtl = (document.body.className.indexOf('RTL') >= 0);

// Inserts the macro to caret position (in syntax highlighter).
function InsertToMacroEditor(macro, extendedAreaElem) {

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
        extendedAreaElem.setSelection(pos, { line: pos.line, ch: pos.character + macro.length });
    }
}


// Handles the macro tree node click
function nodeClick(macro, editorElem, pnlMacroTreeId) {
    if (editorElem != null) {
        if ((macro != null) && (macro != '')) {
            if (InsertToMacroEditor) {
                InsertToMacroEditor(macro, editorElem);
            } else {
                editorElem.setValue(macro);
            }
        }
        showHideMacroTree(pnlMacroTreeId);
    }
}

function hideMacroTree(pnlMacroTreeId) {
    if (!macroTreeHasFocus) {
        showHideMacroTree(pnlMacroTreeId, null, null, 0, 0, false, true);
    }
}

// Hides / shows div with macro tree
function showHideMacroTree(pnlMacroTreeId, editorElem, autoCompletionObject, leftOffset, topOffset, forceAbove, forceHide) {
    var pnlTree = document.getElementById(pnlMacroTreeId);
    if (pnlTree != null) {
        // Set the visibility
        if ((pnlTree.style.display == 'none') && !forceHide) {
            pnlTree.style.display = 'block';

            // Set the document onclick to hide the the tree help and set the original value
            bodyOnClick = document.onclick;
            setTimeout('document.onclick = new Function("hideMacroTree(\'' + pnlMacroTreeId + '\')");', 500);

        } else {
            pnlTree.style.display = 'none';

            // Set the document onclick event back to original value
            document.onclick = bodyOnClick;
        }

        // Position the div
        if ((editorElem != null) && (autoCompletionObject != null)) {
            autoCompletionObject.forceAbove = forceAbove;
            var pos = autoCompletionObject.getElementPosition(editorElem.getWrapperElement());
            if (rtl) {
                // RTL positioning
                pnlTree.style.left = (pos.x - (Math.abs(editorElem.getWrapperElement().offsetWidth - pnlTree.offsetWidth)) - leftOffset) + 'px';
            } else {
                // Normal LTR positioning
                pnlTree.style.left = (pos.x - leftOffset) + 'px';
            }
            if (forceAbove) {
                pnlTree.style.top = (pos.y - pnlTree.offsetHeight - topOffset - 3) + 'px';
            } else {
                pnlTree.style.top = (pos.y + editorElem.getWrapperElement().offsetHeight - topOffset + 3) + 'px';
            }
        }
    }
}