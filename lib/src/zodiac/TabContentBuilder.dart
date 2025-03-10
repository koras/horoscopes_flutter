import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'zodiac_data.dart';
import 'package:intl/intl.dart';
import '../../constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../getBottomAppBar.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;

import '../advertising.dart';
import 'FormattedDateWidget.dart';
import 'WeekDatesWidget.dart';
import 'dart:convert';

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
    //
    required this.zodiac,
    required this.locale,
    // this.countryData,
  });

  Widget build() {
    final zodiacData = ZodiacData.fromJson(dataForDate[zodiac]);
    // Получаем текст на русском и английском
    final textRu = zodiacData.text.ru;
    final textEn = zodiacData.text.en;

    print(zodiac);
    final zodiacText = ZodiacData.fromJson(dataForDate[zodiac]);

    String getLocalizedText(ZodiacData zodiacData) {
      if (locale == 'ru') {
        return zodiacData.text.ru; // Текст на русском
      } else {
        return zodiacData.text.en; // Текст на английском (по умолчанию)
      }
    }

    print(zodiacText);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textRu,
              style: TextStyle(fontSize: 16),
            )
            // _bar(text),
          ],
        ),
      ),
    );
  }
}
