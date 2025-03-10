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

  @override
  void initState() {
    super.initState();
    fetchCountryDetails();
  }

  // String jsonString =
  //     '{"daily": {"08.03":{"aquarius":{"chart":{"chart_love":97,"chart_money":76,"chart_like":97},"text":{"ru":"Ну,тыступайтеперьвсвою—очередь,вопросЧичиков.—Мынапишем,чтоонивсамомделе.","en":"Bill!catchholdofitsmouthagain,andthat\'sverylikehavingagameofcroquetshewaspeering."},"favorite_numbers":[3,32,57,63,72]},"aries":{"chart":{"chart_love":81,"chart_money":14,"chart_like":98},"text":{"ru":"Чичиковкстоявшей—бабе.—Есть.—Схреномисострахомпосмотрелнанего—особенной.","en":"I?Ah,THAT\'Sthegreathall,withthewords\'DRINKME,\'butneverthelesssheuncorkeditandput."},"favorite_numbers":[4,8,71,85,86]},"cancer":{"chart":{"chart_love":56,"chart_money":44,"chart_like":16},"text":{"ru":"Попадалисьвытянутыепошнуркудеревни,постройкоюпохожиенастарыескладенныедрова,покрытые.","en":"I\'dbeenthewhiting,\'saidAlice,andshetriedtogetthroughwasmorethanthat,ifyoulike!\'."},"favorite_numbers":[17,30,43,58,80]},"capricorn":{"chart":{"chart_love":71,"chart_money":82,"chart_like":71},"text":{"ru":"Всемуестьграницы,—сказалМанилов.—Совершеннаяправда,—народилось,дачтовдомеестьмного.","en":"Shewentonagain:\'Twenty-fourhours,ITHINK;orisittwelve?I--\'\'Oh,don\'ttalkabout."},"favorite_numbers":[12,41,55,82,96]},"gemini":{"chart":{"chart_love":57,"chart_money":91,"chart_like":54},"text":{"ru":"Пройдет,пройдет,матушка.Наэтонечегоглядеть.—Дайбог,чтобыпрошло.Я-тосмазываласвиным.","en":"Alicehadgotitsheadimpatiently,andwalkedoff;theDormousefollowedhim:theMarchHare."},"favorite_numbers":[11,25,29,64,69]},"leo":{"chart":{"chart_love":14,"chart_money":37,"chart_like":67},"text":{"ru":"Вотменьшой,Алкид,тотнетакбыстр,аэтотчертзнаетчтодали,трехаршинсвершкомростом!.","en":"Andyetyouincessantlystandonyourhead--Doyouthinkyoucouldseethis,asshecameinwith."},"favorite_numbers":[3,8,55,62,63]},"libra":{"chart":{"chart_love":45,"chart_money":19,"chart_like":12},"text":{"ru":"Казаньнедоедет»,—отвечалзять.—Ая,брат,—попользоватьсябынасчетклубнички!»Одних.","en":"BESTbutter,\'theMarchHare.Alicesighedwearily.\'Ithinkyoumightdoverywelltosay\'Ionce."},"favorite_numbers":[6,44,47,61,62]},"pisces":{"chart":{"chart_love":79,"chart_money":30,"chart_like":19},"text":{"ru":"ПотомуНоздреввелелпринестибутылкумадеры,лучшекоторойнепивалсамфельдмаршал.Мадера.","en":"Caterpillar.Herewasanotherpuzzlingquestion;andashespoke,andadded\'Itisn\'tabird,\'."},"favorite_numbers":[5,29,81,89,100]},"sagittarius":{"chart":{"chart_love":67,"chart_money":84,"chart_like":3},"text":{"ru":"Собакевичу.«Ачтож,матушка,порукам,чтоли?тыпосудисам:зачемжесрединедумающих.","en":"Two.Twobeganinalow,hurriedtone.HelookedatAlice,asshecouldn\'tanswereitherquestion."},"favorite_numbers":[2,10,13,57,85]},"scorpio":{"chart":{"chart_love":92,"chart_money":83,"chart_like":30},"text":{"ru":"Манилова,которыебылиещетолькостатскиесоветники,сказалдажеошибкоюдвараза:«ваше.","en":"Queen.Aninvitationforthemomenthowlargeshehadnotthesmallestideahowconfusingitis."},"favorite_numbers":[31,56,66,73,75]},"taurus":{"chart":{"chart_love":93,"chart_money":74,"chart_like":33},"text":{"ru":"Вонкакпотащился!конекпристяжнойнедурен,я—вижу,сочинитель!—Нет,большедвухрублейяне.","en":"I\'lltellhim--itwasforbringingthecooktillhiseyesweregettingextremelysmallfora."},"favorite_numbers":[11,20,54,89,97]},"virgo":{"chart":{"chart_love":34,"chart_money":89,"chart_like":49},"text":{"ru":"Пожалуй,почемужене«удовлетворить!Вотоно,внутреннеерасположение:всамойкомнатетяжелый.","en":"MarchHareinterruptedinaminuteortwoshewalkedoninthesewords:\'Yes,wewenttothelaw."},"favorite_numbers":[7,38,48,82,99]}}}}';

  Future<void> fetchCountryDetails() async {
    final String url = 'https://horoscope.staers.ru/api/horoscope/info';

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedData = response.data;
        if (decodedData.containsKey('daily')) {
          setState(() {
            print("ставим данные ---------------------- ");
            print("ставим данные ---------------------- ");

            dataDao = decodedData['daily'];
          });
        } else {
          setState(() {
            dataDao =
                {}; // Инициализируем пустой картой, если ключ 'daily' отсутствует
          });
          print('Data does not contain "daily" key');
        }
      } else {
        setState(() {
          dataDao = {}; // Инициализируем пустой картой в случае ошибки
        });
        print('Failed to load data: ${response.statusCode}');
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
    print('countryData   =  =  = ');

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
      print('Данные не содержат ключа "daily"');
      print('Данные не содержат ключа "daily"');
      print('Данные не содержат ключа "daily"');
      print('Данные не содержат ключа "daily"');
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
