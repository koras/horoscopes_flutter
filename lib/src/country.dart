import 'package:flutter/material.dart';
import 'country_detail_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Country extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Flags',
      //    localizationsDelegates: context.localizationDelegates,
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      //  localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(primarySwatch: Colors.blue),
      //   locale: context.locale,
      home: CountryListPage(),
    );
  }
}

class CountryListPage extends StatefulWidget {
  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  Map<String, dynamic> zodiac = {
    'aquarius': {
      'img': 'assets/images/zodiac/aquarius.png',
      'name': 'aquarius'
    },
    'aries': {'img': 'assets/images/zodiac/aries.png', 'name': 'aquarius'},
    'cancer': {'img': 'assets/images/zodiac/cancer.png', 'name': 'aquarius'},
    'capricorn': {
      'img': 'assets/images/zodiac/capricorn.png',
      'name': 'aquarius'
    },
    'gemini': {'img': 'assets/images/zodiac/gemini.png', 'name': 'aquarius'},
    'leo': {'img': 'assets/images/zodiac/leo.png', 'name': 'aquarius'},
    'libra': {'img': 'assets/images/zodiac/libra.png', 'name': 'aquarius'},
    'pisces': {'img': 'assets/images/zodiac/pisces.png', 'name': 'aquarius'},
    'sagitarius': {
      'img': 'assets/images/zodiac/sagitarius.png',
      'name': 'aquarius'
    },
    'scorpio': {'img': 'assets/images/zodiac/scorpio.png', 'name': 'aquarius'},
    'taurus': {'img': 'assets/images/zodiac/taurus.png', 'name': 'aquarius'},
    'virgo': {'img': 'assets/images/zodiac/virgo.png', 'name': 'aquarius'},
  };

  List<dynamic> countries = [];
  List<dynamic> filteredCountries = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      var response = await Dio().get('https://restcountries.com/v3.1/all');
      setState(() {
        countries = response.data;
        filteredCountries = countries;
      });
    } catch (e) {
      print('Error fetching countries: $e');
    }
  }

  void filterCountries(String query) {
    setState(() {
      filteredCountries = countries
          .where((country) => country['name']['common']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(context.locale.toString());

    return Scaffold(
      //  appBar: AppBar(title: Text('Choose a Country')),
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.helloWorld)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'search_country'.tr(),

                //    labelText: Text(AppLocalizations.of(context)!.helloWorld),
              ),
              onChanged: filterCountries,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                var country = filteredCountries[index];
                return ListTile(
                  title: Text(country['name']['common']),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CountryDetailPage(
                        countryName: country['name']['common'],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
