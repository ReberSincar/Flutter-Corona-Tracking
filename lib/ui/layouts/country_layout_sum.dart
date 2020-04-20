import 'package:corona/models/country.dart';
import 'package:corona/ui/pages/chart_page.dart';
import 'package:corona/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:corona/utils/styles.dart';

class SummaryCountryLayout extends StatelessWidget {
  final Country _country;
  SummaryCountryLayout(this._country);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          child: Card(
            color: transparentColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _country.flag.contains("http")
                    ? Image.network(
                        _country.flag,
                        width: SizeConfig.getFlexibleValue(64),
                        height: SizeConfig.getFlexibleValue(64),
                      )
                    : Image.asset(
                        _country.flag,
                        width: SizeConfig.getFlexibleValue(64),
                        height: SizeConfig.getFlexibleValue(64),
                      ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: SizeConfig.getFlexibleValue(10)),
                  child: Text(
                    _country.name,
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) =>
                    HistoryChart(_country.name, _country.flag),
              ),
            );
          }),
    );
  }
}
