import 'package:flutter/material.dart';
import './country_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Добавьте этот импорт
import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';
import './zodiac/zodiac_data.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Импортируем пакет flutter_svg
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:collection/collection.dart'; // Для firstWhereOrNull
import 'dart:math';

import 'zodiac/zodiac_detail.dart';
import '../../constants/app_colors.dart';
import './compatibility/compatibility.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

BottomAppBar getBottomAppBar(BuildContext context) {
  return BottomAppBar(
    color: AppColors.backgroundMenu, // Цвет фона BottomAppBar
    shape:
        CircularNotchedRectangle(), // Форма выреза (например, для FloatingActionButton)
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Compatibility()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.backgroundMenu, // Цвет фона
            foregroundColor: Colors.amberAccent, // Цвет текста
            overlayColor: Colors.transparent, // Убирает эффект нажатия
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'images/icons/heart-svgrepo-com.svg',
                // width: 24, // Ширина иконки
                height: 50, // Высота иконки
                color: AppColors.onMenuButton,
              ), // Путь к вашей иконке
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ZodiacDetail()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.backgroundMenu, // Цвет фона
            foregroundColor: Colors.amberAccent, // Цвет текста
            overlayColor: Colors.transparent, // Убирает эффект нажатия
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'images/icons/orbit-svgrepo-com.svg',
                // width: 24, // Ширина иконки
                height: 50, // Высота иконки
                color: AppColors.onMenuButton,
              ), // Путь к вашей иконке
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Compatibility()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.backgroundMenu, // Цвет фона
            foregroundColor: Colors.amberAccent, // Цвет текста
            overlayColor: Colors.transparent, // Убирает эффект нажатия
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'images/icons/star-svgrepo-com.svg',
                // width: 24, // Ширина иконки
                height: 52, // Высота иконки
                color: AppColors.onMenuButton,
              ), // Путь к вашей иконке
            ],
          ),
        ),
      ],
    ),
  );
}
