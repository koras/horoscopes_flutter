import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({Key? key}) : super(key: key);

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    // Извлекаем переданный id
//    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;

    int itemId = ModalRoute.of(context)!.settings.arguments as int;
    itemId += 33;

    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details  $itemId'),
      ),
      body: Center(
        child: Text('Item ID: sdasd выафывафыва $itemId'), // Отображаем id
      ),
    );
  }
}
