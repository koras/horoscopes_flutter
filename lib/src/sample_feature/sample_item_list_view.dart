import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  static const routeName = '/';

  final List<SampleItem> items;

  const SampleItemListView({
    Key? key,
    this.items = const [
      SampleItem(1),
      SampleItem(2),
      SampleItem(3),
      SampleItem(4),
      SampleItem(6),
      SampleItem(7)
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //      title: const Text('Sample Items'),
        title: const SizedBox.shrink(), // Пустой виджет

        leading: Container(
          margin: const EdgeInsets.all(8), // Отступы для кнопки
          decoration: BoxDecoration(
            color: Colors.blue, // Синий цвет фона
            borderRadius:
                BorderRadius.circular(4), // Углы с небольшим скруглением
          ),
          child: IconButton(
            icon: const Icon(Icons.menu,
                color: Color.fromARGB(255, 141, 21, 21)), // Иконка меню
            onPressed: () {
              // Действие при нажатии на кнопку
              print('Квадратная синяя кнопка нажата');
            },
          ),
        ),

        actions: [
          // Добавляем TextField в AppBar
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //   child: SizedBox(
          //     width: 200, // Ширина текстового поля
          //     child: TextField(
          //       decoration: InputDecoration(
          //         hintText: 'Поиск...',
          //         border: InputBorder.none,
          //         filled: true,
          //         fillColor: Colors.white.withOpacity(0.2),
          //       ),
          //     ),
          //   ),
          // ),
          // Кнопка настроек
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.settings),
          //   onPressed: () {
          //     // Navigate to the settings page. If the user leaves and returns
          //     // to the app after it has been killed while running in the
          //     // background, the navigation stack is restored.
          //     Navigator.restorablePushNamed(context, SettingsView.routeName);
          //   },
          // ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text('SampleItem ${item.id}'),
              leading: const CircleAvatar(
                // Display the Flutter Logo image asset.
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(
                  context,
                  SampleItemDetailsView.routeName,
                  arguments: item.id.toString(), // Передаем id элемента
                );
              });
        },
      ),
    );
  }
}
