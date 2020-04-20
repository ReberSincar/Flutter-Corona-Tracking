import 'dart:async';
import 'package:corona/models/country.dart';
import 'package:corona/services/services.dart';
import 'package:corona/ui/layouts/contact_layout.dart';
import 'package:corona/ui/pages/no_connection.dart';
import 'package:corona/ui/pages/splash_screen.dart';
import 'package:corona/ui/pages/summary_page.dart';
import 'package:corona/utils/db.dart';
import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/styles.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'countries_page.dart';
import 'favorites_page.dart';
import 'search_page.dart';
import 'package:corona/app_localization.dart';
import 'package:connectivity/connectivity.dart';

const String testDevice = "81E90B94EA07309F8EF9D32F24835EDF";
const String appId = "ca-app-pub-7689183541070639~9571655266";
const String bannerId = "ca-app-pub-7689183541070639/5442313349";
const String nativeId = "ca-app-pub-7689183541070639/5914168205";
const String interId = "ca-app-pub-7689183541070639/2349246149";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) =>
          AppLocalizations.of(context).translate('AppName'),
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.white,
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('tr', 'TR'),
        Locale('es', 'ES'),
        Locale('de', 'DE'),
        Locale('pt', 'PT'),
        Locale('fr', 'FR'),
        Locale('it', 'IT'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: ScreenSplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  var keyCountries = PageStorageKey("countriesKey");
  var keyFavorites = PageStorageKey("favoritesKey");
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool connectionStatus;
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  Services services;
  Set<Country> countries;
  List<Widget> pages;
  int selectedIndex;
  DB db;
  Utils utils;
  bool adviceVisible;
  final ValueNotifier currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    connectionStatus = false;
    connectivity = new Connectivity();
    listenNetwork();
    db = DB.getInstance();
    utils = Utils.getInstance();
    services = Services.getInstance();
    pages = new List();
    selectedIndex = 0;
    pages.add(SummaryPage());
    pages.add(CountriesPage(widget.keyCountries, context));
    pages.add(SearchPage());
    pages.add(FavoritesPage(widget.keyFavorites));
    adviceVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //For prevent landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig.getInstance(context);
    return connectionStatus
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Row(
                children: <Widget>[
                  Image.asset(
                    "assets/icons/icon.png",
                    width: SizeConfig.getFlexibleValue(35),
                    height: SizeConfig.getFlexibleValue(35),
                  ),
                  SizedBox(
                    width: SizeConfig.getFlexibleValue(20),
                  ),
                  Text(
                    utils.getTranslatedText(context, 'AppName'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.getFlexibleValue(18),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(right: SizeConfig.getFlexibleValue(10)),
                  child: IconButton(
                    icon: Icon(
                      Icons.info,
                      size: SizeConfig.getFlexibleValue(30),
                    ),
                    onPressed: changeAdviceVisibility,
                  ),
                ),
              ],
              centerTitle: false,
            ),
            body: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: <Widget>[
                  pages[selectedIndex],
                  Positioned(
                    child: Visibility(
                      visible: adviceVisible,
                      child: Container(
                        color: Colors.black87,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ContactLayout(),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                size: SizeConfig.getFlexibleValue(30),
                              ),
                              onPressed: changeAdviceVisibility,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  title: Text(
                    utils.getTranslatedText(context, 'AppBarSummaryPage'),
                    style: optionStyle,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.globeEurope,
                  ),
                  title: Text(
                    utils.getTranslatedText(context, 'AppBarCountriesPage'),
                    style: optionStyle,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                  ),
                  title: Text(
                    utils.getTranslatedText(context, 'AppBarSearchPage'),
                    style: optionStyle,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.format_list_bulleted,
                  ),
                  title: Text(
                    utils.getTranslatedText(context, 'AppBarFavoritesPage'),
                    style: optionStyle,
                  ),
                ),
              ],
              currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              onTap: _onItemTapped,
            ),
          )
        : NoConnection();
  }

  void _onItemTapped(int index) {
    setState(() {
      if (adviceVisible) {
        adviceVisible = !adviceVisible;
      }

      selectedIndex = index;
    });
  }

  changeAdviceVisibility() {
    setState(() {
      adviceVisible = !adviceVisible;
    });
  }

  listenNetwork() {
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {
          connectionStatus = true;
          print(connectionStatus);
        });
      } else {
        setState(() {
          connectionStatus = false;
          print(connectionStatus);
        });
      }
    });
  }
}
