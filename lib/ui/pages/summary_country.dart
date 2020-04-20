import 'package:corona/models/country.dart';
import 'package:corona/services/services.dart';
import 'package:corona/ui/layouts/country_layout_sum.dart';
import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/styles.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';

class SummaryCountry extends StatefulWidget {
  SummaryCountry({Key key}) : super(key: key);

  @override
  _SummaryCountryState createState() => _SummaryCountryState();
}

class _SummaryCountryState extends State<SummaryCountry> {
  Utils utils;
  Services services;
  List<Country> mostCasesList;
  List<Country> mostDeathsList;

  @override
  void initState() {
    utils = Utils.getInstance();
    services = Services.getInstance();
    mostCasesList = new List<Country>();
    mostDeathsList = new List<Country>();
    services.fetchAllCountryData().then((result) {
      result.removeRange(0, 8); //for api continent update
      result.removeRange(result.length-7, result.length); //for api continent update
      setState(() {
        mostCasesList = utils.sortByActive(result);
      });
    });

    services.fetchAllCountryData().then((result) {
      result.removeRange(0, 8); //for api continent update
      result.removeRange(result.length-7, result.length); //for api continent update
      setState(() {
        mostDeathsList = utils.sortByDeaths(result);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mostCasesList.length > 0 && mostDeathsList.length > 0
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Card(
                    color: transparentColor,
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.getFlexibleValue(10)),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              utils.getTranslatedText(
                                  context, "SummaryMostPatients"),
                              style: textStyle,
                              textAlign: TextAlign.center,
                            ),
                            SummaryCountryLayout(mostCasesList[0]),
                            SummaryCountryLayout(mostCasesList[1]),
                            SummaryCountryLayout(mostCasesList[2]),
                            SummaryCountryLayout(mostCasesList[3]),
                            SummaryCountryLayout(mostCasesList[4]),
                            SummaryCountryLayout(mostCasesList[5]),
                            SummaryCountryLayout(mostCasesList[6]),
                            SummaryCountryLayout(mostCasesList[7]),
                            SummaryCountryLayout(mostCasesList[8]),
                            SummaryCountryLayout(mostCasesList[9]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Container(
                    child: Card(
                      color: transparentColor,
                      child: Padding(
                        padding:
                            EdgeInsets.all(SizeConfig.getFlexibleValue(10)),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                utils.getTranslatedText(
                                    context, "SummaryMostDeaths"),
                                style: textStyle,
                                textAlign: TextAlign.center,
                              ),
                              SummaryCountryLayout(mostDeathsList[0]),
                              SummaryCountryLayout(mostDeathsList[1]),
                              SummaryCountryLayout(mostDeathsList[2]),
                              SummaryCountryLayout(mostDeathsList[3]),
                              SummaryCountryLayout(mostDeathsList[4]),
                              SummaryCountryLayout(mostDeathsList[5]),
                              SummaryCountryLayout(mostDeathsList[6]),
                              SummaryCountryLayout(mostDeathsList[7]),
                              SummaryCountryLayout(mostDeathsList[8]),
                              SummaryCountryLayout(mostDeathsList[9]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Card(
            color: transparentColor,
            child: Center(
              child: Container(
                width: SizeConfig.getFlexibleValue(100),
                height: SizeConfig.getFlexibleValue(100),
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }
}
