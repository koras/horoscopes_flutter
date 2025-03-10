import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import './localizedZodiacName.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

Widget circles(BuildContext context, String key, int value) {
  final localizationHelper = LocalizationHelper(context);
  final _randomNumber = value.toDouble();
  final _randomNumberString = _randomNumber.toString() + '%';

  return Stack(
    alignment: Alignment.topCenter,
    children: [
      Container(
        //  color: Colors.amber,
        width: double.infinity,
        //    width: 150,
        height: 150,
        child: _buble(context, _randomNumber),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          height: 150,
          child: Text(
            _randomNumberString,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Container(
          height: 150,
          child: Text(
            //    AppLocalizations.of(context)!.i,
            localizationHelper.localizedZodiacName(key),
            style: const TextStyle(
              fontSize: 10.0,
              color: AppColors.onPrimary, // Цвет текста
            ),
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
