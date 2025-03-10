import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'zodiac_data.dart';
import 'package:intl/intl.dart';
import '../../constants/app_colors.dart';

import 'ZodiacCarousel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../getBottomAppBar.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;

import '../advertising.dart';
import 'FormattedDateWidget.dart';
import 'WeekDatesWidget.dart';
import 'dart:convert';

import 'HoroskopeResponse.dart';

import 'TabContentBuilder.dart';

class ZodiacDetail extends StatefulWidget {
  @override
  _ZodiacDetailPageState createState() => _ZodiacDetailPageState();
}

class _ZodiacDetailPageState extends State<ZodiacDetail> {
  Map<String, dynamic>? dataDao;
  final String url = 'https://horoscope.staers.ru/api/horoscope/info';

  @override
  void initState() {
    super.initState();
    fetchCountryDetails();
  }

  Future<void> fetchCountryDetails() async {
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedData = response.data;
        if (decodedData.containsKey('daily')) {
          setState(() {
            dataDao = decodedData['daily'];
          });
        }
      }
    } on DioException catch (e) {
      setState(() {
        dataDao = {}; // Инициализируем пустой картой в случае исключения
      });
      print('Dio error: $e');
    } catch (e) {
      setState(() {
        dataDao =
            {}; // Инициализируем пустой картой в случае неожиданной ошибки
      });
      print('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dataDao == null) {
      return Center(child: Text('1111'));
    }
    return ZodiacScreen(countryData: dataDao!);
  }
}

class ZodiacScreen extends StatefulWidget {
  final Map<String, dynamic>? countryData;

  ZodiacScreen({this.countryData}); // Конструктор
  @override
  _ZodiacScreenState createState() => _ZodiacScreenState();
}

class _ZodiacScreenState extends State<ZodiacScreen>
    with SingleTickerProviderStateMixin {
  String _selectedIndex = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    if (widget.countryData != null && widget.countryData!.isNotEmpty) {
      _tabController =
          TabController(length: widget.countryData!.length, vsync: this);
    }

    _loadUserChoice();
  }

  Future<void> _saveUserChoice(String choice) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_choice', choice);
  }

  Future<void> _loadUserChoice() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedChoice = prefs.getString('user_choice');
    if (savedChoice != null) {
      setState(() {
        _selectedIndex = savedChoice;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.countryData == null || widget.countryData!.isEmpty) {
      print(widget.countryData);
      return Center(child: Text('Данные не содержат ключа "daily"'));
    }
    final dailyData = widget.countryData as Map<String, dynamic>;
    if (dailyData.isEmpty) {
      return Center(child: Text('Нет данных для отображения'));
    }

    List<String> zodiacKeys = zodiacs.keys.toList();
    final locale = Localizations.localeOf(context);
    final currentLanguage = locale.languageCode;

    final tabsTitle = dailyData.keys.map((date) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              date,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 4),
        ],
      );
    }).toList();

    final tabViews = dailyData.entries.map<Widget>((entry) {
      final date = entry.key;
      final dataForDate = entry.value;

      if (!dataForDate.containsKey(_selectedIndex)) {
        return Center(child: Text('Нет данных для выбранного знака зодиака'));
      }

      return TabContentBuilder(
        period: date,
        dataForDate: dataForDate,
        zodiac: _selectedIndex,
        locale: currentLanguage,
      ).build();
    }).toList();

    //return Text('1212121');
    return Scaffold(
      appBar: AppBar(
        title: _title(context, _selectedIndex),
        centerTitle: false,
      ),
      bottomNavigationBar: getBottomAppBar(context, 'zodiac'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ZodiacCarousel(
              zodiacKeys: zodiacKeys,
              selectedIndex: _selectedIndex,
              onTap: (i) {
                setState(() {
                  _selectedIndex = i;
                });
              },
              tabController: _tabController,
              saveUserChoice: _saveUserChoice,
              getLocalizedZodiacName: _getLocalizedZodiacName,
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: Colors.blue),
              insets: EdgeInsets.zero,
            ),
            tabs: tabsTitle,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: BouncingScrollPhysics(),
              children: tabViews,
            ),
          ),
          advertising(context),
        ],
      ),
    );
  }
}

Widget _title(BuildContext context, String key) {
  String zodiac = _getLocalizedZodiacName(context, key);
  String title_chinese_horoscope =
      AppLocalizations.of(context)!.title_chinese_horoscope;
  return Padding(
    padding: const EdgeInsets.only(left: 16.0), // Отступ слева
    child: Align(
      alignment: Alignment.centerLeft, // Выравнивание по левому краю
      child: Text(
        '$title_chinese_horoscope $zodiac',
        style: const TextStyle(
          fontSize: 20, // Размер текста
          //   fontWeight: FontWeight.bold, // Жирный шрифт
          color: AppColors.onPrimary, // Цвет текста
          fontStyle: FontStyle.normal, // Курсив
        ),
      ),
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
  return zodiacTranslations[key] ??
      key; // Если ключ не найден, возвращаем сам key
}
