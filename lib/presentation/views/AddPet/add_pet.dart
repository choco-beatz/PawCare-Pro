import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/presentation/views/AddPet/widgets/field_style.dart';

import 'package:pawcare_pro/presentation/views/AddPet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/Dashboard/dashboard.dart';

class AddPet extends StatefulWidget {
  AddPet({super.key});

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  String selected = 'none';
  String gender = 'none';
  String size = 'none';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBG,
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: Colors.white,
        title: const Text(
          'Add Pet Profile',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(clipBehavior: Clip.none, children: [
                const Center(
                  child: CircleAvatar(
                    backgroundColor: grey,
                    radius: 150,
                    child: CircleAvatar(
                      backgroundColor: mainBG,
                      radius: 149,
                      child: CircleAvatar(
                        backgroundColor: grey,
                        radius: 120,
                        child: CircleAvatar(
                          backgroundColor: mainBG,
                          radius: 119,
                          child: FaIcon(
                            FontAwesomeIcons.paw,
                            size: 150,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 230,
                  top: 230,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          size: 25,
                          Icons.image_outlined,
                          color: mainColor,
                        )),
                  ),
                )
              ]),
              label('Pet'),
              Row(
                children: [
                  SizedBox(
                    height: 120,
                    width: 180,
                    child: RadioMenuButton(
                      value: 'dog',
                      style: fieldRadio,
                      groupValue: selected,
                      onChanged: (selection) {
                        setState(() {
                          selected = selection!;
                        });
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.dog,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 120,
                    width: 180,
                    child: RadioMenuButton(
                      value: 'cat',
                      style: fieldRadio,
                      groupValue: selected,
                      onChanged: (selection) {
                        setState(() {
                          selected = selection!;
                        });
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.cat,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                  ),
                ],
              ),
              line,
              label('Name'),
              SizedBox(
                height: 52,
                width: 370,
                child:
                    TextFormField(decoration: fieldDecor(" Enter pet's name")),
              ),
              line,
              label('Breed'),
              SizedBox(
                height: 52,
                width: 370,
                child:
                    TextFormField(decoration: fieldDecor(" Enter pet's breed")),
              ),
              line,
              label('Appearance and distinctive signs'),
              SizedBox(
                height: 52,
                width: 370,
                child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration:
                        fieldDecor(" Enter Appearance and distinctive signs")),
              ),
              line,
              label('Gender'),
              Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 180,
                    child: RadioMenuButton(
                        value: 'female',
                        style: fieldRadio,
                        groupValue: gender,
                        onChanged: (selection) {
                          setState(() {
                            gender = selection!;
                          });
                        },
                        child: subject('Female')),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: 180,
                    child: RadioMenuButton(
                        value: 'male',
                        style: fieldRadio,
                        groupValue: gender,
                        onChanged: (selection) {
                          setState(() {
                            gender = selection!;
                          });
                        },
                        child: subject('Male')),
                  ),
                ],
              ),
              line,
              label('Size'),
              SizedBox(
                height: 180,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 2.25,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 95,
                      child: RadioMenuButton(
                          value: 'small',
                          style: fieldRadio,
                          groupValue: size,
                          onChanged: (selection) {
                            setState(() {
                              size = selection!;
                            });
                          },
                          child: const SizedBox(
                            width: 120,
                            child: ListTile(
                              title: Text(
                                'Small',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              subtitle: Text(
                                'Under 14Kg',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 60,
                      width: 95,
                      child: RadioMenuButton(
                          value: 'medium',
                          style: fieldRadio,
                          groupValue: size,
                          onChanged: (selection) {
                            setState(() {
                              size = selection!;
                            });
                          },
                          child: const SizedBox(
                            width: 120,
                            child: ListTile(
                              title: Text(
                                'Medium',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              subtitle: Text(
                                '14-25Kg',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 95,
                      child: RadioMenuButton(
                          value: 'huge',
                          style: fieldRadio,
                          groupValue: size,
                          onChanged: (selection) {
                            setState(() {
                              size = selection!;
                            });
                          },
                          child: const SizedBox(
                            width: 120,
                            child: ListTile(
                              title: Text(
                                'Huge',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              subtitle: Text(
                                'Over 25Kg',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              line,
              label('Weight'),
              SizedBox(
                height: 52,
                width: 370,
                child: TextFormField(
                  decoration: fieldDecor("Enter Weight in Kg"),
                  keyboardType: TextInputType.number,
                ),
              ),
              line,
              label('Important Dates'),
              OutlinedButton(
                  onPressed: () {},
                  style: dateButton,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.cakeCandles,
                        color: mainColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      subject('Add Birth date')
                    ],
                  )),
              line,
              OutlinedButton(
                  onPressed: () {},
                  style: dateButton,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.houseChimneyWindow,
                        color: mainColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      subject('Add Adoption date')
                    ],
                  )),
              space,
              space,
              FilledButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                  style: mainButton,
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
