// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/food_item.dart';
import 'package:to_dont_list/objects/user_peofile.dart';
import 'package:to_dont_list/widgets/food_list_item.dart';
import 'package:to_dont_list/widgets/food_dialog.dart';
import 'package:to_dont_list/widgets/profile_form.dart';

class CalorieTrackerApp extends StatefulWidget {
  const CalorieTrackerApp({super.key});

  @override
  State createState() => _CalorieTrackerAppState();
}

class _CalorieTrackerAppState extends State<CalorieTrackerApp> {
  UserProfile? _profile;
  final List<FoodItem> _foodItems = [];

  int get _totalCaloriesEaten {
    return _foodItems.fold(0, (sum, item) => sum + item.calories);
  }

  void _handleProfileCalculated(UserProfile profile) {
    setState(() {
      _profile = profile;
    });
  }

  void _handleFoodAdded(
      String name,
      int calories,
      TextEditingController nameController,
      TextEditingController caloriesController) {
    setState(() {
      _foodItems.insert(0, FoodItem(name: name, calories: calories));
      nameController.clear();
      caloriesController.clear();
    });
  }

  void _handleDeleteItem(FoodItem item) {
    setState(() {
      _foodItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_profile == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Calorie Tracker')),
        body: ProfileForm(onProfileCalculated: _handleProfileCalculated),
      );
    }

    final maintenance = _profile!.maintenanceCalories();
    final eaten = _totalCaloriesEaten;
    final remaining = maintenance - eaten;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Calorie Tracker'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Maintenance: ${maintenance.toStringAsFixed(0)} cal',
                    key: const Key("MaintenanceText"),
                  ),
                  Text(
                    'Eaten today: $eaten cal',
                    key: const Key("EatenText"),
                  ),
                  Text(
                    'Remaining: ${remaining.toStringAsFixed(0)} cal',
                    key: const Key("RemainingText"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                children: _foodItems.map((item) {
                  return FoodListItem(
                    item: item,
                    onDeleteItem: _handleDeleteItem,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return FoodDialog(onFoodAdded: _handleFoodAdded);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Calorie Tracker',
    home: CalorieTrackerApp(),
  ));
}
