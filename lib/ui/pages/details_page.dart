import 'package:corona/models/country.dart';
import 'package:corona/ui/pages/chart_page.dart';
import 'package:corona/utils/db.dart';
import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:corona/utils/styles.dart';

class Details extends StatefulWidget {
  final Country _country;
  Details(this._country);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  DB db;
  Utils utils;
  List<String> countryNames;
  @override
  void initState() {
    db = DB.getInstance();
    utils = Utils.getInstance();
    countryNames = new List<String>();
    countryNames = db.getCountryNames();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          utils.getTranslatedText(context, "AppName"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: SizeConfig.getFlexibleValue(10),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.transparent,
                direction: ShimmerDirection.rtl,
                period: Duration(seconds: 2),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_drop_up,
                      size: SizeConfig.getFlexibleValue(100),
                    ),
                    Text(
                      countryNames.contains(widget._country.name)
                          ? utils.getTranslatedText(context, "DetailsRemoveFav")
                          : utils.getTranslatedText(context, "DetailsAddFav"),
                      style: captionTextStyle,
                    ),
                  ],
                ),
              ),
              Dismissible(
                key: Key(widget._country.name),
                direction: DismissDirection.vertical,
                background: Icon(
                  Icons.history,
                  size: SizeConfig.getFlexibleValue(192),
                ),
                secondaryBackground: countryNames.contains(widget._country.name)
                    ? Icon(
                        Icons.delete,
                        size: SizeConfig.getFlexibleValue(192),
                      )
                    : Icon(
                        Icons.favorite,
                        size: SizeConfig.getFlexibleValue(192),
                      ),
                onDismissed: (direction) {
                  onDismissed(direction);
                },
                child: Container(
                  height: SizeConfig.getHeight() / 2.1,
                  width: double.infinity,
                  margin: EdgeInsets.all(SizeConfig.getFlexibleValue(10)),
                  child: Card(
                    color: Color.fromARGB(128, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Card(
                            color: transparentColor,
                            child: Text(
                              widget._country.name +
                                  utils.getTranslatedText(
                                      context, "DetailsCaption"),
                              style: captionTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Hero(
                              tag: widget._country.name,
                              child: widget._country.flag.contains("http")
                                  ? Image.network(
                                      widget._country.flag,
                                      width: SizeConfig.getFlexibleValue(64),
                                      height: SizeConfig.getFlexibleValue(64),
                                    )
                                  : Image.asset(
                                      widget._country.flag,
                                      width: SizeConfig.getFlexibleValue(64),
                                      height: SizeConfig.getFlexibleValue(64),
                                    ),
                            ),
                            SizedBox(width: SizeConfig.getFlexibleValue(20)),
                            Text(
                              widget._country.name,
                              style: textStyle,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  widget._country.cases.toString(),
                                  style: textStyle,
                                ),
                                Text(
                                  widget._country.deaths.toString(),
                                  style: textStyle,
                                ),
                                Text(
                                  widget._country.recovered.toString(),
                                  style: textStyle,
                                ),
                                Text(
                                  widget._country.active.toString(),
                                  style: textStyle,
                                ),
                                Text(
                                  widget._country.critical.toString(),
                                  style: textStyle,
                                ),
                                Text(
                                  widget._country.todayCases.toString(),
                                  style: textStyle,
                                ),
                                Text(
                                  widget._country.todayDeaths.toString(),
                                  style: textStyle,
                                ),
                                Text(
                                  widget._country.casesPerOneMillion.toString(),
                                  style: textStyle,
                                ),
                                Text(
                                  widget._country.deathsPerOneMillion
                                      .toString(),
                                  style: textStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.transparent,
                  direction: ShimmerDirection.ltr,
                  period: Duration(seconds: 2),
                  child: Column(
                    children: <Widget>[
                      Text(
                        utils.getTranslatedText(context, "DetailsHistory"),
                        style: captionTextStyle,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: SizeConfig.getFlexibleValue(100),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  onDismissed(DismissDirection direction) {
    if (direction == DismissDirection.up) {
      if (countryNames.contains(widget._country.name)) {
        db.removeCountryFromDB(widget._country.name);
        utils.showToastMessage(
            context,
            widget._country.name +
                utils.getTranslatedText(context, "UtilsDelToast"));
        Navigator.pop(context);
      } else {
        db.addCountry(widget._country);
        utils.showToastMessage(
            context,
            widget._country.name +
                utils.getTranslatedText(context, "UtilsAddToast"));
        Navigator.pop(context);
      }
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HistoryChart(widget._country.name, widget._country.flag)));
    }
  }
}
