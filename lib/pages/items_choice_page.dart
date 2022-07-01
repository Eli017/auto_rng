import 'package:auto_rng/pages/custom_item_choice_page.dart';
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
  int? minimumNumber = 0;
  int? maximumNumber = 1;
  String? numberErrorMessage;
  bool isNextButtonEnabled = true;

  //Check if minimum is lower than maximum and vice versa.
  void validateNumbers () {
    if (minimumNumber == null || maximumNumber == null) {
      setState(() => {
        numberErrorMessage = 'Your numbers are not valid',
        isNextButtonEnabled = false
      });
    } else {
      if (minimumNumber! > maximumNumber!) {
        setState(() => {
          numberErrorMessage = 'Please set minimum number to be lower than the maximum',
          isNextButtonEnabled = false
        });
      } else if (minimumNumber == maximumNumber) {
        setState(() => {
          numberErrorMessage = 'Please have these be different numbers',
          isNextButtonEnabled = false
        });
      }
      else {
        setState(() => {
          numberErrorMessage = null,
          isNextButtonEnabled = true
        });
      }
    }
  }

  List<int> generateNumberList() {
    List<int> numbers = [];
    if (maximumNumber == null) {
      return numbers;
    }
    for (var i = minimumNumber; i! <= maximumNumber!; i++) {
      numbers.add(i);
    }
    return numbers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your items'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/3.5),
            ListTile(
              title: const Text('Numbers'),
              leading: Radio<ItemType>(
                value: ItemType.number,
                groupValue: itemType,
                onChanged: (ItemType? value) {
                  setState(() => itemType = value);
                  validateNumbers();
                },
              ),
            ),
            ListTile(
              title: const Text('Custom'),
              leading: Radio<ItemType>(
                value: ItemType.custom,
                groupValue: itemType,
                onChanged: (ItemType? value) {
                  setState(() => {
                    itemType = value,
                    isNextButtonEnabled = true
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: Visibility(
                    visible: (itemType == ItemType.number),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Minimum'),
                      keyboardType: TextInputType.number,
                      initialValue: minimumNumber.toString(),
                      onChanged: (value) {
                        setState(() => minimumNumber = int.tryParse(value) ?? 0);
                        validateNumbers();
                      },
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: Visibility(
                    visible: (itemType == ItemType.number),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Maximum'),
                      keyboardType: TextInputType.number,
                      initialValue: maximumNumber.toString(),
                      onChanged: (value) {
                        setState(() => maximumNumber = int.tryParse(value) ?? 1);
                        validateNumbers();
                      },
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Visibility(
                visible: (numberErrorMessage != null && itemType == ItemType.number) ? true : false,
                child: Text(
                  numberErrorMessage ?? '',
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'durationButton',
        onPressed: isNextButtonEnabled ? () {
          if (itemType == ItemType.number) {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                RandomizerPage(items: generateNumberList(),)
            ));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                const CustomItemChoicePage()
            ));
          }
        } : null,
        backgroundColor: isNextButtonEnabled ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
        tooltip: 'Go to duration choice page',
        child: const Icon(
          Icons.arrow_right,
        ),
      ),
    );
  }
}
