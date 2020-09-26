import rm.core.TouchInput;
import js.Browser;
import macros.FnMacros;
import rm.core.Rectangle;
import rm.windows.Window_Base;
import rm.core.Bitmap;

using WindowExtensions;

@:native('LinkWindow')
class LinkWindow extends Window_Base {
  private var _image: Bitmap;
  private var _link: String;

  public function new(x: Int, y: Int, width: Int, height: Int) {
    #if compileMV
    super(x, y, width, height);
    #else
    var rect = new Rectangle(x, y, width, height);
    super(rect);
    #end
  }

  public function setLink(link: String) {
    this._link = link;
  }

  public function setImage(image: Bitmap) {
    this._image = image;
    this._image.addLoadListener((bitmap) -> {
      this.refresh();
    });
  }

  public override function update() {
    super.update();
    this.processLinkClick();
  }

  public function processLinkClick() {
    if (TouchInput.isTriggered() && this.isTouchInsideFrame() && this.isOpenOrVisible()) {
      Browser.window.open(this._link, '_blank');
    }
  }

  public function refresh() {
    if (this.contents != null) {
      this.contents.clear();
      this.paintImage();
    }
  }

  public function paintImage() {
    var img = this._image;
    var dm = FnMacros.destruct({
      width: Int,
      height: Int
    }, img);

    this.contents.blt(
      this._image,
      0,
      0,
      dm.width,
      dm.height,
      0,
      0,
      this.contentsWidth(),
      this.contentsHeight()
    );
  }
}
