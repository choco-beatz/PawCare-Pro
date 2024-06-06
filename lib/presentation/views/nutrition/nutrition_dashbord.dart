import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/presentation/views/nutrition/recipes/view_recipies.dart';
import 'package:pawcare_pro/presentation/views/widgets/healthcard_dashboard_widgets.dart';

class NutritionDashboard extends StatelessWidget {
  final int petId;
  const NutritionDashboard({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBG,
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: Colors.white,
        title: const Text(
          'Nutrition',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewRecipies(petId: petId,)));
              },
              child: CardButton(
                  bgColor: transblue,
                  head: 'Recipies',
                  image: 'asset/food.png',
                  brColor: lightBlue),
            ),
          ],
        ),
      ),
    );
  }
}
