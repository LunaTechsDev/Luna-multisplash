enum abstract SplashType(String) from String to String {
  public var CLICK = 'click';
  public var TIMER = 'timer';
}

typedef SplashScreen = {
  var backgroundImageName: String;
  var splashType: SplashType;
  var ?time: Float;
}

typedef LParams = {
  var splashScreens: Array<SplashScreen>;
}
