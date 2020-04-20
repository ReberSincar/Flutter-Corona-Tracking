import 'package:corona/models/country.dart';
import 'package:corona/ui/pages/chart_page.dart';
import 'package:corona/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:corona/utils/db.dart';
import 'package:corona/utils/styles.dart';
import 'package:corona/utils/utils.dart';

class LayoutCountrySearch extends StatefulWidget {
  final Country _country;

  LayoutCountrySearch(this._country);

  @override
  _LayoutCountrySearchState createState() => _LayoutCountrySearchState();
}

class _LayoutCountrySearchState extends State<LayoutCountrySearch> {
  DB db;
  Utils utils;
  List<String> countryNames;
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
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getFlexibleValue(10),
          vertical: SizeConfig.getFlexibleValue(2.5)),
      width: SizeConfig.getWidth(),
      child: Card(
        color: transparentColor,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.getFlexibleValue(20),
              vertical: SizeConfig.getFlexibleValue(5)),
          leading: Hero(
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
          title: Text(
            widget._country.name,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          subtitle: Column(
            children: <Widget>[
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
          trailing: countryNames.contains(widget._country.name)
              ? IconButton(
                  icon: Icon(
                    Icons.check_circle,
                    size: SizeConfig.getFlexibleValue(45),
                  ),
                  onPressed: () {
                    setState(() {
                      db.removeCountryFromDB(widget._country.name);
                      utils.showToastMessage(
                          context,
                          widget._country.name +
                              utils.getTranslatedText(
                                  context, "UtilsDelToast"));
                    });
                  })
              : IconButton(
                  icon: Icon(
                    Icons.check_circle_outline,
                    size: SizeConfig.getFlexibleValue(45),
                  ),
                  onPressed: () {
                    setState(() {
                      db.addCountry(widget._country);
                      utils.showToastMessage(
                          context,
                          widget._country.name +
                              utils.getTranslatedText(
                                  context, "UtilsAddToast"));
                    });
                  }),
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
      ),
    );
  }
}
