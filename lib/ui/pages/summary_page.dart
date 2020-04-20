import 'package:corona/services/services.dart';
import 'package:corona/ui/layouts/page_indicator.dart';
import 'package:corona/ui/layouts/piechart_layout.dart';
import 'package:corona/ui/layouts/total_layout.dart';
import 'package:corona/ui/pages/summary_country.dart';
import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/styles.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:corona/models/allcases.dart';

class SummaryPage extends StatefulWidget {
  SummaryPage({Key key}) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  AllCases allData;
  int bannerNum;
  Utils utils;
  Services services;
  final ValueNotifier currentPageNotifier = ValueNotifier<int>(0);
  @override
  void initState() {
    utils = Utils.getInstance();
    services = Services.getInstance();
    services.fetchAllCases().then((result) {
      setState(() {
        allData = result;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.getFlexibleValue(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.transparent,
              child: Text(
                utils
                    .getTranslatedText(context, "AppBarSummaryPage")
                    .toString()
                    .toUpperCase(),
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Card(
                color: Colors.transparent,
                child: allData != null
                    ? Padding(
                        padding: EdgeInsets.all(SizeConfig.getFlexibleValue(5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            LayoutTotal(
                                utils.getTranslatedText(
                                    context, 'SummaryCases'),
                                allData.cases,
                                Colors.red.shade300),
                            LayoutTotal(
                                utils.getTranslatedText(
                                    context, 'SummaryDeaths'),
                                allData.deaths,
                                Colors.red),
                            LayoutTotal(
                                utils.getTranslatedText(
                                    context, 'SummaryActive'),
                                (allData.cases -
                                    allData.deaths -
                                    allData.recovered),
                                Colors.amber),
                            LayoutTotal(
                                utils.getTranslatedText(
                                    context, 'SummaryRecovered'),
                                allData.recovered,
                                Colors.green),
                          ],
                        ),
                      )
                    : Center(
                        child: Container(
                          width: SizeConfig.getFlexibleValue(100),
                          height: SizeConfig.getFlexibleValue(100),
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: Card(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(
                          SizeConfig.getFlexibleValue(10),
                        ),
                        child: PageView(
                          controller: PageController(
                            initialPage: currentPageNotifier.value,
                          ),
                          onPageChanged: (index) {
                            currentPageNotifier.value = index;
                          },
                          children: <Widget>[
                            allData != null
                                ? PieChartLayout(allData)
                                : Center(
                                    child: Container(
                                      width: SizeConfig.getFlexibleValue(100),
                                      height: SizeConfig.getFlexibleValue(100),
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                            SummaryCountry()
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: SizeConfig.getFlexibleValue(20),
                        right: 0,
                        left: 0,
                        child: PageCircleIndicator(
                          itemCount: 2,
                          currentPageNotifier: currentPageNotifier,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
