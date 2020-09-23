import rm.types.RPG.EventCommand;
import rm.objects.Game_Interpreter;

class GameInter extends Game_Interpreter {
  public function callEvent(list: Array<EventCommand>, mapId: Int, eventId: Int) {
    this.clear();
    this._mapId = mapId;
    this._eventId = eventId;
    this._list = list;
    #if compileMV
    #else
    untyped this.loadImages(); // Might be MZ only
    #end
  }
}
