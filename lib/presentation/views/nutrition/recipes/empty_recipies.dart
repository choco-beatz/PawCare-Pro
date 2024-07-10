import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/recipe%20model/recipe.dart';
import 'package:pawcare_pro/presentation/views/nutrition/recipes/add_recipies.dart';
import 'package:pawcare_pro/presentation/views/nutrition/recipes/view_recipies.dart';

class EmptyRecipies extends StatelessWidget {
  final int petId;
  const EmptyRecipies({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: mainBG,
        body: Center(
            child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.only(right: 25, left: 25),
            child: Column(
              children: [
                SizedBox(
                  height: width > 600 ? height * 0.01 : height * 0.12,
                ),
                SizedBox(
                  height: width > 600 ? height * 0.6 : height * 0.26,
                  width: width * 0.5,
                  child: const Image(
                    fit: BoxFit.fill,
                    image: AssetImage('asset/bowl.png'),
                  ),
                ),
                space,
                space,
                space,
                heading('No recipies added'),
                sizedBox,
                subject(
                    "Store recipes for complete care. Manage your culinary creations seamlessly."),
                Spacer(),
                OutlinedButton(
                    onPressed: () async {
                      final result = await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddRecipies(
                                    petId: petId,
                                  )));
                      if (result != null && result is Recipe) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewRecipies(petId: petId)));
                      }
                    },
                    style: dateButton,
                    child: subject('Add Recipies +'))
              ],
            ),
          ),
        )));
  }
}
