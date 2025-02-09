import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'src/country.dart';
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

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru')], // Поддерживаемые языки
      path: 'assets/l10n', // Путь к файлам переводов
      fallbackLocale: Locale('en'), // Язык по умолчанию
      child: Country(),
    ),
  );
}
