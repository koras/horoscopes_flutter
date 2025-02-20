import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Для форматирования дат

class WeekDatesWidget extends StatelessWidget {
  // Массив с названиями месяцев в родительном падеже (для склонения)
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

  // Функция для получения начала недели (понедельник)
  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  // Функция для получения конца недели (воскресенье)
  DateTime _getEndOfWeek(DateTime date) {
    return date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  }

  // Функция для форматирования даты
  String _formatDate(DateTime date) {
    return DateFormat.d().format(date); // Только число
  }

  // Функция для получения месяца в родительном падеже
  String _getMonthGenitive(DateTime date) {
    return monthsGenitive[date.month - 1]; // Месяцы в Dart нумеруются с 1
  }

  @override
  Widget build(BuildContext context) {
    // Текущая дата
    DateTime now = DateTime.now();

    // Начало недели (понедельник)
    DateTime startOfWeek = _getStartOfWeek(now);

    // Конец недели (воскресенье)
    DateTime endOfWeek = _getEndOfWeek(now);

    // Форматируем даты
    String startDate = _formatDate(startOfWeek);
    String endDate = _formatDate(endOfWeek);

    // Получаем названия месяцев в родительном падеже
    String startMonth = _getMonthGenitive(startOfWeek);
    String endMonth = _getMonthGenitive(endOfWeek);

    // Если начало и конец недели в разных месяцах
    String monthText = startMonth;
    if (startOfWeek.month != endOfWeek.month) {
      monthText = '$startMonth-$endMonth';
    }

    return Text(
      '$startDate-$endDate $monthText',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
