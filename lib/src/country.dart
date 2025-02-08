import 'package:flutter/material.dart';
import 'country_detail_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Country extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Flags',
      localizationsDelegates: [AppLocalizations.delegate],
      supportedLocales: [
        // Locale('ru'), // English
        Locale('en'), // English
        Locale('es'), // Spanish
      ],
      theme: ThemeData(primarySwatch: Colors.blue),
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
    'aquarius': {'img': 'assets/images/zodiac/aquarius.png'},
    'aries': {'img': 'assets/images/zodiac/aries.png'},
    'cancer': {'img': 'assets/images/zodiac/cancer.png'},
    'capricorn': {'img': 'assets/images/zodiac/capricorn.png'},
    'gemini': {'img': 'assets/images/zodiac/gemini.png'},
    'leo': {'img': 'assets/images/zodiac/leo.png'},
    'libra': {'img': 'assets/images/zodiac/libra.png'},
    'pisces': {'img': 'assets/images/zodiac/pisces.png'},
    'sagitarius': {'img': 'assets/images/zodiac/sagitarius.png'},
    'scorpio': {'img': 'assets/images/zodiac/scorpio.png'},
    'taurus': {'img': 'assets/images/zodiac/taurus.png'},
    'virgo': {'img': 'assets/images/zodiac/virgo.png'},
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
    return Scaffold(
      appBar: AppBar(title: Text('Choose a Country')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(labelText: 'Search country'),
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
