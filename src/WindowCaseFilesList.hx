import Types.CaseFile;
import rm.core.Rectangle;
import rm.windows.Window_Selectable;

/**
 * Draw Item only function we need to focus on
 * since Window_Selectable redraws automatically.
 */
@:native('WindowCaseFilesList')
@:keep
class WindowCaseFilesList extends Window_Selectable {
  public var _caseFiles: Array<CaseFile>;

  public function new(x: Float, y: Float, width: Float, height: Float) {
    #if compileMV
    super(x, y, width, height);
    #else
    var rect = new Rectangle(x, y, width, height);
    super(rect);
    #end
    this._caseFiles = [];
  }

  public override function maxItems(): Int {
    return this._caseFiles.length;
  }

  public override function processOk() {
    if (this.isCurrentItemEnabled()) {
      this.playOkSound();
      this.updateInputData();
      // this.deactivate();
      this.callOkHandler();
    } else {
      this.playBuzzerSound();
    }
  }

  public function setCaseFiles(files: Array<CaseFile>) {
    this._caseFiles = files;
    this.refresh();
  }

  public override function drawItem(index: Int) {
    #if compileMV
    var rect = this.itemRectForText(index);
    #else
    var rect = this.itemRect(index);
    #end
    var caseFile = this._caseFiles[index];
    #if compileMV
    this.drawTextEx(caseFile.name, rect.x, rect.y);
    #else
    this.drawTextEx(caseFile.name, rect.x, rect.y, rect.width);
    #end
  }
}
