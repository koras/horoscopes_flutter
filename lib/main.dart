import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/start.dart';
//import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Обязательно вызовите это перед инициализацией
  await EasyLocalization.ensureInitialized(); // Инициализация EasyLocalization

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  // SettingsView.
  // runApp(MyApp(settingsController: settingsController));
  //runApp(Country());
  Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('en', locale.languageCode);
  }

  Future<Locale?> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString('en');
    if (localeCode != null) {
      return Locale(localeCode);
    }
    return null;
  }

  final savedLocale = await getSavedLocale();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru')], // Поддерживаемые языки
      path: 'assets/langs', // Путь к файлам переводов

      fallbackLocale: Locale('en'), // Язык по умолчанию

      startLocale: const Locale('en'), // Установите  локаль
      //
      child: Start(),
      // child: RotatingSVG(),
    ),
  );
}
