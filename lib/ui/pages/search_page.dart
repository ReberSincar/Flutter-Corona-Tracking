import 'package:corona/ui/layouts/country_layout_search.dart';
import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:corona/models/country.dart';
import 'package:corona/services/services.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Country> searchResults;
  List<Country> countryList;
  Services services;
  int bannerNum;
  TextEditingController searchController;
  Utils utils;

  @override
  void initState() {
    services = Services.getInstance();
    utils = Utils.getInstance();
    countryList = new List<Country>();
    getCountries();
    searchResults = new List<Country>();
    searchController = TextEditingController();
    searchController.addListener(searchCountry);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(
              SizeConfig.getFlexibleValue(15),
              SizeConfig.getFlexibleValue(15),
              SizeConfig.getFlexibleValue(15),
              SizeConfig.getFlexibleValue(10)),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: utils.getTranslatedText(context, 'SearchHintText'),
              prefixIcon: Icon(Icons.search),
            ),
            autofocus: true,
          ),
        ),
        Expanded(
          child: searchResults.length > 0
              ? ListView.builder(
                  primary: false,
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return LayoutCountrySearch(searchResults.elementAt(index));
                  })
              : Padding(
                  padding: EdgeInsets.all(SizeConfig.getFlexibleValue(10)),
                  child: Center(
                    child: Text(
                      utils.getTranslatedText(context, "SearchNoData"),
                      style: TextStyle(
                          fontSize: SizeConfig.getFlexibleValue(18),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Lora"),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
        ),
      ]),
    );
  }

  getCountries() {
    services.fetchAllCountryData().then((result) {
      /*
      result.removeRange(0, 8); //for api continent update
      result.removeRange(result.length-7, result.length); //for api continent update
      */
      result.removeAt(0);
      countryList = result;
    });
  }

  searchCountry() {
    searchResults.clear();
    if (searchController.text != "") {
      for (var country in countryList) {
        if (country.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          setState(() {
            searchResults.add(country);
          });
        }
      }
      if (searchResults.isEmpty) {
        setState(() {
          searchResults.clear();
        });
      }
    } else {
      setState(() {
        searchResults.clear();
      });
    }
  }
}
