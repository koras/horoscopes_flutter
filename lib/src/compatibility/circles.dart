import 'package:flutter/material.dart';
import '../country_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Добавьте этот импорт
import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';
import '../zodiac/zodiac_data.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Импортируем пакет flutter_svg
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:collection/collection.dart'; // Для firstWhereOrNull
import 'dart:math';

import '../../constants/app_colors.dart';
import '../getBottomAppBar.dart';
import './titleIcons.dart';
import './localizedZodiacName.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

Widget circles(BuildContext context, String key, int value) {
  final _randomNumber = value.toDouble();
  final _randomNumberString = _randomNumber.toString() + '%';

  return Stack(
    alignment: Alignment.topCenter,
    children: [
      Container(
        //  color: Colors.amber,
        width: double.infinity,
        //    width: 150,
        height: 160,
        child: _buble(context, _randomNumber),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Text(
          _randomNumberString,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 110),
        child: Text(
          //    AppLocalizations.of(context)!.i,
          localizedZodiacName(context, key),
          style: const TextStyle(
            fontSize: 10.0,
            color: AppColors.onPrimary, // Цвет текста
          ),
        ),
      ),
    ],
  );
}

Widget _buble(BuildContext context, double _randomNumber) {
  return Transform.translate(
    offset: Offset(0, -20), // Смещаем вверх на 50 пикселей
    child: SfCircularChart(
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
          },
        ),
      ],
    ),
  );
}

class ChartData {
  final String category;
  final double value;
  ChartData(this.category, this.value);
}
