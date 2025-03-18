import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

class RotatingSVG extends StatefulWidget {
  @override
  _RotatingSVGState createState() => _RotatingSVGState();
}

class _RotatingSVGState extends State<RotatingSVG>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _controller; // Используем 'late' для отложенной инициализации

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(); // Инициализируем _controller в initState
  }

  @override
  void dispose() {
    _controller.dispose(); // Освобождаем ресурсы
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 6, 22, 41), // Задайте цвет фона здесь
      child: AnimatedBuilder(
        animation: _controller,

        // child: SvgPicture.asset(
        //   'images/load.svg', // Укажите путь к вашему SVG файлу
        //   //     width: 100,
        //   //     height: 100,
        // ),
        //  child: CircularProgressIndicator(),

        builder: (BuildContext context, Widget? child) {
          // Используем Widget? для child

          return Center(
            child: FractionallySizedBox(
              widthFactor: 0.05, // 10% от ширины родительского виджета
              // heightFactor: 0.1, // 10% от высоты родительского виджета
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
//Как мне использовать это при загрузке.
//Я хочу чтобы крутился круг при запросе dao а когда приходит ответ отключать
