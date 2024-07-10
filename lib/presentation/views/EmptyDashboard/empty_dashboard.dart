import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/addpet/add_pet.dart';
import 'package:pawcare_pro/presentation/views/userprofile/userprofile.dart';

import 'package:pawcare_pro/presentation/views/widgets/appbar.dart';

class EmptyDash extends StatelessWidget {
  const EmptyDash({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.1),
          child: GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserProfile())),
            child: Appbar(
              bg: mainBG,
            ),
          )),
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
                  height: width > 600 ? height * 0.6 : height * 0.35,
                  width: width * 0.7,
                  child: const Image(
                    fit: BoxFit.fill,
                    image: AssetImage('asset/animals.png'),
                  ),
                ),
                heading('Uh-Oh!'),
                sizedBox,
                subject(
                    'Looks like you have no profiles set up at this moment, add your pet now.'),
                Spacer(),
                FilledButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddPet()));
                    },
                    style: secondaryButton,
                    child: const Text('Add your pets'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
