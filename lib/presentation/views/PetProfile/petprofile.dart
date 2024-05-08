import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/AddPet/add_pet.dart';
import 'package:pawcare_pro/presentation/views/AddPet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/AddPet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/PetProfile/widgets/data_style.dart';

class PetProfile extends StatelessWidget {
  const PetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBG,
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: Colors.white,
        title: const Text(
          'Pet Profile',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                      backgroundColor: lightGrey,
                      radius: 90,
                      child: CircleAvatar(
                        backgroundColor: fieldColor,
                        radius: 75,
                        child: FaIcon(FontAwesomeIcons.paw),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [heading2('name'), subject('dog | Breed')],
                    ),
                  )
                ],
              ),
              space,
              space,
              label('Appearence and distinctive signs'),
              subject2('text'),
              space,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [subject2('Gender'), label2('data')],
              ),
              line,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [subject2('Size'), label2('data')],
              ),
              line,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [subject2('Weight'), label2('data')],
              ),
              space,
              space,
              label('Important Dates'),
              ListTile(
                leading: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                      child: FaIcon(
                    FontAwesomeIcons.cakeCandles,
                    color: Colors.white,
                    size: 20,
                  )),
                ),
                title: subject2('Birthday'),
                subtitle: label2('data'),
              ),
              line,
              ListTile(
                leading: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                      child: FaIcon(
                    FontAwesomeIcons.house,
                    color: Colors.white,
                    size: 20,
                  )),
                ),
                title: subject2('Adoption Day'),
                subtitle: label2('data'),
              ),
              space,
              space,
              space,
              space,
              FilledButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddPet()));
                  },
                  style: mainButton,
                  child: Text('Edit'))
            ],
          ),
        ),
      ),
    );
  }
}
