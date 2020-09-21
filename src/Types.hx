enum abstract LGPEvents(String) from String to String {
  public var PAUSE = 'pause';
}

enum abstract Alignment(String) from String to String {
  public var CENTER = 'center';
  public var LEFT = 'left';
}

enum abstract Animation(String) from String to String {
  public var PERSIST = 'persistent';
  public var FADE = 'fade';
}
