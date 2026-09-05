import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/objects/user_peofile.dart';

void main() {
  group('UserProfile.MRate', () {
    test('calculates correctly for a male', () {
      const profile = UserProfile(
        weightKg: 80,
        heightCm: 180,
        age: 25,
        sex: Sex.male,
      );

      expect(profile.MRate(), 1805);
    });

    test('calculates correctly for a female', () {
      const profile = UserProfile(
        weightKg: 60,
        heightCm: 165,
        age: 30,
        sex: Sex.female,
      );

      expect(profile.MRate(), closeTo(1320.25, 0.001));
    });
  });

  group('UserProfile.maintenanceCalories', () {
    test('applies the activity multiplier to the BMR', () {
      const profile = UserProfile(
        weightKg: 80,
        heightCm: 180,
        age: 25,
        sex: Sex.male,
      );

      expect(profile.maintenanceCalories(), closeTo(2166, 0.001));
    });

    test('a heavier, taller profile needs more calories than a lighter one',
        () {
      const light =
          UserProfile(weightKg: 55, heightCm: 160, age: 25, sex: Sex.female);
      const heavy =
          UserProfile(weightKg: 90, heightCm: 190, age: 25, sex: Sex.male);

      expect(heavy.maintenanceCalories(),
          greaterThan(light.maintenanceCalories()));
    });
  });
}
