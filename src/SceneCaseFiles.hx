import rm.managers.ImageManager;
import rm.core.Sprite;
import rm.core.Rectangle;
import rm.windows.Window_Help;
import rm.managers.SceneManager;
import rm.core.TouchInput;
import rm.core.Input;
import rm.Globals;
import Types.CaseFile;
import rm.core.Graphics;
import rm.scenes.Scene_MenuBase;

using Lambda;

@:native('SceneCaseFiles')
@:keep
class SceneCaseFiles extends Scene_MenuBase {
  public var _caseFileHelpWindow: Window_Help;
  public var _caseFilesListWindow: WindowCaseFilesList;
  public var _caseFileInfoWindow: WindowCaseInfo;
  public var _activeCaseFile: CaseFile;
  public var _caseFileList: Array<CaseFile>;

  public function new() {
    super();
    this._caseFileList = [];
    this.setupCaseFiles();
  }

  public function setupCaseFiles() {
    this._caseFileList = Globals.GameParty.items().filter((item) -> ~/<LNCFile>/ig.match(item.note)).map((item) -> {
      return {
        name: item.name,
        text: item.description,
        image: null
      }
    });
  }

  public override function create() {
    super.create();
    this.createAllWindows();
  }

  public override function createBackground() {
    // super.createBackground();
    this._backgroundSprite = new Sprite();
    this._backgroundSprite.bitmap = ImageManager.loadPicture(Main.Params.backgroundImageName);
    this.addChild(this._backgroundSprite);
    this.setBackgroundOpacity(192);
  }

  public function createAllWindows() {
    this.createCaseFileHelpWindow();
    this.createCaseFileInfoWindow();
    this.createCaseFileListWindow();
  }

  public function createCaseFileHelpWindow() {
    #if compileMV
    this._caseFileHelpWindow = new Window_Help(1);
    #else
    var helpRect = new Rectangle(0, 0, Graphics.boxWidth, 75);
    this._caseFileHelpWindow = new Window_Help(helpRect);
    #end
    this._caseFileHelpWindow.setText('Case Files');
    this.addWindow(this._caseFileHelpWindow);
  }

  public function createCaseFileInfoWindow() {
    var helpWinOffsetY = this._caseFileHelpWindow.height;

    this._caseFileInfoWindow = new WindowCaseInfo(0, helpWinOffsetY, Graphics.boxWidth / 1.5, Graphics.boxHeight
      - helpWinOffsetY);
    this.addWindow(this._caseFileInfoWindow);
  }

  public function createCaseFileListWindow() {
    var helpWinOffsetY = this._caseFileHelpWindow.height;

    var infoWin = this._caseFileInfoWindow;
    this._caseFilesListWindow = new WindowCaseFilesList(infoWin.width, helpWinOffsetY, Graphics.boxWidth
      - infoWin.width, Graphics.boxHeight
      - helpWinOffsetY);
    this._caseFilesListWindow.setCaseFiles(this._caseFileList);
    this._caseFilesListWindow.setHandler('ok', this.caseFileListOkHandler);
    this.addWindow(this._caseFilesListWindow);
    this._caseFilesListWindow.select(0);
    this._caseFilesListWindow.activate();
    this._caseFilesListWindow.refresh();
  }

  public override function update() {
    super.update();
    this.processSceneTransition();
  }

  public function processSceneTransition() {
    if (!this._caseFilesListWindow.active) {
      if (Input.isTriggered('cancel') || TouchInput.isCancelled()) {
        SceneManager.pop();
      }
    }
  }

  public function caseFileListOkHandler() {
    this._activeCaseFile = this._caseFilesListWindow._caseFiles[this._caseFilesListWindow.index()];
    if (this._activeCaseFile != null) {
      this.showActiveCaseFile();
    }
  }

  public function showActiveCaseFile() {
    // Show if case file collected
    this._caseFileInfoWindow.showCaseFileText(this._activeCaseFile.text);
  }
}
