import 'package:corona/services/services.dart';
import 'package:corona/ui/layouts/country_layout_rank.dart';
import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:corona/models/country.dart';
import 'package:corona/utils/styles.dart';

class CountriesPage extends StatefulWidget {
  List<Country> _countryList;
  bool _visibilitySortButtons;
  BuildContext _mainContext;
  String _captionText;

  CountriesPage(Key k, this._mainContext) : super(key: k);

  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  Services services;
  Utils utils;
  int bannerNum;
  @override
  void initState() {
    services = Services.getInstance();
    utils = Utils.getInstance();
    widget._countryList = new List<Country>();
    services.fetchAllCountryData().then((result) {
      result.removeRange(0, 8); //for api continent update
      result.removeRange(result.length-7, result.length); //for api continent update
      setState(() {
        widget._countryList = utils.sortByCases(result);
      });
    });
    widget._visibilitySortButtons = false;
    widget._captionText =
        utils.getTranslatedText(widget._mainContext, "CountriesTotalCases");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover),
      ),
      child: widget._countryList.length > 0
          ? Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.getFlexibleValue(10)),
                  width: double.infinity,
                  child: Card(
                    color: Colors.transparent,
                    child: Text(
                      widget._captionText,
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: <Widget>[
                      ListView.builder(
                        itemCount: widget._countryList.length - 1,
                        itemBuilder: (contex, index) {
                          return LayoutCountryRank(
                              widget._countryList[index], index);
                        },
                      ),
                      Positioned(
                        bottom: SizeConfig.getFlexibleValue(20),
                        right: SizeConfig.getFlexibleValue(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Visibility(
                              visible: widget._visibilitySortButtons,
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    width: SizeConfig.getFlexibleValue(210),
                                    height: SizeConfig.getFlexibleValue(30),
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          SizeConfig.getFlexibleValue(5)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.0)),
                                        color: Colors.redAccent,
                                      ),
                                      child: Center(
                                        child: Text(
                                            utils.getTranslatedText(context,
                                                "CountriesSortCaption"),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    SizeConfig.getFlexibleValue(
                                                        20),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Roboto")),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.getFlexibleValue(5),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.getFlexibleValue(210),
                                    child: RaisedButton(
                                      child: Text(
                                          utils.getTranslatedText(context,
                                              "CountriesSortTotalCases"),
                                          style: sortListTextStyle),
                                      color: transparentWhite,
                                      elevation: SizeConfig.getFlexibleValue(4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.getFlexibleValue(5)),
                                      onPressed: btnSortCase,
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.getFlexibleValue(210),
                                    child: RaisedButton(
                                      child: Text(
                                          utils.getTranslatedText(context,
                                              "CountriesSortTotalDeaths"),
                                          style: sortListTextStyle),
                                      color: transparentWhite,
                                      elevation: SizeConfig.getFlexibleValue(4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.getFlexibleValue(5)),
                                      onPressed: btnSortDeath,
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.getFlexibleValue(210),
                                    child: RaisedButton(
                                      child: Text(
                                          utils.getTranslatedText(context,
                                              "CountriesSortTotalRecovered"),
                                          style: sortListTextStyle),
                                      color: transparentWhite,
                                      elevation: SizeConfig.getFlexibleValue(4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.getFlexibleValue(5)),
                                      onPressed: btnSortRecovered,
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.getFlexibleValue(210),
                                    child: RaisedButton(
                                      child: Text(
                                          utils.getTranslatedText(
                                              context, "CountriesSortActive"),
                                          style: sortListTextStyle),
                                      color: transparentWhite,
                                      elevation: SizeConfig.getFlexibleValue(4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.getFlexibleValue(5)),
                                      onPressed: btnSortActive,
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.getFlexibleValue(210),
                                    child: RaisedButton(
                                      child: Text(
                                          utils.getTranslatedText(
                                              context, "CountriesSortCritical"),
                                          style: sortListTextStyle),
                                      color: transparentWhite,
                                      elevation: SizeConfig.getFlexibleValue(4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.getFlexibleValue(5)),
                                      onPressed: btnSortCritical,
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.getFlexibleValue(210),
                                    child: RaisedButton(
                                      child: Text(
                                          utils.getTranslatedText(context,
                                              "CountriesSortTodayCases"),
                                          style: sortListTextStyle),
                                      color: transparentWhite,
                                      elevation: SizeConfig.getFlexibleValue(4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.getFlexibleValue(5)),
                                      onPressed: btnSortTodayCase,
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.getFlexibleValue(210),
                                    child: RaisedButton(
                                      child: Text(
                                          utils.getTranslatedText(context,
                                              "CountriesSortTodayDeaths"),
                                          style: sortListTextStyle),
                                      color: transparentWhite,
                                      elevation: SizeConfig.getFlexibleValue(4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.getFlexibleValue(5)),
                                      onPressed: btnSortTodayDeath,
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.getFlexibleValue(210),
                                    child: RaisedButton(
                                      child: Text(
                                          utils.getTranslatedText(
                                              context, "CountriesSortNames"),
                                          style: sortListTextStyle),
                                      color: transparentWhite,
                                      elevation: SizeConfig.getFlexibleValue(4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.getFlexibleValue(5)),
                                      onPressed: btnSortName,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FloatingActionButton(
                              child: Icon(
                                Icons.sort,
                                size: SizeConfig.getFlexibleValue(30),
                              ),
                              backgroundColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  widget._visibilitySortButtons =
                                      !widget._visibilitySortButtons;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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
            ),
    );
  }

  btnSortCase() {
    setState(() {
      widget._countryList = utils.sortByCases(widget._countryList);
      widget._captionText =
          utils.getTranslatedText(context, "CountriesTotalCases");
      widget._visibilitySortButtons = !widget._visibilitySortButtons;
    });
  }

  btnSortDeath() {
    setState(() {
      widget._countryList = utils.sortByDeaths(widget._countryList);
      widget._captionText =
          utils.getTranslatedText(context, "CountriesTotalDeaths");
      widget._visibilitySortButtons = !widget._visibilitySortButtons;
    });
  }

  btnSortRecovered() {
    setState(() {
      widget._countryList = utils.sortByRecovered(widget._countryList);
      widget._captionText =
          utils.getTranslatedText(context, "CountriesTotalRecovered");
      widget._visibilitySortButtons = !widget._visibilitySortButtons;
    });
  }

  btnSortActive() {
    setState(() {
      widget._countryList = utils.sortByActive(widget._countryList);
      widget._captionText = utils.getTranslatedText(context, "CountriesActive");
      widget._visibilitySortButtons = !widget._visibilitySortButtons;
    });
  }

  btnSortCritical() {
    setState(() {
      widget._countryList = utils.sortByCritical(widget._countryList);
      widget._captionText =
          utils.getTranslatedText(context, "CountriesCritical");
      widget._visibilitySortButtons = !widget._visibilitySortButtons;
    });
  }

  btnSortTodayCase() {
    setState(() {
      widget._countryList = utils.sortByTodayCases(widget._countryList);
      widget._captionText =
          utils.getTranslatedText(context, "CountriesTodayCases");
      widget._visibilitySortButtons = !widget._visibilitySortButtons;
    });
  }

  btnSortTodayDeath() {
    setState(() {
      widget._countryList = utils.sortByTodayDeaths(widget._countryList);
      widget._captionText =
          utils.getTranslatedText(context, "CountriesTodayDeaths");
      widget._visibilitySortButtons = !widget._visibilitySortButtons;
    });
  }

  btnSortName() {
    setState(() {
      widget._countryList = utils.sortByNames(widget._countryList);
      widget._captionText = utils.getTranslatedText(context, "CountriesNames");
      widget._visibilitySortButtons = !widget._visibilitySortButtons;
    });
  }
}
