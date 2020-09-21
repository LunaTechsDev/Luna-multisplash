import js.Syntax;
import rm.windows.Window_Base;
import rm.managers.DataManager;
import rm.core.Rectangle;
import rm.windows.Window_MapName;
import Types.Animation;
import Types.Alignment;
import pixi.interaction.EventEmitter;
import core.Amaryllis;
import utils.Comment;
import core.Types.JsFn;
import utils.Fn;
import rm.Globals;
import SelfMacro.self as sf;

using Lambda;
using core.StringExtensions;
using core.NumberExtensions;
using StringTools;
using utils.Fn;

typedef LMParams = {
  var x: Int;
  var y: Int;
  var alignment: String;
  var animation: String;
  var marquee: Bool;
  var marqueeSpeed: Int;
  var persistent: Bool;
}

@:native('LunaMapNamePlus')
@:expose('LunaMapNamePlus')
class Main {
  public static var LMParams: LMParams = null;
  public static var listener: EventEmitter = Amaryllis.createEventEmitter();

  public static function main() {
    var plugin = Globals.Plugins.filter((plugin) -> ~/<LunaMapNamePlus>/ig.match(plugin.description))[0];
    var params = plugin.parameters;
    LMParams = {
      x: Fn.parseIntJs(params['x']),
      y: Fn.parseIntJs(params['y']),
      alignment: params['alignment'],
      animation: params['animation'],
      marquee: params['marquee'].toUpperCase() == 'T',
      marqueeSpeed: Fn.parseIntJs(params['marqueeSpeed']),
      persistent: params['persistent'].toUpperCase() == 'T'
    }

    trace(LMParams);

    Comment.title('Scene_Map');

    Comment.title('Window_MapName');
    var _WindowmapName_intitialize: JsFn = Window_MapName.proto().initializeR;
    var WinMapName: String = 'Window_MapName';

    #if compileMV
    Window_MapName.proto().initializeD = (?x: Int, ?y: Int, ?width: Int, ?height: Int) -> {
      sf(Window_MapName, {
        _WindowmapName_intitialize.call(self, x, y, width, height);
        initializeWindow(self);
      });
    }
    #else
    Window_MapName.proto().initializeD = (rect: Rectangle) -> {
      sf(Window_MapName, {
        _WindowmapName_intitialize.call(self, rect);
        initializeWindow(self);
      });
    }
    #end

    Window_MapName.proto().updateD = () -> {
      untyped Window_Base.proto().updateR.call(Fn.self);
      updateWindow(Fn.self);
    };

    Window_MapName.proto().refreshD = () -> {
      sf(Window_MapName, refreshWindow(self));
    };
    Window_MapName.proto().updateFadeOutD = () -> {
      // Window_MapName.self(updateWindowFadeOut(self));
      SelfMacro.self(Window_MapName, updateWindowFadeOut(self));
    };

    Window_MapName.setPrPropFn('updateMarquee', () -> {
      sf(Window_MapName, {
        self.contents.clear();

        var stopPoint = self.textWidth(Globals.GameMap.displayName()) * -1;
        untyped {
          if (self._marqueePos > stopPoint) {
            self._marqueePos -= self._marqueeSlide;
          } else {
            self._marqueePos = self.contentsWidth() - self.textWidth(Globals.GameMap.displayName()[0]);
            self._marqueeComplete = true;
          }
          #if compileMV
          self.drawTextEx(Globals.GameMap.displayName(), self._marqueePos, 0);
          #else
          self.drawTextEx(Globals.GameMap.displayName(), self._marqueePos, 0, self.contentsWidth());
          #end
          self.drawBackground(0, 0, self.contentsWidth(), self.lineHeight());
        }
      });
    });
  }

  public static function params() {
    return LMParams;
  }

  public static inline function initializeWindow(win: Window_MapName) {
    untyped {
      win._marqueeSlide = LMParams.marqueeSpeed;
      win._marqueePos = self.contentsWidth() - self.textWidth(Globals.GameMap.displayName()[0]);
      win._marqueeComplete = false;
      win.move(LMParams.x, LMParams.y, win.width, win.height);
    }
  }

  public static inline function updateWindow(win: Window_MapName) {
    untyped {
      if (win._showCount > 0 && Globals.GameMap.isNameDisplayEnabled()) {
        win.updateFadeIn();
        win.__showCount--;
      } else {
        if (LMParams.marquee && Globals.GameMap.displayName()) {
          win.updateMarquee();
        }
        win.updateFadeOut();
      }
    }
  }

  public static inline function updateWindowFadeOut(win: Window_MapName) {
    untyped {
      if (LMParams.animation.toLowerCase().contains(Animation.PERSIST)) {
        if (LMParams.marquee && win._marqueeComplete) {
          Window_MapName.proto().updateFadeOut.call(win);
        }
      }
    }
  }

  public static inline function refreshWindow(win: Window_MapName) {
    win.contents.clear();
    if (Globals.GameMap.displayName() != null) {
      var width = win.contentsWidth();
      win.drawBackground(0, 0, width, win.lineHeight());
      var center: Int = cast width / 2 - win.textWidth(Globals.GameMap.displayName()) / 2;

      var xPos = LMParams.alignment.toLowerCase().contains(Alignment.CENTER) ? center : 0;
      if (LMParams.marquee) {
        #if compileMV
        win.drawTextEx(Globals.GameMap.displayName(), xPos, 0);
        #else
        win.drawTextEx(Globals.GameMap.displayName(), xPos, 0, width);
        #end
      }
    }
  }
}
