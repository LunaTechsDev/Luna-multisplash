import haxe.display.Display.Package;
import rm.scenes.Scene_Title;
import rm.managers.SceneManager;
import rm.core.TouchInput;
import rm.core.Input;
import Types.SplashType;
import rm.core.Bitmap;
import rm.managers.ImageManager;
import rm.scenes.Scene_MenuBase as RmScene_MenuBase;
import Types.SplashScreen;

using Lambda;

@:expose('SceneMultisplash')
@:native("SceneMultisplash")
class SceneMultisplash extends RmScene_MenuBase {
  public var _screens: Array<SplashScreen>;
  public var _screenImages: Array<Bitmap>;
  public var _currentScreen: SplashScreen;
  public var _currentImage: Bitmap;
  public var _startScreenTimer: Float;
  public var _screenTimer: Float;

  public function new() {
    super();
  }

  public override function initialize() {
    super.initialize();
    Main.Params.splashScreens.reverse();
    this._screens = Main.Params.splashScreens;
    this._screenImages = [];
    this._currentScreen = null;
    this._screenTimer = 0;
    this.preloadSplashImages();
  }

  public function preloadSplashImages() {
    this._screens.iter((screen) -> {
      var bitmap = ImageManager.loadPicture(screen.backgroundImageName);
      _screenImages.push(bitmap);
    });
  }

  public override function createBackground() {
    super.createBackground();
    this._backgroundSprite.filters = [];
    this.setBackgroundOpacity(255);
  }

  public override function update() {
    super.update();
    this.updateTimer();
    this.updateSplashScreens();
  }

  public function updateTimer() {
    if (this._screenTimer > 0) {
      this._screenTimer--;
    }
  }

  public function updateSplashScreens() {
    if (this._currentScreen == null && this._screens.length > 0) {
      this._currentScreen = this._screens.pop();
      this._currentImage = this._screenImages.pop();
      this.setupScreen(this._currentScreen);
    } else if (this._currentScreen != null) {
      // Process Screen Transitions
      trace('Updating Splash', this._screenTimer);
      transitionSplash();
    }

    if (this._fadeDuration == 0 && this._fadeSign == -1) {
      this.startFadeIn(60, false);
      this._backgroundSprite.bitmap = this._currentImage;
    }
  }

  public function transitionSplash() {
    switch (this._currentScreen.splashType) {
      case CLICK:
        if (Input.isTriggered('ok') || TouchInput.isPressed() && this._screens.length > 0) {
          this._currentScreen = this._screens.pop();
          this._currentImage = this._screenImages.pop();
          this.setupScreen(this._currentScreen);
        } else if (Input.isTriggered('ok') || TouchInput.isPressed()) {
          SceneManager.goto(Scene_Title);
        }
      case TIMER:
        if (this._screenTimer == 0 && this._screens.length > 0) {
          this._currentScreen = this._screens.pop();
          this._currentImage = this._screenImages.pop();
          this.setupScreen(this._currentScreen);
        } else if (this._screenTimer == 0) {
          SceneManager.goto(Scene_Title);
        }
    }
  }

  public function setupScreen(screen: SplashScreen) {
    this.startFadeOut(60, false);
    switch (this._currentScreen.splashType) {
      case TIMER:
        this._screenTimer = this._currentScreen.time;

      case CLICK:
        // Do nothing
    }
  }
}
