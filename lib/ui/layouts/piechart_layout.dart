import 'package:charts_flutter/flutter.dart' as charts;
import 'package:corona/models/allcases.dart';
import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/styles.dart';
import 'package:flutter/material.dart';

class PieChartLayout extends StatelessWidget {
  List<charts.Series> seriesList;
  AllCases allData;

  PieChartLayout(AllCases allData) {
    this.allData = allData;
    seriesList = _createSampleData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: transparentColor,
      child: Container(
        padding: EdgeInsets.all(20),
        child: charts.PieChart(
          seriesList,
          animate: true,
          animationDuration: Duration(seconds: 1),
          defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: SizeConfig.getFlexibleValue(50).toInt(),
              arcRendererDecorators: [
                new charts.ArcLabelDecorator(
                    insideLabelStyleSpec: charts.TextStyleSpec(
                      fontSize: SizeConfig.getFlexibleValue(13).toInt(),
                      color: charts.MaterialPalette.white,
                    ),
                    outsideLabelStyleSpec: charts.TextStyleSpec(
                      fontSize: SizeConfig.getFlexibleValue(15).toInt(),
                      color: charts.MaterialPalette.white,
                    ))
              ]),
        ),
      ),
    );
  }

  List<charts.Series<AllData, int>> _createSampleData() {
    final data = [
      new AllData(
          allData.deaths / allData.cases * 100, allData.deaths, Colors.red),
      new AllData(
          (allData.cases - allData.deaths - allData.recovered) /
              allData.cases *
              100,
          allData.cases - allData.deaths - allData.recovered,
          Colors.yellow),
      new AllData(allData.recovered / allData.cases * 100, allData.recovered,
          Colors.green),
    ];

    return [
      new charts.Series<AllData, int>(
          id: 'Sales',
          domainFn: (AllData data, _) => data.value,
          measureFn: (AllData data, _) => data.percent.toInt(),
          data: data,
          labelAccessorFn: (AllData row, _) =>
              '%${row.percent.toStringAsFixed(2)}',
          colorFn: (AllData data, _) {
            if (data.color == Colors.red) {
              return charts.MaterialPalette.red.shadeDefault;
            } else if (data.color == Colors.yellow) {
              return charts.Color.fromHex(code: "#FFBF00FF");
            }
            return charts.MaterialPalette.green.shadeDefault;
          })
    ];
  }
}

class AllData {
  final double percent;
  final int value;
  final Color color;

  AllData(this.percent, this.value, this.color);
}
