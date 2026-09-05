import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_dont_list/objects/user_peofile.dart';
import 'package:to_dont_list/widgets/profile_form.dart';

void main() {
  testWidgets(
      'Entering valid values and tapping Calculate reports a matching UserProfile',
      (tester) async {
    UserProfile? reportedProfile;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ProfileForm(
          onProfileCalculated: (profile) {
            reportedProfile = profile;
          },
        ),
      ),
    ));

    await tester.enterText(find.byKey(const Key("WeightField")), "80");
    await tester.enterText(find.byKey(const Key("HeightField")), "180");
    await tester.enterText(find.byKey(const Key("AgeField")), "25");
    await tester.tap(find.byKey(const Key("CalculateButton")));
    await tester.pump();

    expect(reportedProfile, isNotNull);
    expect(reportedProfile!.weightKg, 80);
    expect(reportedProfile!.heightCm, 180);
    expect(reportedProfile!.age, 25);
    expect(reportedProfile!.sex, Sex.male); // default selection
  });

  testWidgets('Selecting Female changes the reported profiles sex',
      (tester) async {
    UserProfile? reportedProfile;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ProfileForm(
          onProfileCalculated: (profile) {
            reportedProfile = profile;
          },
        ),
      ),
    ));

    await tester.enterText(find.byKey(const Key("WeightField")), "60");
    await tester.enterText(find.byKey(const Key("HeightField")), "165");
    await tester.enterText(find.byKey(const Key("AgeField")), "30");
    await tester.tap(find.byKey(const Key("FemaleRadio")));
    await tester.pump();
    await tester.tap(find.byKey(const Key("CalculateButton")));
    await tester.pump();

    expect(reportedProfile!.sex, Sex.female);
  });

  testWidgets(
      'Tapping Calculate with missing input shows an error and does not report a profile',
      (tester) async {
    bool wasCalled = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ProfileForm(
          onProfileCalculated: (profile) {
            wasCalled = true;
          },
        ),
      ),
    ));

    // Only fill in one of the three fields.
    await tester.enterText(find.byKey(const Key("WeightField")), "80");
    await tester.tap(find.byKey(const Key("CalculateButton")));
    await tester.pump();

    expect(wasCalled, false);
    expect(
        find.text("Please enter valid numbers for all fields"), findsOneWidget);
  });
}
