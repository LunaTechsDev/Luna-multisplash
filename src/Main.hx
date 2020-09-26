import rm.core.JsonEx;
import macros.FnMacros;
import rm.scenes.Scene_Title;
import js.Syntax;
import pixi.interaction.EventEmitter;
import core.Amaryllis;
import utils.Comment;
import utils.Fn;
import rm.Globals;

using Lambda;
using core.StringExtensions;
using core.NumberExtensions;
using StringTools;
using utils.Fn;

typedef LinkWindowInfo = {
  var x: Int;
  var y: Int;
  var width: Int;
  var height: Int;
  var backgroundType: Int;
  var link: String;
  var image: String;
}

typedef LParams = {
  var linkWindows: Array<LinkWindowInfo>;
}

@:native('LunaLinks')
@:expose('LunaLinks')
class Main {
  public static var Params: LParams = null;
  public static var listener: EventEmitter = Amaryllis.createEventEmitter();

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) -> ~/<LunaLinks>/ig.match(plugin.description))[0];
    var params = plugin.parameters;
    untyped Params = {
      linkWindows: JsonEx.parse(params['linkWindows']).map((win) -> JsonEx.parse(win))
    }
    trace(Params);

    Comment.title('Scene_Title');
    FnMacros.jsPatch(true, Scene_Title, TitlePatch);
  }

  public static function params() {
    return Params;
  }
}
