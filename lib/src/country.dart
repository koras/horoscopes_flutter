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
    final Map<String, dynamic> zodiac = {
      'aquarius': {'img': 'images/zodiac/aquarius.png', 'name': 'aquarius'},
      'aries': {'img': 'images/zodiac/aries.png', 'name': 'aries'},
      'cancer': {'img': 'images/zodiac/cancer.png', 'name': 'cancer'},
      'capricorn': {'img': 'images/zodiac/capricorn.png', 'name': 'capricorn'},
      'gemini': {'img': 'images/zodiac/gemini.png', 'name': 'gemini'},
      'leo': {'img': 'images/zodiac/leo.png', 'name': 'leo'},
      'libra': {'img': 'images/zodiac/libra.png', 'name': 'libra'},
      'pisces': {'img': 'images/zodiac/pisces.png', 'name': 'pisces'},
      'sagittarius': {
        'img': 'images/zodiac/sagittarius.png',
        'name': 'sagittarius'
      },
      'scorpio': {'img': 'images/zodiac/scorpio.png', 'name': 'scorpio'},
      'taurus': {'img': 'images/zodiac/taurus.png', 'name': 'taurus'},
      'virgo': {'img': 'images/zodiac/virgo.png', 'name': 'virgo'},
    };

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.helloWorld)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'search_country'.toString(),
              ),
              onChanged: filterCountries,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: zodiac.entries.map((entry) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ZodiacDetailScreen(zodiacSign: entry.key),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          entry.value['img'],
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(height: 8),
                        Text(
                          entry.value['name'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ZodiacDetailScreen extends StatelessWidget {
  final String zodiacSign;

  ZodiacDetailScreen({required this.zodiacSign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(zodiacSign)),
      body: Center(
        child: Text('Details for $zodiacSign'),
      ),
    );
  }
}
