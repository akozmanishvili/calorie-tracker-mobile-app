import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/widgets/food_dialog.dart';

void main() {
  testWidgets('OK button is disabled until both fields are valid',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => FoodDialog(onFoodAdded: (a, b, c, d) {}),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    ElevatedButton okButton = tester.widget(find.byKey(const Key("OKButton")));
    expect(okButton.onPressed, isNull);

    await tester.enterText(find.byKey(const Key("FoodNameField")), "Apple");
    await tester.pump();

    okButton = tester.widget(find.byKey(const Key("OKButton")));
    expect(okButton.onPressed, isNull); // calories still missing

    await tester.enterText(find.byKey(const Key("FoodCaloriesField")), "95");
    await tester.pump();

    okButton = tester.widget(find.byKey(const Key("OKButton")));
    expect(okButton.onPressed, isNotNull);
  });

  testWidgets('Tapping OK reports the name and parsed calorie count',
      (tester) async {
    String? reportedName;
    int? reportedCalories;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => FoodDialog(onFoodAdded: (name, calories, c, d) {
                  reportedName = name;
                  reportedCalories = calories;
                }),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key("FoodNameField")), "Banana");
    await tester.enterText(find.byKey(const Key("FoodCaloriesField")), "105");
    await tester.pump();

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();

    expect(reportedName, "Banana");
    expect(reportedCalories, 105);
  });

  testWidgets('Tapping Cancel closes the dialog without reporting',
      (tester) async {
    bool wasCalled = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => FoodDialog(onFoodAdded: (a, b, c, d) {
                  wasCalled = true;
                }),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("CancelButton")));
    await tester.pumpAndSettle();

    expect(find.byType(FoodDialog), findsNothing);
    expect(wasCalled, false);
  });
}
