import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'zodiac_data.dart';
import 'ZodiacCarousel.dart';
import '../getBottomAppBar.dart';
import '../advertising.dart';
import 'TabContentBuilder.dart';
import './TitleWidget.dart';

import "../compatibility/localizedZodiacName.dart";

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
      print('send server ');
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
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Индикатор загрузки
        ),
      );
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
    final localizationHelper = LocalizationHelper(context);

    if (widget.countryData == null || widget.countryData!.isEmpty) {
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
        // title: _title(context, _selectedIndex),
        title: TitleWidget(context, 'aquarius').build(),
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
