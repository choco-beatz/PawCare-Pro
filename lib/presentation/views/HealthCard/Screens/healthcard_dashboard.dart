import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';

class HealthCardDashboard extends StatelessWidget {
  const HealthCardDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBG,
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: Colors.white,
        title: const Text(
          'Health Card',
          style: TextStyle(fontSize: 18),
        ),
      ),);
  }
}