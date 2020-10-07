import rm.managers.SceneManager;
import pixi.interaction.EventEmitter;
import core.Amaryllis;
import rm.Globals;

using Lambda;
using core.StringExtensions;
using core.NumberExtensions;
using StringTools;
using utils.Fn;

typedef LParams = {}

@:native('LunaCaseFiles')
@:expose('LunaCaseFiles')
class Main {
  public static var Params: LParams = null;
  public static var listener: EventEmitter = Amaryllis.createEventEmitter();

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) -> ~/<LunaCaseFiles>/ig.match(plugin.description))[0];
  }

  public static function params() {
    return Params;
  }

  public static function gotoCaseFileScene() {
    SceneManager.push(SceneCaseFiles);
  }
}
