import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/AddPet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/PetProfile/petprofile.dart';
import 'package:pawcare_pro/presentation/views/widgets/appbar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: mainBG,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label('Active Pet Profile'),
            space,
            Stack(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PetProfile()));
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            heading2('PetName'),
                            subject('Type | Breed')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                  left: 160,
                  top: -50,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(28, 196, 229, 255),
                    radius: 120,
                    child: CircleAvatar(
                        backgroundColor: Color.fromARGB(80, 196, 229, 255),
                        radius: 100,
                        child: CircleAvatar(
                            backgroundColor: Color.fromARGB(100, 196, 229, 255),
                            radius: 80,
                            child: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(80, 196, 229, 255),
                              radius: 60,
                              child: FaIcon(
                                FontAwesomeIcons.paw,
                                size: 70,
                                color: Colors.white,
                              ),
                            ))),
                  ))
            ])
          ],
        ),
      ),
    );
  }
}
