import 'package:corona/utils/country_codes.dart';
import 'package:corona/utils/utils.dart';

class Country {
  final String name;
  String flag;
  var cases;
  var todayCases;
  var deaths;
  var todayDeaths;
  var recovered;
  var active;
  var critical;
  var casesPerOneMillion;
  var deathsPerOneMillion;
  var totalTests;
  var testsPerOneMillion;

  Country(
      {this.name,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.totalTests,
      this.testsPerOneMillion});

  factory Country.fromJson(Map<String, dynamic> json) {
    Utils utils = Utils.getInstance();
    Country country = new Country(
      name: utils.controlData(json['country']),
      cases: utils.controlData(json['cases']),
      todayCases: utils.controlData(json['todayCases']),
      deaths: utils.controlData(json['deaths']),
      todayDeaths: utils.controlData(json['todayDeaths']),
      recovered: utils.controlData(json['recovered']),
      active: utils.controlData(json['active']),
      critical: utils.controlData(json['critical']),
      casesPerOneMillion: utils.controlData(json['casesPerOneMillion']),
      deathsPerOneMillion: utils.controlData(json['deathsPerOneMillion']),
      totalTests: utils.controlData(json['totalTests']),
      testsPerOneMillion: utils.controlData(json['testsPerOneMillion']),
    );
    country.flag = countryCodes[country.name] != null
        ? "https://www.countryflags.io/" +
            countryCodes[country.name] +
            "/shiny/64.png"
        : "assets/images/UnknownFlag.png";
    return country;
  }
}
