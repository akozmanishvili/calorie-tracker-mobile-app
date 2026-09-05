import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/user_peofile.dart';

typedef ProfileCalculatedCallback = Function(UserProfile profile);

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key, required this.onProfileCalculated});

  final ProfileCalculatedCallback onProfileCalculated;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  Sex _selectedSex = Sex.male;
  String _errorText = "";

  void _handleCalculate() {
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);
    final age = int.tryParse(_ageController.text);

    if (weight == null || height == null || age == null) {
      setState(() {
        _errorText = "Please enter valid numbers for all fields";
      });
      return;
    }

    final profile = UserProfile(
      weightKg: weight,
      heightCm: height,
      age: age,
      sex: _selectedSex,
    );

    widget.onProfileCalculated(profile);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            key: const Key("WeightField"),
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Weight (kg)"),
          ),
          TextField(
            key: const Key("HeightField"),
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Height (cm)"),
          ),
          TextField(
            key: const Key("AgeField"),
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Age (years)"),
          ),
          Row(
            children: <Widget>[
              Radio<Sex>(
                key: const Key("MaleRadio"),
                value: Sex.male,
                groupValue: _selectedSex,
                onChanged: (Sex? value) {
                  setState(() {
                    _selectedSex = value!;
                  });
                },
              ),
              const Text("Male"),
              Radio<Sex>(
                key: const Key("FemaleRadio"),
                value: Sex.female,
                groupValue: _selectedSex,
                onChanged: (Sex? value) {
                  setState(() {
                    _selectedSex = value!;
                  });
                },
              ),
              const Text("Female"),
            ],
          ),
          if (_errorText.isNotEmpty)
            Text(
              _errorText,
              style: const TextStyle(color: Colors.red),
            ),
          ElevatedButton(
            key: const Key("CalculateButton"),
            onPressed: _handleCalculate,
            child: const Text("Calculate"),
          ),
        ],
      ),
    );
  }
}
