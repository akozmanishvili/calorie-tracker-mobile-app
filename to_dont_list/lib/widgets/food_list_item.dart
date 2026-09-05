import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/food_item.dart';

typedef FoodRemovedCallback = Function(FoodItem item);

class FoodListItem extends StatelessWidget {
  FoodListItem({
    required this.item,
    required this.onDeleteItem,
  }) : super(key: ObjectKey(item));

  final FoodItem item;
  final FoodRemovedCallback onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        onDeleteItem(item);
      },
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(item.abbrev()),
      ),
      title: Text(item.summary()),
    );
  }
}
