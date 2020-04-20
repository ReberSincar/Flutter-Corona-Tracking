import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/styles.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils.getInstance();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Image.asset(
              "assets/icons/icon.png",
              width: SizeConfig.getFlexibleValue(35),
              height: SizeConfig.getFlexibleValue(35),
            ),
            SizedBox(
              width: SizeConfig.getFlexibleValue(20),
            ),
            Text(
              utils.getTranslatedText(context, 'AppName'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.getFlexibleValue(18),
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Container(
          child: Card(
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    utils.getTranslatedText(context, 'NetConnection'),
                    style: captionTextStyle,
                  ),
                  Image.asset(
                    "assets/images/net.png",
                    color: Colors.white,
                    width: SizeConfig.getFlexibleValue(150),
                    height: SizeConfig.getFlexibleValue(150),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
