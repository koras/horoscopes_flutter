class DailyData {
  final Map<String, DayData> days;

  DailyData({required this.days});

  factory DailyData.fromJson(Map<String, dynamic> json) {
    final days = <String, DayData>{};
    json.forEach((key, value) {
      days[key] = DayData.fromJson(value);
    });
    return DailyData(days: days);
  }
}

class DayData {
  final Map<String, ZodiacData> zodiacs;

  DayData({required this.zodiacs});

  factory DayData.fromJson(Map<String, dynamic> json) {
    final zodiacs = <String, ZodiacData>{};
    json.forEach((key, value) {
      zodiacs[key] = ZodiacData.fromJson(value);
    });
    return DayData(zodiacs: zodiacs);
  }
}

class ZodiacData {
  final ChartData chart;
  final TextData text;
  final List<int> favoriteNumbers;

  ZodiacData({
    required this.chart,
    required this.text,
    required this.favoriteNumbers,
  });

  factory ZodiacData.fromJson(Map<String, dynamic> json) {
    return ZodiacData(
      chart: ChartData.fromJson(json['chart']),
      text: TextData.fromJson(json['text']),
      favoriteNumbers: List<int>.from(json['favorite_numbers']),
    );
  }
}

class ChartData {
  final int chartLove;
  final int chartMoney;
  final int chartLike;

  ChartData({
    required this.chartLove,
    required this.chartMoney,
    required this.chartLike,
  });

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      chartLove: json['chart_love'],
      chartMoney: json['chart_money'],
      chartLike: json['chart_like'],
    );
  }
}

class TextData {
  final String ru;
  final String en;

  TextData({
    required this.ru,
    required this.en,
  });

  factory TextData.fromJson(Map<String, dynamic> json) {
    return TextData(
      ru: json['ru'],
      en: json['en'],
    );
  }
}
