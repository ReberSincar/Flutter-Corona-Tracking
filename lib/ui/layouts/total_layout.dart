import 'package:corona/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:corona/utils/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LayoutTotal extends StatefulWidget {
  String _dataName;
  int _value;
  Color _color;
  LayoutTotal(this._dataName, this._value, this._color);

  @override
  _LayoutTotalState createState() => _LayoutTotalState();
}

class _LayoutTotalState extends State<LayoutTotal>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController _animationController;
  String i = "0";

  @override
  void initState() {
    animationStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.getFlexibleValue(10),
              vertical: SizeConfig.getFlexibleValue(10)),
          color: transparentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    FontAwesomeIcons.solidSquare,
                    size: SizeConfig.getFlexibleValue(30),
                    color: widget._color,
                  ),
                ],
              ),
              Text(
                widget._dataName,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              Row(
                children: <Widget>[
                  Text(i, style: textStyle),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          )),
    );
    /*Expanded(
      flex: 1,
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.getFlexibleValue(10),
            vertical: SizeConfig.getFlexibleValue(4)),
        color: transparentColor,
        child: ListTile(
          title: Text(
            widget._dataName,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          leading: Icon(
            FontAwesomeIcons.solidSquare,
            size: SizeConfig.getFlexibleValue(30),
            color: widget._color,
          ),
          trailing: Text(i, style: textStyle),
        ),
      ),
    );*/
  }

  animationStart() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 0, end: widget._value.toDouble())
        .animate(_animationController)
          ..addListener(() {
            setState(() {
              i = animation.value.toStringAsFixed(0);
            });
          });
    _animationController.forward();
  }
}
