import 'package:auto_rng/pages/randomizer_page.dart';
import 'package:flutter/material.dart';
import 'items_choice_page.dart';

class CustomItemChoicePage extends StatefulWidget {
  const CustomItemChoicePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const CustomItemChoicePage(),
      settings: const RouteSettings(name: '/customItemChoicePage'),
    );
  }

  @override
  State<CustomItemChoicePage> createState() => _CustomItemChoicePageState();
}

class _CustomItemChoicePageState extends State<CustomItemChoicePage> {
  final List<String> items = <String>[];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];
  final TextEditingController nameController = TextEditingController();

  void addItemToList(){
    setState(() {
      items.insert(0, nameController.text);
    });
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create List'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Item Name',
                    ),
                  ),
                ),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: nameController,
                  builder: (context, value, child) {
                    return ElevatedButton(
                      onPressed: nameController.text != '' ? () {
                        addItemToList();
                      } : null,
                      child: const Text('Add'),
                    );
                  },
                ),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = items[index];
                          return Dismissible(
                            key: Key(item),
                            onDismissed: (direction) {
                              setState(() => items.removeAt(index));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('$item dismissed')));
                            },
                            background: Container(color: Colors.red),
                            child: Card(
                              child: ListTile(
                                title: Text(item)
                              ),
                            ),
                          );
                        }
                    )
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: items.isNotEmpty ? Theme.of(context).primaryColor : Colors.grey,
        onPressed: items.isNotEmpty ? () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              RandomizerPage(items: items)
          ));
        } : null,
        child: const Icon(
          Icons.arrow_right,
        ),
      ),
    );
  }
}