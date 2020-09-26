import macros.FnMacros;
import rm.scenes.Scene_Map;
import js.Syntax;
import rm.windows.Window_Base;
import rm.managers.DataManager;
import rm.core.Rectangle;
import rm.windows.Window_MapName;
import rm.objects.Game_Interpreter;
import pixi.interaction.EventEmitter;
import core.Amaryllis;
import utils.Comment;
import core.Types.JsFn;
import utils.Fn;
import rm.Globals;

using Lambda;
using core.StringExtensions;
using core.NumberExtensions;
using StringTools;
using utils.Fn;

typedef LCParams = {}

@:native('LunaCallEvent')
@:expose('LunaCallEvent')
class Main {
  public static var Params: LCParams = null;
  public static var listener: EventEmitter = Amaryllis.createEventEmitter();

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) -> ~/<LunaCallEvent>/ig.match(plugin.description))[0];
    var params = plugin.parameters;
    Params ={}

    trace(Params);

    Comment.title('Scene_Map');

    Comment.title('Game_Interpreter');
  }

  public static function params() {
    return Params;
  }
}
