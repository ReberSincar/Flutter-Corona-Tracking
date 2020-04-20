import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'main_page.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Utils utils = Utils.getInstance();
    return SplashScreen(
      seconds: 2,
      backgroundColor: Colors.black,
      image: Image.asset(
        "assets/images/globe.png",
        width: 200,
        height: 200,
      ),
      loaderColor: Colors.white,
      photoSize: 150.0,
      title: Text(utils.getTranslatedText(context, "SplashTitle"),
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w800, fontFamily: "Roboto")),
      navigateAfterSeconds:
          MyHomePage(title: utils.getTranslatedText(context, "AppName")),
      loadingText: Text(
        utils.getTranslatedText(context, "SplashLoadingText"),
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w800, fontFamily: "Roboto"),
      ),
    );
  }
}
