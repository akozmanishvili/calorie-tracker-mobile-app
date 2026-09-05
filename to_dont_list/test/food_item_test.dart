import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/objects/food_item.dart';

void main() {
  test('returns the first letter of the name', () {
    const item = FoodItem(name: "Banana", calories: 105);
    expect(item.abbrev(), "B");
  });

  group('FoodItem.summary', () {
    test('combines name and calorie count', () {
      const item = FoodItem(name: "Banana", calories: 105);
      expect(item.summary(), "Banana (105 cal)");
    });

    test('shows a different name and calorie count', () {
      const item = FoodItem(name: "Oatmeal", calories: 250);
      expect(item.summary(), "Oatmeal (250 cal)");
    });
  });
}
