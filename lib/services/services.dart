import 'dart:convert';
import 'package:corona/models/allcases.dart';
import 'package:corona/models/country.dart';
import 'package:corona/models/history.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;

class Services {

  String baseUrl = "https://coronavirus-19-api.herokuapp.com/";
  String allCasesPath = "all";
  String allCountriesPath = "countries/";

  String baseHistoryUrl = "https://corona.lmao.ninja/v2/historical/";
  static Services _services;

  Services._();

  static Services getInstance() {
    if (_services == null) {
      _services = Services._();
    }
    return _services;
  }

  Future<AllCases> fetchAllCases() async {
    final response = await http.get(baseUrl + allCasesPath);
    if (response.statusCode == 200) {
      return AllCases.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data.");
    }
  }

  Future<List<Country>> fetchAllCountryData() async {
    final response = await http.get(baseUrl + allCountriesPath);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Country>((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load data.");
    }
  }

  Future<Country> fetchCountryData(String countryName) async {
    final response = await http.get(baseUrl + allCountriesPath + countryName);
    if (response.statusCode == 200) {
      return Country.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data.");
    }
  }

  Future<History> fetchCountryHistory(String countryName) async{
    final response = await http.get(baseHistoryUrl+countryName);
    if(response.statusCode == 200){
      return History.fromJson(json.decode(response.body));
    }
    else{
      throw Exception("Failed to load data");
    }
  }
}