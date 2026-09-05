import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/objects/food_item.dart';
import 'package:to_dont_list/widgets/food_list_item.dart';

void main() {
  testWidgets('FoodListItem shows name and calories as its title',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FoodListItem(
          item: const FoodItem(name: "Banana", calories: 105),
          onDeleteItem: (item) {},
        ),
      ),
    ));

    expect(find.text('Banana (105 cal)'), findsOneWidget);
  });

  testWidgets('FoodListItem shows the abbreviation in a CircleAvatar',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FoodListItem(
          item: const FoodItem(name: "Banana", calories: 105),
          onDeleteItem: (item) {},
        ),
      ),
    ));

    final avatarFinder = find.byType(CircleAvatar);
    CircleAvatar circ = tester.firstWidget(avatarFinder);
    Text ctext = circ.child as Text;

    expect(ctext.data, "B");
  });

  testWidgets('Long-pressing a FoodListItem reports it for deletion',
      (tester) async {
    FoodItem? deletedItem;
    const item = FoodItem(name: "Banana", calories: 105);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FoodListItem(
          item: item,
          onDeleteItem: (i) {
            deletedItem = i;
          },
        ),
      ),
    ));

    await tester.longPress(find.byType(ListTile));
    await tester.pump();

    expect(deletedItem, item);
  });
}
