import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'zodiac_data.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;

class ZodiacDetail extends StatefulWidget {
  final String zodiacName;
  // final Map<String, dynamic> zodiacs;

  @override
  _ZodiacDetailPageState createState() => _ZodiacDetailPageState();

  ZodiacDetail({
    required this.zodiacName,
    //required this.zodiacs
  });
}

class _ZodiacDetailPageState extends State<ZodiacDetail> {
  Map<String, dynamic>? countryData;

  @override
  void initState() {
    super.initState();
    fetchCountryDetails();
  }

  Future<void> fetchCountryDetails() async {
    try {
      // print('пуе  https://restcountries.com/v3.1/name/${widget.zodiacName}');
      // var response = await Dio()
      //     .get('https://restcountries.com/v3.1/name/${widget.zodiacName}');
      // setState(() {
      //   countryData = response.data[0];
      // });
      countryData = {
        'aquarius': {
          'today':
              'День для вас будет наполнен глубокими эмоциями и интуитивными озарениями. Вы почувствуете, как ваша внутренняя сила набирает обороты, и это поможет вам справиться с любыми трудностями. Однако будьте осторожны: ваша интенсивность может вызывать напряжение в отношениях с окружающими. Постарайтесь не поддаваться желанию контролировать всё и всех вокруг.                  Утром вы можете почувствовать легкое беспокойство или тревогу. Это связано с тем, что ваше подсознание активно работает, обрабатывая информацию, которую вы получили в последние дни. Не игнорируйте свои сны или внезапные мысли — они могут подсказать вам важные решения. Запишите свои идеи, чтобы не упустить их.                  В первой половине дня звезды советуют сосредоточиться на работе или важных проектах. Ваша решительность и умение видеть суть вещей помогут вам добиться успеха. Если вы столкнетесь с сопротивлением, не идите напролом — используйте дипломатию и хитрость. Скорпионы умеют добиваться своего, не привлекая лишнего внимания.                  В личной жизни сегодня возможны как яркие моменты, так и небольшие размолвки. Если вы состоите в отношениях, постарайтесь быть более открытым и честным со своим партнером. Ваша скрытность может вызывать недопонимание. Если вы одиноки, не исключено, что сегодня вы встретите человека, который произведет на вас сильное впечатление. Однако не спешите раскрывать все карты — дайте себе время понять, что это за личность.          Финансово день будет стабильным, но не стоит рисковать крупными суммами. Если вы давно планировали сделать важную покупку, сегодня подходящий день для этого. Однако избегайте импульсивных трат — они могут оказаться необдуманными.                  Здоровье сегодня требует внимания. Вы можете чувствовать усталость или напряжение, особенно если в последнее время много работали. Постарайтесь выделить время для отдыха и расслабления. Медитация или прогулка на свежем воздухе помогут восстановить энергию.                  Вечером вы почувствуете потребность в уединении. Это нормально — Скорпионы часто нуждаются в том, чтобы побыть наедине с собой. Используйте это время для того, чтобы привести мысли в порядок и зарядиться энергией. Если вы чувствуете, что эмоции переполняют вас, попробуйте выразить их через творчество — напишите, нарисуйте или просто помечтайте. Сегодняшний день подходит для того, чтобы отпустить старые обиды и переживания. Вы можете почувствовать, что готовы к новому этапу в жизни. Доверьтесь своей интуиции — она вас не подведет. Помните, что ваша сила — в умении трансформировать трудности в возможности.',
          'tomorrow':
              'Звезды советуют быть внимательными к деталям — они могут сыграть ключевую роль.Не бойтесь проявлять инициативу, но избегайте излишней спешки.В отношениях возможны небольшие разногласия — проявите терпение и понимание.Финансовая удача на вашей стороне, но избегайте необдуманных трат.День подходит для планирования и постановки долгосрочных целей.Вас ждут неожиданные встречи, которые могут повлиять на ваше будущее.Звезды рекомендуют уделить время здоровью — небольшая забота о себе принесет пользу.Творческие идеи будут приходить легко — записывайте их, чтобы не упустить.Сегодняшний день благоприятен для обучения и саморазвития.Вечером постарайтесь расслабиться и насладиться моментом — завтра будет новый день! ',
          'weekly':
              'Не бойтесь выходить из зоны комфорта — это откроет перед вами новые горизонты. Финансовая удача на вашей стороне, но избегайте импульсивных решений. В отношениях важно проявлять чуткость и понимание. День подходит для планирования и постановки целей. Ваша энергия на высоте, используйте её для завершения давних дел. Не забывайте отдыхать, чтобы сохранить баланс. Доверяйте своей интуиции — она вас не подведёт. Сегодняшний день полон возможностей, главное — действовать смело и уверенно!',
        }
      };
    } catch (e) {
      print('Error fetching country details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZodiacScreen(countryData: countryData);
  }
}

class ZodiacScreen extends StatefulWidget {
  final Map<String, dynamic>? countryData; // Добавляем countryData как парамет

  ZodiacScreen({this.countryData}); // Конструктор
  @override
  _ZodiacScreenState createState() => _ZodiacScreenState();
}

class _ZodiacScreenState extends State<ZodiacScreen>
    with SingleTickerProviderStateMixin {
  String _selectedIndex = ''; // Индекс выбранного элемента в слайдере

  Future<void> _saveUserChoice(String choice) async {
    print('сохранили $choice ');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_choice', choice);
  }

  /// Загрузка сохраненного выбора
  Future<void> _loadUserChoice() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedChoice = prefs.getString('user_choice');

    if (savedChoice != null) {
      setState(() {
        _selectedIndex = savedChoice;
      });
    }
  }

  int _currentIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserChoice();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

// https://pub.dev/packages/carousel_slider
  @override
  Widget build(BuildContext context) {
    List<String> zodiacKeys = zodiacs.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: _title(context, _selectedIndex),
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 55, 55, 56),
                Color.fromARGB(255, 55, 37, 58)
              ], // Градиент для красоты
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            carousel.CarouselSlider(
                items: zodiacKeys.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = i;
                              _tabController.animateTo(
                                  0); // Переключение на первую вкладку
                              print('Тап обнаружен!' + i);
                              _saveUserChoice(i);
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 29, 29, 28)),
                            child: Column(
                              children: [
                                Image.asset(
                                  zodiacs[i]['img'],
                                  //   items[index]['image']!,
                                  //   width: double.infinity,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      //    AppLocalizations.of(context)!.i,
                                      _getLocalizedZodiacName(
                                          context, i), // Используем функцию
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Color.fromARGB(
                                            117, 255, 217, 0), // Цвет текста
                                      ),
                                    )),
                              ],
                            ),
                          ));
                    },
                  );
                }).toList(),
                options: carousel.CarouselOptions(
                  height: 100,

                  aspectRatio: 1.0,
                  viewportFraction: 1 /
                      5.5, // Доля видимой области, которую занимает каждый слайд. Например, 0.8 означает, что 80% ширины экрана будет занято слайдом.
                  initialPage: 0, //  Индекс начального слайда.
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay:
                      false, //  Включает автоматическую прокрутку слайдов.
                  enlargeCenterPage: false,
                  enlargeFactor: 0.3,
                  padEnds: false,
                  // onPageChanged: callbackFunction,// Коллбэк, который вызывается при изменении текущего слайда.
                  scrollDirection: Axis.horizontal,
                )),
            //  _currentZodiac(context, _selectedIndex),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: AppLocalizations.of(context)!.today),
                Tab(text: AppLocalizations.of(context)!.tomorrow),
                Tab(text: AppLocalizations.of(context)!.weekly),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                // physics: AlwaysScrollableScrollPhysics(),
                physics: BouncingScrollPhysics(),
                children: [
                  _buildTabContent('today', _selectedIndex, widget.countryData),
                  _buildTabContent(
                      'tomorrow', _selectedIndex, widget.countryData),
                  _buildTabContent(
                      'weekly', _selectedIndex, widget.countryData),
                ],
              ),
            ),
          ]),
    );
  }
}

/**
 * Основной контент
 */
Widget _buildTabContent(
    String period, String zodiac, Map<String, dynamic>? countryData) {
//'data': {          'aquarius': {      'today'

  // if (countryData == null || countryData[zodiac] == null) {
  //   return Center(child: Text('Данные не загружены'));
  // }

  if (countryData == null || countryData['aquarius'][period] == null) {
    return Center(child: Text('Данные не загружены'));
  }

  // Получаем данные для текущего знака зодиака
  final zodiacData = countryData['aquarius'][period];
  if (zodiacData == null) {
    return Center(child: Text('Данные для $zodiac не найдены'));
  }

  // Получаем текст для текущего периода (today, tomorrow, weekly)
  final text = countryData['aquarius'][period];
  if (text == null) {
    return Center(child: Text('Данные для периода "$period" не найдены'));
  }

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    ),
  );
}

Widget _currentZodiac(BuildContext context, String zodiac) {
  // print('новый знак $zodiac');
  // return Center(
  //   child: Text(': $zodiac'),
  // );

  return Card(
    margin: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        // Картинка (20% ширины)
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  //zodiacs[i]['img'],
                  zodiacs[zodiac]['img']!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Текст (80% ширины)
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              // items[index]['name']!

              zodiacs[zodiac]['name']!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
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
          fontWeight: FontWeight.bold, // Жирный шрифт
          color: const Color.fromARGB(255, 255, 217, 0), // Цвет текста
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
