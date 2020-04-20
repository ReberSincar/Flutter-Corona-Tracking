import 'package:corona/models/country.dart';
import 'package:corona/ui/pages/chart_page.dart';
import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:corona/utils/db.dart';
import 'package:corona/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

class LayoutCountryFav extends StatefulWidget {
  final Country _country;

  LayoutCountryFav(this._country);

  @override
  _LayoutCountryFavState createState() => _LayoutCountryFavState();
}

class _LayoutCountryFavState extends State<LayoutCountryFav> {
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
          title: Text(widget._country.name, style: textStyle),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                  utils.getTranslatedText(context, "LayoutCases") +
                      widget._country.cases.toString(),
                  style: textStyleSubTitle),
              SizedBox(
                width: SizeConfig.getFlexibleValue(10),
              ),
              Text(
                  utils.getTranslatedText(context, "LayoutDeaths") +
                      widget._country.deaths.toString(),
                  style: textStyleSubTitle),
            ],
          ),
          trailing: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: transparentColor,
            direction: ShimmerDirection.ltr,
            period: Duration(seconds: 2),
            child: Icon(Icons.arrow_forward_ios,
                size: SizeConfig.getFlexibleValue(35)),
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
      ),
    );
  }
}
