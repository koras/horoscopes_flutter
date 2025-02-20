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
import '../advertising.dart';
import './compatibilityData.dart';

import './titleIcons.dart';
import './circles.dart';
import './localizedZodiacName.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Compatibility extends StatefulWidget {
  @override
  _CompatibilityState createState() => _CompatibilityState();
}

class _CompatibilityState extends State<Compatibility> {
  Map<String, dynamic>? compatibilityInfo;

  late Map<String, String> compatibilityChoose = {
    'woman': 'aquarius',
    'man': 'aquarius',
  };

  Future<void> _saveUserChoice(String gender, String sodiac) async {
    print('сохранили $sodiac ');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_choice_$gender', sodiac);
  }

  Future<void> _saveGenderGender(Map<String, dynamic> info) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(info);
    await prefs.setString('Compatibility_info', jsonString);
  }

  Future<void> _loadGenderGender() async {
    final prefs = await SharedPreferences.getInstance();
    // Получаем JSON-строку
    String? jsonString = prefs.getString('Compatibility_info');

    if (jsonString != null) {
      // Преобразуем JSON-строку обратно в Map
      compatibilityInfo = jsonDecode(jsonString);
      //   return info;
    } else {
      return null; // Если данных нет
    }
  }

  /// Загрузка сохраненного выбора
  Future<void> _loadUserChoice() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedChoiceMan = prefs.getString('user_choice_man');
    String? savedChoiceWoman = prefs.getString('user_choice_woman');

    String? compatibility_info = prefs.getString('Compatibility_info');

    if (savedChoiceMan != null) {
      setState(() {
        compatibilityChoose['man'] = savedChoiceMan;
      });
    }
    if (savedChoiceWoman != null) {
      setState(() {
        compatibilityChoose['woman'] = savedChoiceWoman;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCompatibilityDetails();
  }

  Future<void> fetchCompatibilityDetails() async {
    try {
      if (compatibilityInfo == null) {
        // var response = await Dio().get('https://moon.local/api/compatibility');
        // var response = compatibilityData;

        // if (response.statusCode == 200) {
        // Извлекаем данные из ответа
        //   Map<String, dynamic> data = response.data;
        setState(() {
          compatibilityInfo = compatibilityData;
        });
        //   } else {
        // Обработка ошибки, если статус код не 200
        //  print('Ошибка при получении данных: ${response.statusCode}');
        //   }
      }
    } catch (e) {
      print('Error fetching country details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final man = compatibilityChoose['man'];
    final woman = compatibilityChoose['woman'];
    final aquariusData = compatibilityInfo?[man][woman];
    if (aquariusData == null) {
      return Center(child: Text("Данные загружаются"));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title_compatibility),
      ),
      // Text('helloWorld'.tr())),
      body: Column(
        children: <Widget>[
          titleIcons(context),
          _content(context, aquariusData),
          advertising(context),
        ],
      ),
      bottomNavigationBar: getBottomAppBar(context),
    );
  }

  Widget _content(BuildContext context, aquariusData) {
    return Expanded(
      child: Row(
        children: [
          // Левый блок (27.5% ширины экрана)
          Flexible(
            flex: 280, // Примерно 27.5%
            child: GridView.count(
              crossAxisCount: 2,
              children: Sodiacs(context, "man"),
            ),
          ),
          // Центральный блок (45% ширины экрана)
          Flexible(
            flex: 440, // Примерно 45%
            child: GridView.count(
              crossAxisCount: 2,
              children: aquariusData.entries.map<Widget>((entry) {
                return circles(context, entry.key, entry.value);
              }).toList(),
            ),
          ),
          // Правый блок (27.5% ширины экрана)
          Flexible(
            flex: 280, // Примерно 27.5%
            child: GridView.count(
              crossAxisCount: 2,
              children: Sodiacs(context, "woman"),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> Sodiacs(BuildContext context, String gender) {
    return zodiacs.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.only(
            right: 5.0, left: 5.0, bottom: 0, top: 0), // Отступ сверху
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () {
              setState(() {
                String sodiac = entry.value['name'];
                print(
                  'Тап обнаружен! $sodiac $gender',
                );
                compatibilityChoose[gender] = sodiac; // Обновляем выбор
                _saveUserChoice(gender, sodiac); // Сохраняем выбор
              });
            },
            child: Container(
              width: 70,
              height: 70,
              color: compatibilityChoose[gender] == entry.value['name']
                  ? AppColors.backgroundActive
                  : AppColors.background, // Полупрозрачный белый цвет
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, bottom: 3.0), // Отступ сверху
                    child: SvgPicture.asset(
                      entry.value['img'],
                      height: 50, // Высота иконки
                      colorFilter: const ColorFilter.mode(
                        AppColors.zodiac,
                        // Новый цвет, который вы хотите применить
                        BlendMode
                            .srcIn, // Режим смешивания, который заменяет все цвета на указанный
                      ),
                    ),
                  ),
                  Text(
                    localizedZodiacName(context, entry.value['name']),
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.onPrimary),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
