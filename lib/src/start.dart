import 'package:flutter/material.dart';
import 'country_detail_page.dart';
import 'zodiac/zodiac_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';

import '../../constants/app_colors.dart';
import 'zodiac/zodiac_data.dart';
import 'compatibility/compatibility.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Start extends StatelessWidget {
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, // Тёмная тема
    primaryColor: Colors.blueGrey, // Основной цвет
    scaffoldBackgroundColor: AppColors.background, // Фон Scaffold
    appBarTheme: AppBarTheme(
      color: AppColors.background, // Цвет AppBar
    ),
    // Дополнительные настройки (например, шрифты, кнопки и т.д.)

    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueGrey[200], // Цвет кнопок
    ),
  );

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

      //   localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      //  locale: const Locale('en'),
//      locale: const Locale('ru'), // Устанавливаем сохраненную локаль
      //  localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: darkTheme,
      home: ZodiacDetail(),
      // home: Text('123123'),
      //   locale: context.locale,
      // home: ZodiacListPage(),
    );
  }
}

class ZodiacListPage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    // print(context.locale.toString());

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.virgo)),
      // Text('helloWorld'.tr())),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: zodiacs.entries.map((entry) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ZodiacDetail(),
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
                          //  translate(entry.value['name'], context),
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
