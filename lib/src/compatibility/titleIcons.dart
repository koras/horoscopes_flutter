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

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

Widget titleIcons(BuildContext context) {
  return IntrinsicHeight(
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, top: 20),
            child: Center(
              // Центрируем по горизонтали и вертикали
              child: Container(
                width: 80, // Ширина контейнера
                height: 80, // Высота контейнера
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Делаем контейнер круглым
                  border: Border.all(
                    color: AppColors.backgroundActive,
//                        const Color.fromARGB(255, 216, 54, 54), // Цвет кромки
                    width: 5, // Толщина кромки
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'images/icons/men.jpg',
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
          ),
        ),
        Expanded(
          child: Center(
            // Центрируем по горизонтали и вертикали
            child: Image.asset(
              'images/icons/heart.png',
              width: 60,
              height: 60,
              color: AppColors.oheart,
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
              child: Container(
                width: 80, // Ширина контейнера
                height: 80, // Высота контейнера
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Делаем контейнер круглым
                  border: Border.all(
                    color: AppColors.backgroundActive,
//                        const Color.fromARGB(255, 216, 54, 54), // Цвет кромки
                    width: 5, // Толщина кромки
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'images/icons/woman.jpg',
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
          ),
        ),
      ],
    ),
  );
}
