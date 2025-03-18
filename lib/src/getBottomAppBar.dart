import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart'; // Импортируем пакет flutter_svg

import 'zodiac/zodiac_detail.dart';
import '../../constants/app_colors.dart';
import './compatibility/compatibility.dart';

BottomAppBar getBottomAppBar(BuildContext context, String type) {
  return BottomAppBar(
    color: AppColors.backgroundMenu, // Цвет фона BottomAppBar
    shape:
        CircularNotchedRectangle(), // Форма выреза (например, для FloatingActionButton)
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            if (type != 'zodiac') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ZodiacDetail()),
              );
            }
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
                color: type == 'zodiac'
                    ? AppColors.onMenuButtonActive
                    : AppColors.onMenuButton,
              ), // Путь к вашей иконке
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (type != 'compatibility') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Compatibility()),
              );
            }
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
                color: type == 'compatibility'
                    ? AppColors.onMenuButtonActive
                    : AppColors.onMenuButton,
              ), // Путь к вашей иконке
            ],
          ),
        ),
      ],
    ),
  );
}
