import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'zodiac_data.dart';
import 'package:intl/intl.dart';
import '../../constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'HoroskopeResponse.dart';

import 'package:flutter/material.dart';

class TabContentBuilder {
  final String period;
  final String zodiac;
  // final Map<String, dynamic>? countryData;
  final dataForDate;
  final String locale; // Передаем текущую локаль

  TabContentBuilder({
    required this.period,
    required this.dataForDate,
    required this.zodiac,
    required this.locale,
    // this.countryData,
  });

  Widget build() {
    final zodiacData = ZodiacData.fromJson(dataForDate[zodiac]);
    // Получаем текст на русском и английском
    final textRu = zodiacData.text.ru;
    final textEn = zodiacData.text.en;

    print(zodiacData.favoriteNumbers);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getTitle('Гороскоп'),
        getText(locale, zodiacData),
        getTitle('Счастливые числа'),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Равномерное распределение

          children: zodiacData.favoriteNumbers.map((number) {
            return Container(
              margin: EdgeInsets.all(10.0), // Отступы между кругами
              child: CircleWithNumber(number: number),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CircleWithNumber extends StatelessWidget {
  final int number;
  CircleWithNumber({required this.number});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0, // Диаметр круга
      height: 70.0, // Диаметр круга
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Делаем контейнер круглым
        color: AppColors.backgroundActive, // Цвет круга
        border: Border.all(
          color: AppColors.backgroundActiveCircle, // Цвет ободка
          width: 3.0, // Толщина ободка
        ),
      ),
      child: Center(
        child: Text(
          number.toString(), // Число внутри круга
          style: TextStyle(
            color: AppColors.onPrimary, // Цвет текста
            fontSize: 20.0, // Размер шрифта
            fontWeight: FontWeight.bold, // Жирный шрифт
          ),
        ),
      ),
    );
  }
}

Widget getText(locale, zodiacData) {
  String text;
  if (locale == 'ru') {
    text = zodiacData.text.ru; // Текст на русском
  } else {
    text = zodiacData.text.en; // Текст на английском (по умолчанию)
  }
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 18),
          )
          // _bar(text),
        ],
      ),
    ),
  );
}

Widget getTitle(String nameTitle) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20.0, top: 25.0),
    child: SingleChildScrollView(
      child: Text(
        nameTitle,
        style: TextStyle(
          color: AppColors.onMenuButtonActive, // Цвет текста
          fontSize: 25.0, // Размер шрифта
          fontWeight: FontWeight.bold, // Жирный шрифт
        ),
      ),
    ),
  );
}
