import 'package:flutter/material.dart';
import '../country_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';
import '../zodiac/zodiac_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:collection/collection.dart'; // Для firstWhereOrNull

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Compatibility extends StatefulWidget {
  @override
  _CompatibilityState createState() => _CompatibilityState();
}

class _CompatibilityState extends State<Compatibility> {
  // List<dynamic> countries = [];
//  List<dynamic> filteredCountries = [];
//  TextEditingController searchController = TextEditingController();

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
                  child: Column(
                    children: [
                      _circles(context, 'Любовь'),
                      _circles(context, 'Деньги'),
                      _circles(context, 'Путешествия'),
                      _circles(context, 'Интересы'),
                    ],
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

Widget _circles(BuildContext context, String text) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            //    AppLocalizations.of(context)!.i,
            text, // Используем функцию
            style: const TextStyle(
              fontSize: 14.0,
              color: Color.fromARGB(117, 255, 217, 0), // Цвет текста
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
                  child: _buble(context),
                ),
                const Text(
                  '75%',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              entry.value['img'],
              width: 20,
              height: 20,
            ),
            SizedBox(height: 8),
            Text(
              entry.value['name'],
              //  translate(entry.value['name'], context),
              //   AppLocalizations.of(context)!.helloWorld,

              style: TextStyle(fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }).toList();
}

Widget _buble(BuildContext context) {
  return SfCircularChart(
    series: <CircularSeries>[
      RadialBarSeries<ChartData, String>(
          dataSource: [
            ChartData('Задача 1', 75),
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
          innerRadius: '90%', // Внутренний радиус (делает круг тонким)
          gap: '2%',
          pointColorMapper: (ChartData data, _) {
            if (data.value < 50) return Colors.red;
            if (data.value < 75) return Colors.orange;
            return Colors.green;
          }),
    ],
  );
}
