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

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

String localizedZodiacName(BuildContext context, String key) {
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
  // Словарь для перевода дополнительных ключей
  final Map<String, String> additionalTranslations = {
    "love": localizations.love,
    "money": localizations.money,
    "travel": localizations.travel,
    "interests": localizations.interests,
    "work": localizations.work,
    "compatibility": localizations.compatibility,
    "energy": localizations.energy,
    "sex": localizations.sex,
    "family": localizations.family,
    "friendship": localizations.friendship,
    "development": localizations.development,
    "communication": localizations.communication,
    "trust": localizations.trust,
    "loyalty": localizations.loyalty,
    "conflicts": localizations.conflicts,
    "ambitions": localizations.ambitions,
  };

  // Объединяем оба словаря
  final Map<String, String> allTranslations = {
    ...zodiacTranslations,
    ...additionalTranslations,
  };
  return allTranslations[key] ?? key; // Если ключ не найден, возвращаем сам key
}
