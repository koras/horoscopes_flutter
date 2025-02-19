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
        var response = await Dio().get('https://moon.local/api/compatibility');
        if (response.statusCode == 200) {
          // Извлекаем данные из ответа
          Map<String, dynamic> data = response.data;
          setState(() {
            compatibilityInfo = data;
          });
        } else {
          // Обработка ошибки, если статус код не 200
          print('Ошибка при получении данных: ${response.statusCode}');
        }
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
          _titleIcons(context),
          _content(context, aquariusData),
        ],
      ),
      bottomNavigationBar: getBottomAppBar(context),
    );
  }

  Widget _content(BuildContext context, aquariusData) {
    return Expanded(
      // Добавлен Expanded для растягивания по вертикали
      child: Row(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: Sodiacs(context, "man"),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: aquariusData.entries.map<Widget>((entry) {
                return _circles(context, entry.key, entry.value);
              }).toList(),
            ),
          ),
          Expanded(
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
            right: 5.0, left: 5.0, bottom: 2.0), // Отступ сверху
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
              width: 60,
              height: 60,
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
                      height: 60, // Высота иконки
                      colorFilter: const ColorFilter.mode(
                        AppColors.zodiac,
                        // Новый цвет, который вы хотите применить
                        BlendMode
                            .srcIn, // Режим смешивания, который заменяет все цвета на указанный
                      ),
                    ),
                  ),
                  Text(
                    _getLocalizedZodiacName(context, entry.value['name']),
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

Widget _circles(BuildContext context, String key, int value) {
  final _randomNumber = value.toDouble();
  final _randomNumberString = _randomNumber.toString() + '%';

  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          // Центрируем по горизонтали и вертикали
          child: Align(
            alignment: Alignment.center, // Выравнивание по левому краю
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 120,
                  child: _buble(context, _randomNumber),
                ),
                Text(
                  _randomNumberString,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Text(
                    //    AppLocalizations.of(context)!.i,
                    _getLocalizedZodiacName(context, key),
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: AppColors.onPrimary, // Цвет текста
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]);
}

class ChartData {
  final String category;
  final double value;
  ChartData(this.category, this.value);
}

Widget _titleIcons(BuildContext context) {
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
                    color:
                        const Color.fromARGB(255, 216, 54, 54), // Цвет кромки
                    width: 2, // Толщина кромки
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
                    color:
                        const Color.fromARGB(255, 216, 54, 54), // Цвет кромки
                    width: 2, // Толщина кромки
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

Widget _buble(BuildContext context, double _randomNumber) {
  return SfCircularChart(
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
          }),
    ],
  );
}

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

String _getLocalizedZodiacName(BuildContext context, String key) {
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
