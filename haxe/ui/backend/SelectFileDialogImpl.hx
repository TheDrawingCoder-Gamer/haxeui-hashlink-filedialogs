package haxe.ui.backend;

#if hl
import haxe.io.Path;
import haxe.ui.backend.SelectFileDialogBase;

class SelectFileDialogImpl extends SelectFileDialogBase {
    public override function show() {
        validateOptions();
        var file = hl.UI.loadFile({title: "Select File", });
        if (file != null) {
            var infos:Array<SelectedFileInfo> = [];
            infos.push({
                name: Path.withoutDirectory(file),
                fullPath: file,
                isBinary: false
            });
            
            if (options.readContents == true) {
                for (info in infos) {
                    if (options.readAsBinary) {
                        info.isBinary = true;
                        info.bytes = File.getBytes(info.fullPath);
                    } else {
                        info.isBinary = false;
                        info.text = File.getContent(info.fullPath);
                    }
                }
            }
            
            if (callback != null) {
                callback(DialogButton.OK, infos);
            }
        } else {
            if (callback != null) {
                callback(DialogButton.CANCEL, null);
            }
        }
    }
}
#end