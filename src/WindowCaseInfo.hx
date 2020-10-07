import rm.windows.Window_Base;
import rm.core.Rectangle;

@:native('WindowCaseInfo')
@:keep
class WindowCaseInfo extends Window_Base {
  public var _caseText: String;

  public function new(x: Float, y: Float, width: Float, height: Float) {
    #if compileMV
    super(x, y, width, height);
    #else
    var rect = new Rectangle(x, y, width, height);
    super(rect);
    #end
  }

  public function showCaseFileText(text: String) {
    this._caseText = text;
    this.refresh();
  }

  public function clearCaseFileText() {
    this._caseText = '';
    this.refresh();
  }

  public function refresh() {
    if (this.contents != null) {
      this.contents.clear();
      this.paintText();
    }
  }

  public function paintText() {
    #if compileMV
    this.drawTextEx(this._caseText, 0, 0);
    #else
    this.drawTextEx(this._caseText, 0, 0, this.contentsWidth());
    #end
  }
}
