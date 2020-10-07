import rm.managers.ImageManager;
import rm.scenes.Scene_Title;

using Lambda;

class TitlePatch extends Scene_Title {
  public var linkWindows: Array<LinkWindow>;

  public override function create() {
    untyped _Scene_Title_create.call(this);
    // this.createAllLinkWindows();
  }

  // public function createAllLinkWindows() {
  //   this.linkWindows = [];
  //   Main.params().linkWindows.iter((info) -> {
  //     var linkWindow = new LinkWindow(info.x, info.y, info.width, info.height);
  //     trace(info);
  //     linkWindow.setLink(info.link);
  //     var bitmap = ImageManager.loadPicture(info.image, 0);
  //     linkWindow.setImage(bitmap);
  //     this.addWindow(linkWindow);
  //     linkWindow.setBackgroundType(info.backgroundType);
  //     linkWindow.open();
  //     trace(linkWindow);
  //     this.linkWindows.push(linkWindow);
  //   });
  // }
}
