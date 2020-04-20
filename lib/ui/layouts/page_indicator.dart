import 'package:corona/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class PageCircleIndicator extends StatelessWidget {
  final ValueNotifier<int> currentPageNotifier;
  final int itemCount;
  static double dotSize = SizeConfig.getFlexibleValue(12);

  const PageCircleIndicator({Key key, this.currentPageNotifier, this.itemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CirclePageIndicator(
      size: dotSize,
      selectedSize: dotSize,
      dotColor: Colors.white.withOpacity(0.35),
      selectedDotColor: Colors.white,
      currentPageNotifier: currentPageNotifier,
      itemCount: itemCount,
    );
  }
}