import 'package:corona/utils/utils.dart';

class AllCases {
  var cases;
  var deaths;
  var recovered;

  AllCases({this.cases, this.deaths, this.recovered});

  factory AllCases.fromJson(Map<String, dynamic> json) {
    Utils utils = Utils.getInstance();
    return AllCases(
        cases: utils.controlData(json['cases']),
        deaths: utils.controlData(json['deaths']),
        recovered: utils.controlData(json['recovered']));
  }
  
}
