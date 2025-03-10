import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationHelper {
  final BuildContext context;

  LocalizationHelper(this.context);

  String localizedZodiacName(String key) {
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
    return allTranslations[key] ??
        key; // Если ключ не найден, возвращаем сам key
  }
}
