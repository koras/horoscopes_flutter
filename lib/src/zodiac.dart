import 'package:flutter/material.dart';
import 'country_detail_page.dart';
import 'zodiac_detail.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Zodiac extends StatelessWidget {
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
      locale: const Locale('ru'), // Устанавливаем сохраненную локаль
      //  localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(primarySwatch: Colors.blue),
      //   locale: context.locale,
      home: ZodiacListPage(),
    );
  }
}

class ZodiacListPage extends StatefulWidget {
  final Map<String, dynamic> zodiac = {
    'aquarius': {
      'img': 'assets/images/zodiac/aquarius.png',
      'name': 'aquarius'
    },
    'aries': {'img': 'assets/images/zodiac/aries.png', 'name': 'aries'},
    'cancer': {'img': 'assets/images/zodiac/cancer.png', 'name': 'cancer'},
    'capricorn': {
      'img': 'assets/images/zodiac/capricorn.png',
      'name': 'capricorn'
    },
    'gemini': {'img': 'assets/images/zodiac/gemini.png', 'name': 'gemini'},
    'leo': {'img': 'assets/images/zodiac/leo.png', 'name': 'leo'},
    'libra': {'img': 'assets/images/zodiac/libra.png', 'name': 'libra'},
    'pisces': {'img': 'assets/images/zodiac/pisces.png', 'name': 'pisces'},
    'sagittarius': {
      'img': 'assets/images/zodiac/sagittarius.png',
      'name': 'sagittarius'
    },
    'scorpio': {'img': 'assets/images/zodiac/scorpio.png', 'name': 'scorpio'},
    'taurus': {'img': 'assets/images/zodiac/taurus.png', 'name': 'taurus'},
    'virgo': {'img': 'assets/images/zodiac/virgo.png', 'name': 'virgo'},
  };

  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<ZodiacListPage> {
  List<dynamic> countries = [];
  List<dynamic> filteredCountries = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // fetchCountries();
  }

  final Map<String, String Function(BuildContext)> translations = {
    'virgo': (context) => AppLocalizations.of(context)!.virgo,
    'taurus': (context) => AppLocalizations.of(context)!.taurus,
    // Добавьте другие ключи по мере необходимости
  };
  String translate(String key, BuildContext context) {
    return translations.containsKey(key) ? translations[key]!(context) : key;
  }
  // Future<void> fetchCountries() async {
  //   try {
  //     var response = await Dio().get('https://restcountries.com/v3.1/all');
  //     setState(() {
  //       countries = response.data;
  //       filteredCountries = countries;
  //     });
  //   } catch (e) {
  //     print('Error fetching countries: $e');
  //   }
  // }

  // void filterCountries(String query) {
  //   setState(() {
  //     filteredCountries = countries
  //         .where((country) => country['name']['common']
  //             .toString()
  //             .toLowerCase()
  //             .contains(query.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // print(context.locale.toString());

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.helloWorld)),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: widget.zodiac.entries.map((entry) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ZodiacDetail(zodiacName: entry.key),
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
                          translate(entry.value['name'], context),
                          //   AppLocalizations.of(context)!.helloWorld,

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
