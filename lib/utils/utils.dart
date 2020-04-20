import 'package:corona/models/country.dart';
import 'package:corona/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app_localization.dart';

class Utils {
  static Utils _utils;

  Utils._();

  static Utils getInstance() {
    if (_utils == null) {
      _utils = new Utils._();
    }
    return _utils;
  }

  showToastMessage(BuildContext context, String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: SizeConfig.getFlexibleValue(16));
  }

  sortByActive(List<Country> countryList) {
    countryList.sort(
        (country1, country2) => country2.active.compareTo(country1.active));
    return countryList;
  }

  sortByDeaths(List<Country> countryList) {
    countryList.sort(
        (country1, country2) => country2.deaths.compareTo(country1.deaths));
    return countryList;
  }

  sortByCases(List<Country> countryList) {
    countryList
        .sort((country1, country2) => country2.cases.compareTo(country1.cases));
    return countryList;
  }

  sortByRecovered(List<Country> countryList) {
    countryList.sort((country1, country2) =>
        country2.recovered.compareTo(country1.recovered));
    return countryList;
  }

  sortByCritical(List<Country> countryList) {
    countryList.sort(
        (country1, country2) => country2.critical.compareTo(country1.critical));
    return countryList;
  }

  sortByTodayCases(List<Country> countryList) {
    countryList.sort((country1, country2) =>
        country2.todayCases.compareTo(country1.todayCases));
    return countryList;
  }

  sortByTodayDeaths(List<Country> countryList) {
    countryList.sort((country1, country2) =>
        country2.todayDeaths.compareTo(country1.todayDeaths));
    return countryList;
  }

  sortByNames(List<Country> countryList) {
    countryList
        .sort((country1, country2) => country1.name.compareTo(country2.name));
    return countryList;
  }

  checkCountryName(String countryName) {
    if (countryName.length > 7) {
      return countryName.substring(0, 7) + "...";
    }
    return countryName;
  }

  getTranslatedText(BuildContext context, String key) {
    return AppLocalizations.of(context).translate(key);
  }

  controlData(jsonData){
    if(jsonData == null){
      return 0;
    }
    else{
      return jsonData;
    }
  }
}
