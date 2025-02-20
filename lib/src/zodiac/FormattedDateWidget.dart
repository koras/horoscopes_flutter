import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Для форматирования даты

class FormattedDateWidget extends StatelessWidget {
  final int daysToAdd; // Параметр: 0 или 1 день

  // Массив с названиями месяцев в родительном падеже
  final List<String> monthsGenitive = [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря'
  ];

  FormattedDateWidget({Key? key, required this.daysToAdd}) : super(key: key);

  // Функция для получения месяца в родительном падеже
  String _getMonthGenitive(DateTime date) {
    return monthsGenitive[date.month - 1]; // Месяцы в Dart нумеруются с 1
  }

  @override
  Widget build(BuildContext context) {
    // Получаем текущую дату
    DateTime now = DateTime.now();

    // Добавляем дни (0 или 1)
    DateTime targetDate = now.add(Duration(days: daysToAdd));

    // Форматируем дату
    String day = DateFormat.d().format(targetDate); // Только число
    String month = _getMonthGenitive(targetDate); // Месяц в родительном падеже
    // String year = DateFormat.y().format(targetDate); // Год

    return Text(
      '$day $month',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
