import haxe.macro.TypeTools;
import haxe.macro.ExprTools;
import haxe.macro.ComplexTypeTools;
import haxe.macro.Expr.Function;
import sys.io.File;
import haxe.macro.Expr.Field;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Compiler;

class SelfMacro {
  public static inline macro function self(typeName: Expr, exprs: Array<Expr>): Expr {
    var finalType = '';
    // var selfType = Context.typeof(typeName);
    // trace(Context.follow(selfType, true));
    // }
    // Breakdown Expression Based On Type
    switch (typeName.expr) {
      case EConst(const):
        switch (const) {
          case CIdent(identifier):
            finalType = identifier;
          // trace("New Expr ==========", expr2);
          // finalType = ExprTools.getValue(expr2);
          case CString(str, _):
            finalType = str;
          case _:
            // Do nothing
        }
      case _:
        // Do nothing
    }

    trace(typeName);
    trace(finalType);
    exprs.unshift(Context.parseInlineString('var self:${finalType} = Fn.self', Context.currentPos()));
    return macro $b{exprs};
  }
}
