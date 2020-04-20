import 'package:corona/utils/utils.dart';

class History {
  String country;
  List<dynamic> provinces;
  TimeLine timeline;

  History({this.country, this.provinces, this.timeline});

  factory History.fromJson(Map<String, dynamic> json) {
    Utils utils = Utils.getInstance();
    return History(
        country: utils.controlData(json['country']),
        provinces: utils.controlData(json['provinces']),
        timeline: TimeLine.fromJson(json['timeline']));
  }
}

class TimeLine {
  Map<String, dynamic> cases;
  Map<String, dynamic> deaths;
  Map<String, dynamic> recovered;

  TimeLine({this.cases, this.deaths, this.recovered});

  factory TimeLine.fromJson(Map<String, dynamic> json) {
    Utils utils = Utils.getInstance();
    return TimeLine(
      cases: utils.controlData(json['cases']),
      deaths: utils.controlData(json['deaths']),
      recovered: utils.controlData(json['recovered']),
    );
  }
}
