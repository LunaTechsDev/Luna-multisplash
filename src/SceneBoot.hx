import rm.managers.SceneManager;
import rm.managers.DataManager;
import rm.scenes.Scene_Battle;
import rm.scenes.Scene_Map;
import rm.windows.Window_TitleCommand;
import rm.managers.DataManager;
import rm.managers.SoundManager;
import rm.scenes.Scene_Boot as RmScene_Boot;

class SceneBoot extends RmScene_Boot {
  #if compileMV
  public override function start() {
    // super.start();
    untyped Scene_Base.prototype.start.call(this);
    SoundManager.preloadImportantSounds();
    if (DataManager.isBattleTest()) {
      DataManager.setupBattleTest();
      SceneManager.goto(Scene_Battle);
    } else if (DataManager.isEventTest()) {
      DataManager.setupEventTest();
      SceneManager.goto(Scene_Map);
    } else {
      this.checkPlayerLocation();
      DataManager.setupNewGame();
      SceneManager.goto(SceneMultisplash);
      untyped Window_TitleCommand.initCommandPosition();
    }
    this.updateDocumentTitle();
  }
  #else
  public override function startNormalGame() {
    // super.startNormalGame();
    this.checkPlayerLocation();
    DataManager.setupNewGame();
    SceneManager.goto(SceneMultisplash);
    untyped Window_TitleCommand.initCommandPosition();
  }
  #end
}
