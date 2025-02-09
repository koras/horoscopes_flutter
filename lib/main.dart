import 'package:flutter/material.dart';

import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'src/country.dart';
//import 'package:easy_localization/easy_localization.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  //WidgetsFlutterBinding.ensureInitialized();
  //await EasyLocalization.ensureInitialized();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // runApp(MyApp(settingsController: settingsController));
  runApp(Country());
  // runApp(
  //   EasyLocalization(
  //       startLocale: const Locale('ru'),
  //       supportedLocales: [const Locale('en'), const Locale('ru')],
  //       path: 'assets/langs',
  //       useOnlyLangCode: false,
  //       fallbackLocale: const Locale('ru'),
  //       child: Country()),
  // );
}
