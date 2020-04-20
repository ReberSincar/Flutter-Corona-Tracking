import 'package:corona/models/country.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:corona/services/services.dart';

class DB {
  Future<SharedPreferences> _prefs;
  Set<Country> _countryList;
  List<String> _countryNames;
  Services _services;
  static DB _db;

  DB._() {
    _prefs = SharedPreferences.getInstance();
    _countryList = new Set<Country>();
    _countryNames = new List<String>();
    _services = Services.getInstance();

    _getCountryNamesFromDB().then((_) {
      _createCountryList();
    });
  }

  static DB getInstance() {
    if (_db == null) {
      _db = DB._();
    }
    return _db;
  }

  getCountryList() {
    return _countryList;
  }

  getCountryNames() {
    return _countryNames;
  }

  _getCountryNamesFromDB() async {
    SharedPreferences prefs = await _prefs;
    _countryNames = prefs.getStringList("countries");
    if (_countryNames == null) {
      _countryNames = [];
    }
  }

  _createCountryList() {
    _countryList.clear();
    for (var name in _countryNames) {
      _services.fetchCountryData(name).then((country) {
        _countryList.add(country);
        return;
      });
    }
  }

  addCountry(Country country) async {
    if (!_countryNames.contains(country.name)) {
      _countryNames.add(country.name);
      _countryList.add(country);
      _addListToDB();
    }
  }

  removeCountryFromDB(String countryName) async {
    if (_countryNames.contains(countryName)) {
      _countryNames.remove(countryName);
      _countryList.removeWhere((item) => item.name == countryName);
      _addListToDB();
    }
  }

  _addListToDB() async {
    SharedPreferences prefs = await _prefs;
    prefs.setStringList("countries", _countryNames).then((_) {});
  }

  Future<bool> clearDB() async {
    if (_countryList.isNotEmpty) {
      _countryNames.clear();
      _countryList.clear();
      SharedPreferences prefs = await _prefs;
      prefs.setStringList("countries", _countryNames);
      return true;
    } else {
      return false;
    }
  }

  printFavoriteCountries() {
    print(_countryNames);
    print(_countryList.length);
  }
}
