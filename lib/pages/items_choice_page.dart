import 'package:flutter/material.dart';
import 'duration_choice_page.dart';

class ItemsChoicePage extends StatefulWidget {
  const ItemsChoicePage({Key? key, required this.counter}) : super(key: key);

  final int counter;

  @override
  State<ItemsChoicePage> createState() => _ItemsChoicePageState();
}

enum ItemType {
  number,
  custom,
}

class _ItemsChoicePageState extends State<ItemsChoicePage> {
  // List<String?> items = [];
  ItemType? itemType = ItemType.number;

  // List<Widget> getItems() {
  //   List<Widget> children = [];
  //   for (String? item in items) {
  //     children.add(Text(item ?? "N/A"));
  //   }
  //   return children;
  // }

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
          // if (_duration == 0) {
          //   startTimer(1);
          // } else {
          //   myTimer.cancel();
          //   startTimer(_duration);
          // }
        },
        tooltip: 'Go to duration choice page',
        child: const Icon(Icons.arrow_right),
      ),
    );
  }
}
