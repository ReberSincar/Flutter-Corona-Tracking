import 'package:flutter/widgets.dart';

class SizeConfig {
  MediaQueryData _mediaQueryData;
  double _screenWidth;
  double _screenHeight;

  static SizeConfig _sizeConfig;

  SizeConfig._(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    _screenHeight = _mediaQueryData.size.height;
    _screenWidth = _mediaQueryData.size.width;
  }

  static SizeConfig getInstance(BuildContext context){
    if(_sizeConfig == null){
      _sizeConfig = SizeConfig._(context);
    }
    return _sizeConfig;
  }

  static double getWidth(){
    return _sizeConfig._screenWidth;
  }

  static double getHeight(){
    return _sizeConfig._screenHeight;
  }

  static double getFlexibleValue(double value){
    return (_sizeConfig._screenHeight * value) / 960;
  }
}
