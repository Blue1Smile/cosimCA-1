/**
 * 开发版本的文件导入
 */
;(function (){
    var paths  = [            
            'editor.js',
            'core/browser.js',
            'core/utils.js',
            'core/EventBase.js',
            'core/dom/dtd.js',
            'core/dom/domUtils.js',
            'core/dom/Range.js',
            'core/dom/Selection.js',
            'core/Editor.js',
            'core/ajax.js',
            'plugins/flowchart.js',
            'plugins/input.js',
            'plugins/importform.js',
            'plugins/taskopinion.js',
            'plugins/customdialog.js',
            'plugins/choosetemplate.js',
            'plugins/inserthtml.js',            
            'plugins/autosubmit.js',
            'plugins/image.js',
            'plugins/justify.js',
            'plugins/font.js',
            'plugins/opinion.js',
            'plugins/mathfunction.js',
            'plugins/link.js',           
            'plugins/iframe.js',
            'plugins/removeformat.js',
            'plugins/blockquote.js',
            'plugins/indent.js',
            'plugins/print.js',
            'plugins/spechars.js',            
            'plugins/selectall.js',
            'plugins/paragraph.js',
            'plugins/directionality.js',
            'plugins/horizontal.js',
            'plugins/time.js',
            'plugins/rowspacing.js',
            'plugins/lineheight.js',
            'plugins/cleardoc.js',
            'plugins/anchor.js',
            'plugins/delete.js',
            'plugins/wordcount.js',
            'plugins/pagebreak.js',           
            'plugins/undo.js',
            'plugins/paste.js',           //粘贴时候的提示依赖了UI
            'plugins/list.js',
            'plugins/source.js',
            'plugins/shortcutkeys.js',
            'plugins/enterkey.js',
            'plugins/keystrokes.js',
            'plugins/fiximgclick.js',
            'plugins/autolink.js',
            'plugins/autoheight.js',
            'plugins/autofloat.js',  //依赖UEditor UI,在IE6中，会覆盖掉body的背景图属性
            'plugins/highlight.js',
            'plugins/serialize.js',            
            'plugins/table.js',
            'plugins/contextmenu.js',
            'plugins/basestyle.js',
            'plugins/elementpath.js',
            'plugins/formatmatch.js',
            'plugins/searchreplace.js',
            'plugins/customstyle.js',
            'plugins/catchremoteimage.js',            
            'plugins/attachment.js',
            'ui/ui.js',
            'ui/uiutils.js',
            'ui/uibase.js',
            'ui/separator.js',
            'ui/mask.js',
            'ui/popup.js',
            'ui/colorpicker.js',
            'ui/tablepicker.js',
            'ui/stateful.js',
            'ui/button.js',
            'ui/splitbutton.js',
            'ui/colorbutton.js',
            'ui/tablebutton.js',
            'ui/autotypesetpicker.js',
            'ui/autotypesetbutton.js',
            'ui/toolbar.js',
            'ui/menu.js',
            'ui/combox.js',
            'ui/dialog.js',
            'ui/menubutton.js',
            'ui/editorui.js',
            'ui/editor.js',
            'ui/multiMenu.js'
        ],
        baseURL = __ctx+'/js/ueditor/_src/';
    for (var i=0,pi;pi = paths[i++];) {
        document.write('<script type="text/javascript" src="'+ baseURL + pi +'"></script>');
    }
})();
