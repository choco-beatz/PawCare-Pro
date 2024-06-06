import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/dashboard/dashboard.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPet extends StatefulWidget {
  AddPet({super.key});

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  //for radio
  String selected = 'none';
  String gender = 'none';
  String size = 'none';

  //for image
  String? image;

  //for dates
  DateTime bdate = DateTime.now();
  DateTime adate = DateTime.now();

  String formattedADate = 'Not set';
  String formattedBDate = 'Not set';

  final PetInfoService _petInfoService = PetInfoService();
  late PetInfo? pet;

  //TextEditingControllers

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _weigthController = TextEditingController();

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
                Center(
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
                          child: image != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(File(image ?? '')),
                                  radius: 90,
                                )
                              : const CircleAvatar(
                                  radius: 90,
                                  backgroundColor: lightGrey,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 215,
                  top: 210,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: IconButton(
                        onPressed: () async {
                          getMainImagesFromGallery();
                          // if (image == null) return;
                          // imageBytes = await image.readAsBytes();
                        },
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
                    width: 170,
                    child: RadioMenuButton(
                      value: 'Dog',
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
                    width: 170,
                    child: RadioMenuButton(
                      value: 'Cat',
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
                child: TextFormField(
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  decoration: fieldDecor(" Enter pet's name"),
                  controller: _nameController,
                ),
              ),
              line,
              label('Breed'),
              SizedBox(
                height: 52,
                width: 370,
                child: TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    decoration: fieldDecor(" Enter pet's breed"),
                    controller: _breedController),
              ),
              line,
              label('Appearance and distinctive signs'),
              SizedBox(
                // height: 52,
                width: 370,
                child: TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    maxLines: 4,
                    decoration:
                        fieldDecor(" Enter Appearance and distinctive signs"),
                    controller: _descriptionController),
              ),
              line,
              label('Gender'),
              Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 170,
                    child: RadioMenuButton(
                        value: 'Female',
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
                    width: 170,
                    child: RadioMenuButton(
                        value: 'Male',
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
                  childAspectRatio: 2.1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 70,
                      child: RadioMenuButton(
                          value: 'Small',
                          style: fieldRadio,
                          groupValue: size,
                          onChanged: (selection) {
                            setState(() {
                              size = selection!;
                            });
                          },
                          child: const SizedBox(
                            width: 117,
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
                      width: 70,
                      child: RadioMenuButton(
                          value: 'Medium',
                          style: fieldRadio,
                          groupValue: size,
                          onChanged: (selection) {
                            setState(() {
                              size = selection!;
                            });
                          },
                          child: const SizedBox(
                            width: 110,
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
                      width: 70,
                      child: RadioMenuButton(
                          value: 'Huge',
                          style: fieldRadio,
                          groupValue: size,
                          onChanged: (selection) {
                            setState(() {
                              size = selection!;
                            });
                          },
                          child: const SizedBox(
                            width: 110,
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
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  decoration: fieldDecor("Enter Weight in Kg"),
                  controller: _weigthController,
                  keyboardType: TextInputType.number,
                ),
              ),
              line,
              label('Important Dates'),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      //  DateTime selDate = await _showDatePicker;
                      showDatePicker(
                              // barrierColor: mainBG,
                              context: context,
                              initialDate: bdate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now())
                          .then((value) {
                        setState(() {
                          bdate = value!;
                          formattedBDate =
                              DateFormat('dd-MM-yyyy').format(bdate);
                        });
                      });

                      print(formattedBDate);
                    });
                    // _showDatePicker;
                    // formattedDate = DateFormat('dd-MM-yyyy').format(date);
                  },
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
                      formattedBDate == 'Not set'
                          ? subject('Add Birth date')
                          : subject(formattedBDate)
                    ],
                  )),
              line,
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      //  DateTime selDate = await _showDatePicker;
                      showDatePicker(
                              // barrierColor: mainBG,
                              context: context,
                              initialDate: adate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now())
                          .then((value) {
                        setState(() {
                          adate = value!;
                          formattedADate =
                              DateFormat('dd-MM-yyyy').format(adate);
                        });
                      });
                    });
                    // _showDatePicker;
                    // formattedDate = DateFormat('dd-MM-yyyy').format(date);
                  },
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
                      formattedADate == 'Not set'
                          ? subject('Add Adoption date')
                          : subject(formattedADate)
                    ],
                  )),
              space,
              space,
              FilledButton(
                  onPressed: () async {
                    final pet = PetInfo(
                        type: selected,
                        name: _nameController.text,
                        breed: _breedController.text,
                        description: _descriptionController.text,
                        gender: gender,
                        size: size,
                        weight: _weigthController.text,
                        image: image ?? '',
                        bday: formattedBDate,
                        aday: formattedADate,
                        id: DateTime.now().microsecond,
                        isActive: false);

                    await _petInfoService.addPet(pet);
                    await _petInfoService.updateIsActive(pet.id,pet);
                    setState(() {});
                    _nameController.clear();
                    _breedController.clear();
                    _descriptionController.clear();
                    _weigthController.clear();

                    //shared preference is initialized and a key and value is set
                    final SharedPreferences sP =
                        await SharedPreferences.getInstance();
                    sP.setString('petname', pet.name);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Dashboard(
                                  petID: pet.id,
                                )));
                  },
                  style: mainButton,
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }

  Future getMainImagesFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000);
    XFile xfilePick = pickedFile!;

    setState(() {
      image = xfilePick.path;
    });
  }
}
