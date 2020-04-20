import 'package:charts_flutter/flutter.dart' as charts;
import 'package:corona/models/allcases.dart';
import 'package:corona/models/country.dart';
import 'package:corona/models/history.dart';
import 'package:corona/services/services.dart';
import 'package:corona/ui/layouts/barchart_layout.dart';
import 'package:corona/ui/layouts/piechart_layout.dart';
import 'package:corona/utils/db.dart';
import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/styles.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:corona/models/country_history_day.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistoryChart extends StatefulWidget {
  final String _countryName;
  final String _countryFlag;
  HistoryChart(this._countryName, this._countryFlag);

  @override
  _HistoryChartState createState() => _HistoryChartState();
}

class _HistoryChartState extends State<HistoryChart> {
  List<charts.Series> seriesCasesList;
  List<charts.Series> seriesDeathsList;
  List<charts.Series> seriesRecoveredList;
  Country country;
  History history;
  Utils utils;
  DB db;
  Services services;
  List<String> countryNames;

  @override
  void initState() {
    services = Services.getInstance();
    utils = Utils.getInstance();
    db = DB.getInstance();
    services.fetchCountryData(widget._countryName).then((result) {
      setState(() {
        country = result;
      });
    });

    services.fetchCountryHistory(widget._countryName).then((result) {
      setState(() {
        history = result;
        seriesCasesList = _createCasesData();
        seriesDeathsList = _createDeathsData();
        seriesRecoveredList = _createRecoveredData();
      });
    });

    countryNames = new List<String>();
    countryNames = db.getCountryNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            utils.getTranslatedText(context, "AppName"),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: SizeConfig.getFlexibleValue(10),
          bottom: TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.getFlexibleValue(20)),
            tabs: [
              Tab(
                text: utils.getTranslatedText(context, "DetailsCaption"),
              ),
              Tab(
                text: utils.getTranslatedText(context, "SummaryCases"),
              ),
              Tab(
                text: utils.getTranslatedText(context, "SummaryDeaths"),
              ),
              Tab(
                text: utils.getTranslatedText(context, "SummaryRecovered"),
              ),
            ],
          ),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover),
          ),
          child: TabBarView(children: [
            country != null
                ? Container(
                    margin: EdgeInsets.all(SizeConfig.getFlexibleValue(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Card(
                            color: transparentColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Hero(
                                      tag: country.name,
                                      child: country.flag.contains("http")
                                          ? Image.network(
                                              country.flag,
                                              width:
                                                  SizeConfig.getFlexibleValue(
                                                      64),
                                              height:
                                                  SizeConfig.getFlexibleValue(
                                                      64),
                                            )
                                          : Image.asset(
                                              country.flag,
                                              width:
                                                  SizeConfig.getFlexibleValue(
                                                      64),
                                              height:
                                                  SizeConfig.getFlexibleValue(
                                                      64),
                                            ),
                                    ),
                                    SizedBox(
                                        width: SizeConfig.getFlexibleValue(20)),
                                    Text(
                                      country.name,
                                      style: textStyle,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          utils.getTranslatedText(
                                              context, "DetailsCases"),
                                          style: textStyle,
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "DetailsDeaths"),
                                          style: textStyle,
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "DetailsRecovered"),
                                          style: textStyle,
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "DetailsActive"),
                                          style: textStyle,
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "DetailsCritical"),
                                          style: textStyle,
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "DetailsTests"),
                                          style: textStyle,
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "DetailsTodayCases"),
                                          style: textStyle,
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "DetailsTodayDeaths"),
                                          style: textStyle,
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "DetailsTestsMillion"),
                                          style: textStyle,
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "DetailsCasesMillion"),
                                          style: textStyle,
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "DetailsDeathsMillion"),
                                          style: textStyle,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          country.cases.toString(),
                                          style: textStyle,
                                        ),
                                        Text(
                                          country.deaths.toString(),
                                          style: textStyle,
                                        ),
                                        Text(
                                          country.recovered.toString(),
                                          style: textStyle,
                                        ),
                                        Text(
                                          country.active.toString(),
                                          style: textStyle,
                                        ),
                                        Text(
                                          country.critical.toString(),
                                          style: textStyle,
                                        ),
                                        Text(
                                          country.totalTests.toString(),
                                          style: textStyle,
                                        ),
                                        Text(
                                          country.todayCases.toString(),
                                          style: textStyle,
                                        ),
                                        Text(
                                          country.todayDeaths.toString(),
                                          style: textStyle,
                                        ),
                                        Text(
                                          country.testsPerOneMillion.toString(),
                                          style: textStyle,
                                        ),
                                        Text(
                                          country.casesPerOneMillion.toString(),
                                          style: textStyle,
                                        ),
                                        Text(
                                          country.deathsPerOneMillion
                                              .toString(),
                                          style: textStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.solidSquare,
                                          size: SizeConfig.getFlexibleValue(20),
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.getFlexibleValue(10),
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "SummaryDeaths"),
                                          style: textStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.solidSquare,
                                          size: SizeConfig.getFlexibleValue(20),
                                          color: Colors.amber,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.getFlexibleValue(10),
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "SummaryActive"),
                                          style: textStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.solidSquare,
                                          size: SizeConfig.getFlexibleValue(20),
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeConfig.getFlexibleValue(10),
                                        ),
                                        Text(
                                          utils.getTranslatedText(
                                              context, "SummaryRecovered"),
                                          style: textStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: PieChartLayout(
                            AllCases(
                                cases: country.cases,
                                deaths: country.deaths,
                                recovered: country.recovered),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.getFlexibleValue(5),
                                right: SizeConfig.getFlexibleValue(5),
                                top: SizeConfig.getFlexibleValue(5)),
                            child: RaisedButton(
                              color: Colors.red,
                              child: Text(countryNames.contains(country.name)
                                  ? utils.getTranslatedText(
                                      context, "DetailsRemoveFav")
                                  : utils.getTranslatedText(
                                      context, "DetailsAddFav")),
                              onPressed: () {
                                setState(() {
                                  if (countryNames.contains(country.name)) {
                                    db.removeCountryFromDB(country.name);
                                    utils.showToastMessage(
                                        context,
                                        country.name +
                                            utils.getTranslatedText(
                                                context, "UtilsDelToast"));
                                  } else {
                                    db.addCountry(country);
                                    utils.showToastMessage(
                                      context,
                                      country.name +
                                          utils.getTranslatedText(
                                              context, "UtilsAddToast"),
                                    );
                                  }
                                });
                              },
                            ),
                          ),
                        ),
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
            BarChartLayout(
                widget._countryName,
                widget._countryFlag,
                utils.getTranslatedText(context, "HistoryCaptionCases"),
                seriesCasesList),
            BarChartLayout(
                widget._countryName,
                widget._countryFlag,
                utils.getTranslatedText(context, "HistoryCaptionDeaths"),
                seriesDeathsList),
            BarChartLayout(
                widget._countryName,
                widget._countryFlag,
                utils.getTranslatedText(context, "HistoryCaptionRecovered"),
                seriesRecoveredList),
          ]),
        ),
      ),
    );
  }

  List<charts.Series<CountryDayHistory, String>> _createCasesData() {
    List<CountryDayHistory> data = [];
    int counter = 0;
    int lastValue = 0;
    history.timeline.cases.forEach((k, v) {
      if (counter > history.timeline.cases.length - 16) {
        data.add(CountryDayHistory(date: k, data: v, increase: v - lastValue));
      }
      lastValue = v;
      counter++;
    });
    data = List.from(data.reversed);

    return [
      new charts.Series<CountryDayHistory, String>(
        id: 'Cases',
        colorFn: (_, __) => charts.Color.fromHex(code: "#FFBF00FF"),
        domainFn: (CountryDayHistory history, _) => history.date,
        measureFn: (CountryDayHistory history, _) => history.data,
        data: data,
        labelAccessorFn: (CountryDayHistory history, _) => history.increase > 0
            ? '${history.data}  (+${history.increase})'
            : '${history.data}  (${history.increase})',
      )
    ];
  }

  List<charts.Series<CountryDayHistory, String>> _createDeathsData() {
    List<CountryDayHistory> data = [];
    int counter = 0;
    int lastValue = 0;
    history.timeline.deaths.forEach((k, v) {
      if (counter > history.timeline.deaths.length - 16) {
        data.add(CountryDayHistory(date: k, data: v, increase: v - lastValue));
      }
      lastValue = v;
      counter++;
    });
    data = List.from(data.reversed);

    return [
      new charts.Series<CountryDayHistory, String>(
        id: 'Deaths',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (CountryDayHistory history, _) => history.date,
        measureFn: (CountryDayHistory history, _) => history.data,
        data: data,
        labelAccessorFn: (CountryDayHistory history, _) => history.increase > 0
            ? '${history.data}  (+${history.increase})'
            : '${history.data}  (${history.increase})',
      )
    ];
  }

  List<charts.Series<CountryDayHistory, String>> _createRecoveredData() {
    List<CountryDayHistory> data = [];
    int counter = 0;
    int lastValue = 0;
    history.timeline.recovered.forEach((k, v) {
      if (counter > history.timeline.recovered.length - 16) {
        data.add(CountryDayHistory(date: k, data: v, increase: v - lastValue));
      }
      lastValue = v;
      counter++;
    });
    data = List.from(data.reversed);

    return [
      new charts.Series<CountryDayHistory, String>(
        id: 'Recovered',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (CountryDayHistory history, _) => history.date,
        measureFn: (CountryDayHistory history, _) => history.data,
        data: data,
        labelAccessorFn: (CountryDayHistory history, _) => history.increase > 0
            ? '${history.data}  (+${history.increase})'
            : '${history.data}  (${history.increase})',
      )
    ];
  }
}
