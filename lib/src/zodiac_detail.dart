import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'zodiac_data.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;

class ZodiacDetail extends StatefulWidget {
  final String zodiacName;
  // final Map<String, dynamic> zodiacs;

  ZodiacDetail({
    required this.zodiacName,
    //required this.zodiacs
  });

  @override
  _ZodiacDetailPageState createState() => _ZodiacDetailPageState();
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
        'data': {
          'text':
              'Сегодняшний день для вас будет наполнен глубокими эмоциями и интуитивными озарениями. Вы почувствуете, как ваша внутренняя сила набирает обороты, и это поможет вам справиться с любыми трудностями. Однако будьте осторожны: ваша интенсивность может вызывать напряжение в отношениях с окружающими. Постарайтесь не поддаваться желанию контролировать всё и всех вокруг.                  Утром вы можете почувствовать легкое беспокойство или тревогу. Это связано с тем, что ваше подсознание активно работает, обрабатывая информацию, которую вы получили в последние дни. Не игнорируйте свои сны или внезапные мысли — они могут подсказать вам важные решения. Запишите свои идеи, чтобы не упустить их.                  В первой половине дня звезды советуют сосредоточиться на работе или важных проектах. Ваша решительность и умение видеть суть вещей помогут вам добиться успеха. Если вы столкнетесь с сопротивлением, не идите напролом — используйте дипломатию и хитрость. Скорпионы умеют добиваться своего, не привлекая лишнего внимания.                  В личной жизни сегодня возможны как яркие моменты, так и небольшие размолвки. Если вы состоите в отношениях, постарайтесь быть более открытым и честным со своим партнером. Ваша скрытность может вызывать недопонимание. Если вы одиноки, не исключено, что сегодня вы встретите человека, который произведет на вас сильное впечатление. Однако не спешите раскрывать все карты — дайте себе время понять, что это за личность.          Финансово день будет стабильным, но не стоит рисковать крупными суммами. Если вы давно планировали сделать важную покупку, сегодня подходящий день для этого. Однако избегайте импульсивных трат — они могут оказаться необдуманными.                  Здоровье сегодня требует внимания. Вы можете чувствовать усталость или напряжение, особенно если в последнее время много работали. Постарайтесь выделить время для отдыха и расслабления. Медитация или прогулка на свежем воздухе помогут восстановить энергию.                  Вечером вы почувствуете потребность в уединении. Это нормально — Скорпионы часто нуждаются в том, чтобы побыть наедине с собой. Используйте это время для того, чтобы привести мысли в порядок и зарядиться энергией. Если вы чувствуете, что эмоции переполняют вас, попробуйте выразить их через творчество — напишите, нарисуйте или просто помечтайте. Сегодняшний день подходит для того, чтобы отпустить старые обиды и переживания. Вы можете почувствовать, что готовы к новому этапу в жизни. Доверьтесь своей интуиции — она вас не подведет. Помните, что ваша сила — в умении трансформировать трудности в возможности.'
        }
      };
    } catch (e) {
      print('Error fetching country details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZodiacScreen();
  }
}

class ZodiacScreen extends StatefulWidget {
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
        title: _title(_selectedIndex),
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
                              decoration: BoxDecoration(color: Colors.amber),
                              child: Text(
                                'text $i',
                                style: TextStyle(fontSize: 16.0),
                              )));
                    },
                  );
                }).toList(),
                options: carousel.CarouselOptions(
                  height: 60,

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
            _currentZodiac(_selectedIndex),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Сегодня'),
                Tab(text: 'Завтра'),
                Tab(text: 'Неделя'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                // physics: AlwaysScrollableScrollPhysics(),
                physics: BouncingScrollPhysics(),
                children: [
                  _buildTabContent('Сегодня', _selectedIndex),
                  _buildTabContent('Завтра', _selectedIndex),
                  _buildTabContent('Неделя', _selectedIndex),
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
Widget _buildTabContent(String period, String zodiac) {
  return Center(
    child: Text('$period: $zodiac'),
  );
}

Widget _currentZodiac(String zodiac) {
  print('новый знак $zodiac');
  return Center(
    child: Text(': $zodiac'),
  );
}

Widget _title(String zodiac) {
  return Center(
    child: Text(': $zodiac'),
  );
}
