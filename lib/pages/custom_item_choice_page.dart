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
  final List<String> names = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];
  String addedItemName = '';

  void addItemToList(){
    setState(() {
      names.insert(0, addedItemName);
      msgCount.insert(0, 0);
      addedItemName = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create List'),
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Name',
                    ),
                    onChanged: (text) {
                      setState(() => addedItemName = text);
                    },
                  ),
                ),
                ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    addItemToList();
                  },
                ),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: names.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            margin: const EdgeInsets.all(2),
                            color: msgCount[index]>=10? Colors.blue[400]:
                            msgCount[index]>3? Colors.blue[100]: Colors.grey,
                            child: Center(
                                child: Text('${names[index]} (${msgCount[index]})',
                                  style: const TextStyle(fontSize: 18),
                                )
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              RandomizerPage(items: names)
          ));
        },
        child: const Icon(
          Icons.arrow_right,
        ),
      ),
    );
  }
}