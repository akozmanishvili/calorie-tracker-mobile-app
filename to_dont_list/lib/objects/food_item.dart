// single food entry data: what user ate and how many calories it was

class FoodItem {
  const FoodItem({required this.name, required this.calories});

  final String name;
  final int calories;

  String abbrev() {
    return name.substring(0, 1);
  }

  String summary() {
    return "$name ($calories cal)";
  }
}
