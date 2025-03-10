import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../compatibility/localizedZodiacName.dart';
import '../../constants/app_colors.dart';

class TitleWidget {
  final BuildContext context;
  final String key;

  TitleWidget(this.context, this.key);

  Widget build() {
    final localizationHelper = LocalizationHelper(context);
    String zodiac = localizationHelper.localizedZodiacName(key);
    String titleChineseHoroscope =
        AppLocalizations.of(context)!.title_chinese_horoscope;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0), // Отступ слева
      child: Align(
        alignment: Alignment.centerLeft, // Выравнивание по левому краю
        child: Text(
          '$titleChineseHoroscope $zodiac',
          style: const TextStyle(
            fontSize: 20, // Размер текста
            // fontWeight: FontWeight.bold, // Жирный шрифт (если нужно)
            color: AppColors.onPrimary, // Цвет текста
            fontStyle: FontStyle.normal, // Курсив
          ),
        ),
      ),
    );
  }
}
