import 'package:corona/models/country.dart';
import 'package:corona/ui/pages/chart_page.dart';
import 'package:corona/utils/db.dart';
import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:corona/utils/styles.dart';

class LayoutCountryRank extends StatefulWidget {
  final Country _country;
  final int _index;

  LayoutCountryRank(this._country, this._index);

  @override
  _LayoutCountryRankState createState() => _LayoutCountryRankState();
}

class _LayoutCountryRankState extends State<LayoutCountryRank> {
  DB db;
  List<String> countryNames;
  Utils utils;
  @override
  void initState() {
    db = DB.getInstance();
    utils = Utils.getInstance();
    countryNames = db.getCountryNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.getFlexibleValue(90),
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.getFlexibleValue(5),
          horizontal: SizeConfig.getFlexibleValue(10)),
      child: GestureDetector(
        child: Card(
          color: transparentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.getFlexibleValue(20),
                  ),
                  Text(
                    (widget._index + 1).toString(),
                    style: captionTextStyle,
                  ),
                  SizedBox(
                    width: SizeConfig.getFlexibleValue(40),
                  ),
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
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget._country.name,
                    style: textStyle,
                  ),
                  Text(
                      utils.getTranslatedText(context, "LayoutCases") +
                          widget._country.cases.toString(),
                      style: textStyleSubTitle),
                  Text(
                      utils.getTranslatedText(context, "LayoutDeaths") +
                          widget._country.deaths.toString(),
                      style: textStyleSubTitle),
                ],
              ),
              countryNames.contains(widget._country.name)
                  ? Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.getFlexibleValue(10)),
                      child: IconButton(
                        icon: Icon(
                          Icons.check_circle,
                          size: SizeConfig.getFlexibleValue(45),
                        ),
                        onPressed: removeCountry,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.getFlexibleValue(10)),
                      child: IconButton(
                        icon: Icon(
                          Icons.check_circle_outline,
                          size: SizeConfig.getFlexibleValue(45),
                        ),
                        onPressed: addCountry,
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
                  HistoryChart(widget._country.name, widget._country.flag),
            ),
          );
        },
      ),
    );
  }

  removeCountry() {
    setState(() {
      db.removeCountryFromDB(widget._country.name);
      utils.showToastMessage(
          context,
          widget._country.name +
              utils.getTranslatedText(context, "UtilsDelToast"));
    });
  }

  addCountry() {
    setState(() {
      db.addCountry(widget._country);
      utils.showToastMessage(
          context,
          widget._country.name +
              utils.getTranslatedText(context, "UtilsAddToast"));
    });
  }
}
