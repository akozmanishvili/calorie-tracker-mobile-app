import 'package:flutter/material.dart';

typedef FoodAddedCallback = Function(
    String name,
    int calories,
    TextEditingController nameController,
    TextEditingController caloriesController);

class FoodDialog extends StatefulWidget {
  const FoodDialog({
    super.key,
    required this.onFoodAdded,
  });

  final FoodAddedCallback onFoodAdded;

  @override
  State<FoodDialog> createState() => _FoodDialogState();
}

class _FoodDialogState extends State<FoodDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final ButtonStyle cancelStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);
  final ButtonStyle okStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);

  String _nameText = "";

  bool _isValid() {
    return _nameController.text.isNotEmpty &&
        int.tryParse(_caloriesController.text) != null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Food To Add'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            key: const Key("FoodNameField"),
            onChanged: (value) {
              setState(() {
                _nameText = value;
              });
            },
            controller: _nameController,
            decoration: const InputDecoration(hintText: "what did you eat?"),
          ),
          TextField(
            key: const Key("FoodCaloriesField"),
            onChanged: (value) {
              setState(() {});
            },
            controller: _caloriesController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "how many calories?"),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: cancelStyle,
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          key: const Key("OKButton"),
          style: okStyle,
          onPressed: _isValid()
              ? () {
                  final calories = int.parse(_caloriesController.text);
                  widget.onFoodAdded(_nameText, calories, _nameController,
                      _caloriesController);
                  Navigator.pop(context);
                }
              : null,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
