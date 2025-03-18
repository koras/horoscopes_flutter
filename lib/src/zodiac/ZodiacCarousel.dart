import 'package:flutter/material.dart';
import 'zodiac_data.dart';

import '../../constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:carousel_slider/carousel_slider.dart' as carousel;

import "../compatibility/localizedZodiacName.dart";

class ZodiacCarousel extends StatelessWidget {
  final List<String> zodiacKeys;
  final String selectedIndex;
  final Function(String) onTap;
  final TabController tabController;
  final Function(String) saveUserChoice;

  // final String Function(BuildContext context, String key)

  const ZodiacCarousel({
    Key? key,
    required this.zodiacKeys,
    required this.selectedIndex,
    required this.onTap,
    required this.tabController,
    required this.saveUserChoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizationHelper = LocalizationHelper(context);

    return carousel.CarouselSlider(
      items: zodiacKeys.map((i) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            color: selectedIndex == i
                ? AppColors.backgroundActive
                : AppColors.background,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                    onTap(i);
                    tabController.animateTo(0);
                    saveUserChoice(i);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: const BoxDecoration(
                        color: AppColors.background,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 0, left: 0, bottom: 0, top: 10),
                            child: SvgPicture.asset(
                              zodiacs[i]['img'],
                              height: 45,
                              width: 100,
                              fit: BoxFit.cover,
                              colorFilter: const ColorFilter.mode(
                                AppColors.zodiac,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 0, left: 0, bottom: 0, top: 5),
                            child: Text(
                              localizationHelper.localizedZodiacName(i),
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: AppColors.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
      options: carousel.CarouselOptions(
        height: 110,
        aspectRatio: 1.0,
        viewportFraction: 1 / 4.5,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: false,
        enlargeCenterPage: false,
        enlargeFactor: 0.3,
        padEnds: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
