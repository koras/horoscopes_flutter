import 'package:flutter/material.dart';
import '../country_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';
import '../zodiac/zodiac_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:collection/collection.dart'; // Для firstWhereOrNull
import 'dart:math';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Compatibility extends StatefulWidget {
  @override
  _CompatibilityState createState() => _CompatibilityState();
}

class _CompatibilityState extends State<Compatibility> {
  Map<String, dynamic>? compatibilityInfo;
  // List<dynamic> countries = [];
//  List<dynamic> filteredCountries = [];
//  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCompatibilityDetails();
  }

  Future<void> fetchCompatibilityDetails() async {
    try {
      // print('пуе  https://restcountries.com/v3.1/name/${widget.zodiacName}');
      // var response = await Dio()
      //     .get('https://restcountries.com/v3.1/name/${widget.zodiacName}');
      // setState(() {
      //   countryData = response.data[0];
      // });
      compatibilityInfo = {
        "aquarius": {
          "aquarius": {
            "love": 20,
            "money": 13,
            "travel": 54,
            "interests": 36,
            "work": 70,
            "compatibility": 70,
            "energy": 100,
            "sex": 50,
            "family": 62,
            "friendship": 67,
            "growth": 45,
            "development": 36,
            "communication": 37,
            "trust": 82,
            "loyalty": 67,
            "conflicts": 80,
            "ambitions": 88
          }
        }
      };
    } catch (e) {
      print('Error fetching country details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final aquariusData = compatibilityInfo?["aquarius"]?["aquarius"]!;
    if (aquariusData == null) {
      return Center(child: Text("Данные не найдены"));
    }
    print(aquariusData);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title_compatibility),
      ),
      // Text('helloWorld'.tr())),
      body: Column(
        children: <Widget>[
          _titleIcons(context),
          Expanded(
            // Добавлен Expanded для растягивания по вертикали
            child: Row(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: Sodiacs(context),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics:
                        BouncingScrollPhysics(), // Для iOS-подобной прокрутки
                    child: Column(
                      children: [
                        _circles(context, 'Любовь', 23),
                        _circles(context, 'Деньги', 444),
                        _circles(context, 'Путешествия', 55),
                        _circles(context, 'Интересы', 66),
                      ],

                      //       aquariusData.entries.map((entry) {
                      //     return _circles(context, entry.key, entry.value);
                      //   }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: Sodiacs(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _circles(BuildContext context, String key, int value) {
//  final random = Random();
  // final _randomNumber = 20 + random.nextInt(81);
  print(key);
  print(value);

  final _randomNumber = value.toDouble();
  final _randomNumberString = _randomNumber.toString() + '%';

  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          // Центрируем по горизонтали и вертикали
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              //    AppLocalizations.of(context)!.i,
              key, // Используем функцию
              style: const TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(117, 255, 252, 53), // Цвет текста
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft, // Выравнивание по левому краю
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: _buble(context, _randomNumber),
                ),
                Text(
                  _randomNumberString,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]);
}

class ChartData {
  final String category;
  final double value;
  ChartData(this.category, this.value);
}

Widget _titleIcons(BuildContext context) {
  return IntrinsicHeight(
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, top: 20),
            child: Center(
              // Центрируем по горизонтали и вертикали
              child: Image.asset(
                'images/icons/men.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Text('error load image');
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            // Центрируем по горизонтали и вертикали
            child: Image.asset(
              'images/icons/heart.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Text('error load image');
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, top: 20),
            child: Center(
              // Центрируем по горизонтали и вертикали
              child: Image.asset(
                'images/icons/woman.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Text('error load image');
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

List<InkWell> Sodiacs(BuildContext context) {
  return zodiacs.entries.map((entry) {
    return InkWell(
      onTap: () {
        // setState(() {
        //   // _selectedIndex = i;
        //   //   _tabController.animateTo(
        //   //   0); // Переключение на первую вкладку
        //   print('Тап обнаружен!');
        //   //     _saveUserChoice(i);
        // });
      },
      child: Card(
        color: Colors.white, // Полупрозрачный белый цвет
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              entry.value['img'],
              width: 50,
              height: 50,
            ),
            SizedBox(height: 12),
            Text(
              // entry.value['name'],
              _getLocalizedZodiacName(context, entry.value['name']),
              //   translate(entry.value['name'], context),
              //   AppLocalizations.of(context)!.helloWorld,

              style: const TextStyle(fontSize: 12, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }).toList();
}

Widget _buble(BuildContext context, double _randomNumber) {
  return SfCircularChart(
    series: <CircularSeries>[
      RadialBarSeries<ChartData, String>(
          dataSource: [
            ChartData('Задача 1', _randomNumber),
          ],
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          // Настройка внешнего вида
          trackBorderWidth: 0, // Толщина границы фоновой дорожки
          trackOpacity: 0.2,
          trackColor: Colors.grey, // Цвет фоновой дорожки
          cornerStyle: CornerStyle.bothCurve,
          maximumValue: 100,
          radius: '100%',
          innerRadius: '70%', // Внутренний радиус (делает круг тонким)
          gap: '55%',
          pointColorMapper: (ChartData data, _) {
            if (data.value < 50) return Colors.red;
            if (data.value < 75) return Colors.orange;
            return Colors.green;
          }),
    ],
  );
}

String _getLocalizedZodiacName(BuildContext context, String key) {
  final localizations = AppLocalizations.of(context)!;
  final Map<String, String> zodiacTranslations = {
    'aquarius': localizations.aquarius,
    'aries': localizations.aries,
    'cancer': localizations.cancer,
    'capricorn': localizations.capricorn,
    'gemini': localizations.gemini,
    'leo': localizations.leo,
    'libra': localizations.libra,
    'pisces': localizations.pisces,
    'sagittarius': localizations.sagittarius,
    'scorpio': localizations.scorpio,
    'taurus': localizations.taurus,
    'virgo': localizations.virgo,
  };
  return zodiacTranslations[key] ??
      key; // Если ключ не найден, возвращаем сам key
}
