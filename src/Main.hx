import macros.FnMacros;
import rm.core.JsonEx;
import Types;
import rm.managers.SceneManager;
import pixi.interaction.EventEmitter;
import core.Amaryllis;
import rm.Globals;
import rm.scenes.Scene_Boot as RmScene_Boot;

using Lambda;
using core.StringExtensions;
using core.NumberExtensions;
using StringTools;
using utils.Fn;

@:native('LunaMultisplash')
@:expose('LunaMultisplash')
class Main {
  public static var Params: LParams = null;
  public static var listener: EventEmitter = Amaryllis.createEventEmitter();

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) -> ~/<LunaMSplash>/ig.match(plugin.description))[0];
    var screens: Array<SplashScreen> = [];
    var params = plugin.parameters;
    untyped screens = JsonEx.parse(params['splashScreens']).map((screen) -> {
      var data = JsonEx.parse(screen);
      trace(data);
      return {
        backgroundImageName: data.image,
        splashType: data.splashType.trim(),
        time: data.timer
      }
    });
    Params = {
      splashScreens: screens
    }
    trace(Params);
    FnMacros.jsPatch(true, RmScene_Boot, SceneBoot);
  }

  public static function params() {
    return Params;
  }
}
