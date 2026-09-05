//User profile class to calculate the maintaince calorie intake based on person's weight, height, age and sex

enum Sex { male, female }

class UserProfile {
  const UserProfile({
    required this.weightKg,
    required this.heightCm,
    required this.age,
    required this.sex,
  });

  final double weightKg;
  final double heightCm;
  final int age;
  final Sex sex;

  // calculate metabolic rate
  double MRate() {
    final base = 10 * weightKg + 6.25 * heightCm - 5 * age;
    return sex == Sex.male ? base + 5 : base - 161;
  }

  // calculate maintenance calories assuming light activity (1.2)
  double maintenanceCalories() {
    return MRate() * 1.2;
  }
}
