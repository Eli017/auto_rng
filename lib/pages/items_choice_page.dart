import 'package:flutter/material.dart';
import 'randomizer_page.dart';

class ItemsChoicePage extends StatefulWidget {
  const ItemsChoicePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ItemsChoicePage(),
      settings: const RouteSettings(name: '/itemsChoicePage'),
    );
  }


  @override
  State<ItemsChoicePage> createState() => _ItemsChoicePageState();
}

enum ItemType {
  number,
  custom,
}

class _ItemsChoicePageState extends State<ItemsChoicePage> {
  ItemType? itemType = ItemType.number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your items'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: const Text('Numbers'),
              leading: Radio<ItemType>(
                value: ItemType.number,
                groupValue: itemType,
                onChanged: (ItemType? value) {
                  setState(() {
                    itemType = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Custom'),
              leading: Radio<ItemType>(
                value: ItemType.custom,
                groupValue: itemType,
                onChanged: (ItemType? value) {
                  setState(() {
                    itemType = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'durationButton',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
            const RandomizerPage(items: [0, 1, 2, 3],)
          ));
        },
        tooltip: 'Go to duration choice page',
        child: const Icon(Icons.arrow_right),
      ),
    );
  }
}
