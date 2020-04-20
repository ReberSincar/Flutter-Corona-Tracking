import 'package:corona/models/country.dart';
import 'package:corona/ui/layouts/country_layout_fav.dart';
import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:corona/utils/styles.dart';
import 'package:corona/utils/db.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage(Key key) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  DB db;
  Utils utils;
  int bannerNum;
  Set<Country> favList;
  @override
  void initState() {
    db = DB.getInstance();
    utils = Utils.getInstance();
    favList = db.getCountryList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: SizeConfig.getFlexibleValue(10)),
              width: double.infinity,
              child: Card(
                color: Colors.transparent,
                child: Text(
                  utils.getTranslatedText(context, "FavoritesCaption"),
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: favList.length > 0
                  ? ListView.builder(
                      primary: false,
                      itemCount: favList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: Key(favList.elementAt(index).name),
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.getFlexibleValue(10)),
                              child: Card(
                                color: Colors.redAccent.shade700,
                                child: Icon(
                                  Icons.delete,
                                  size: SizeConfig.getFlexibleValue(24),
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              onDismissed(direction, index);
                            },
                            child: LayoutCountryFav(favList.elementAt(index)));
                      },
                    )
                  : Center(
                      child: Text(
                        utils.getTranslatedText(context, "FavoritesEmptyList"),
                        style: TextStyle(
                            fontSize: SizeConfig.getFlexibleValue(18),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Lora"),
                        textAlign: TextAlign.right,
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getFlexibleValue(20),
                  vertical: SizeConfig.getFlexibleValue(10)),
              child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.getFlexibleValue(10)),
                  color: Colors.redAccent,
                  onPressed: btnClear,
                  child: Text(
                    utils.getTranslatedText(context, "FavoritesClearButton"),
                    style: textStyle,
                  )),
            ),
          ]),
    );
  }

  onDismissed(DismissDirection direction, int index) {
    setState(
      () {
        String countryName = favList.elementAt(index).name;
        db.removeCountryFromDB(countryName);

        utils.showToastMessage(
          context,
          countryName + utils.getTranslatedText(context, "UtilsDelToast"),
        );
      },
    );
  }

  btnClear() {
    setState(() {
      Future<bool> dbFuture = db.clearDB();
      dbFuture.then((result) {
        if (result) {
          utils.showToastMessage(
            context,
            utils.getTranslatedText(context, "FavoritesOkClear") +
                utils.getTranslatedText(context, "UtilsDelToast"),
          );
        } else {
          utils.showToastMessage(
            context,
            utils.getTranslatedText(context, "FavoritesErrClear"),
          );
        }
      });
    });
  }
}
