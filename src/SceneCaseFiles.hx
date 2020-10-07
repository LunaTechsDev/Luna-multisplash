import rm.scenes.Scene_MenuBase;

class SceneCaseFiles extends Scene_MenuBase {
  public function new() {
    super();
  }

  public override function create() {
    super.create();
    this.createAllWindows();
  }

  public function createAllWindows() {}

  public function showActiveCaseFile() {
    // Show if case file collected
  }
}
