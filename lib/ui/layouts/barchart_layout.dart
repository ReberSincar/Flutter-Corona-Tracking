import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartLayout extends StatelessWidget {
  final String countryName;
  final String countryFlag;
  final String captionText;
  final List<charts.Series> seriesList;
  BarChartLayout(
      this.countryName, this.countryFlag, this.captionText, this.seriesList);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Card(
        color: transparentColor,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                captionText,
                style: captionTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  countryFlag.contains("http")
                      ? Image.network(countryFlag)
                      : Image.asset(countryFlag),
                  SizedBox(
                    width: SizeConfig.getFlexibleValue(10),
                  ),
                  Text(
                    countryName,
                    style: captionTextStyle,
                  ),
                ],
              ),
              Expanded(
                child: seriesList != null
                    ? charts.BarChart(
                        seriesList,
                        barRendererDecorator: new charts.BarLabelDecorator(
                          insideLabelStyleSpec: new charts.TextStyleSpec(
                              color: charts.Color.white),
                          outsideLabelStyleSpec: new charts.TextStyleSpec(
                            color: charts.Color.white,
                          ),
                        ),
                        defaultInteractions: true,
                        domainAxis: new charts.OrdinalAxisSpec(
                          renderSpec: new charts.SmallTickRendererSpec(
                            labelStyle: new charts.TextStyleSpec(
                              fontSize: SizeConfig.getFlexibleValue(15).toInt(),
                              color: charts.MaterialPalette.white,
                            ),
                            lineStyle: new charts.LineStyleSpec(
                              color: charts.MaterialPalette.white,
                            ),
                          ),
                        ),
                        primaryMeasureAxis: new charts.NumericAxisSpec(
                          renderSpec: new charts.GridlineRendererSpec(
                            labelStyle: new charts.TextStyleSpec(
                              fontSize: SizeConfig.getFlexibleValue(15).toInt(),
                              color: charts.MaterialPalette.white,
                            ),
                            lineStyle: new charts.LineStyleSpec(
                              color: charts.MaterialPalette.white,
                            ),
                          ),
                        ),
                        vertical: false,
                        animate: true,
                        animationDuration: Duration(seconds: 1),
                      )
                    : Center(
                        child: Container(
                          width: SizeConfig.getFlexibleValue(100),
                          height: SizeConfig.getFlexibleValue(100),
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
