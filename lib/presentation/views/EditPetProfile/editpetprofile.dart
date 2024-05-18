import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:intl/intl.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/presentation/views/add_pet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/add_pet/widgets/lable.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';

class EditPetProfile extends StatefulWidget {
  final int? PetID;
  const EditPetProfile({super.key, this.PetID});

  @override
  State<EditPetProfile> createState() => _EditPetProfileState();
}

class _EditPetProfileState extends State<EditPetProfile> {
  //for radio
  String selected = 'none';
  String gender = 'none';
  String size = 'none';

  //for image
  String? image;

  //for dates
  DateTime bdate = DateTime.now();
  DateTime adate = DateTime.now();

  String? formattedADate;
  String? formattedBDate;

  final PetInfoService _petInfoService = PetInfoService();

  //TextEditingControllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  //to store all the values that is fetched from db
  // List<PetInfo> _pet = [];
  late PetInfo? _pet;

  //loading/fetching data from the hive
  Future<void> _loadPets() async {
    //the datas recived from the db is stored into list
    // _pet = await _petInfoService.getPet();
    _pet = await _petInfoService.getPet(widget.PetID);
    _nameController.text = _pet!.name;
    _breedController.text = _pet!.breed;
    _descriptionController.text = _pet!.description;
    _weightController.text = _pet!.weight;
    selected = _pet!.type;
    gender = _pet!.gender;
    size = _pet!.size;

    setState(() {});
  }

  @override
  void initState() {
    _loadPets();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBG,
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: Colors.white,
        title: const Text(
          'Edit Pet Profile',
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
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: lightGrey,
                    radius: 90,
                    child: _pet!.image != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(File(_pet!.image ?? '')),
                            radius: 70,
                          )
                        : const CircleAvatar(
                            radius: 70,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading2(_pet!.name),
                        subject('${_pet!.type} | ${_pet!.breed}')
                      ],
                    ),
                  )
                ],
              ),
              label('Pet'),
              Row(
                children: [
                  SizedBox(
                    height: 120,
                    width: 170,
                    child: RadioMenuButton(
                      value: 'dog',
                      style: fieldRadio,
                      groupValue: selected,
                      onChanged: (selection) {
                        setState(() {
                          selected = selection!;
                          _pet!.type = selected;
                          // _petInfoService.updatePet(_pet!);
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
                      value: 'cat',
                      style: fieldRadio,
                      groupValue: selected,
                      onChanged: (selection) {
                        setState(() {
                          selected = selection!;
                          _pet!.type = selected;
                          // _petInfoService.updatePet(_pet!);
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
                        value: 'female',
                        style: fieldRadio,
                        groupValue: gender,
                        onChanged: (selection) {
                          setState(() {
                            gender = selection!;
                            _pet!.gender = gender;
                            // _petInfoService.updatePet(_pet!);
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
                        value: 'male',
                        style: fieldRadio,
                        groupValue: gender,
                        onChanged: (selection) {
                          setState(() {
                            gender = selection!;
                            _pet!.gender = gender;
                            // _petInfoService.updatePet(_pet!);
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
                      width: 95,
                      child: RadioMenuButton(
                          value: 'small',
                          style: fieldRadio,
                          groupValue: size,
                          onChanged: (selection) {
                            setState(() {
                              size = selection!;
                              _pet!.size = size;
                              // _petInfoService.updatePet(_pet!);
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
                      width: 95,
                      child: RadioMenuButton(
                          value: 'medium',
                          style: fieldRadio,
                          groupValue: size,
                          onChanged: (selection) {
                            setState(() {
                              size = selection!;
                              _pet!.size = size;
                              // _petInfoService.updatePet(_pet!);
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
                      width: 95,
                      child: RadioMenuButton(
                          value: 'huge',
                          style: fieldRadio,
                          groupValue: size,
                          onChanged: (selection) {
                            setState(() {
                              size = selection!;
                              _pet!.size = size;
                              // _petInfoService.updatePet(_pet!);
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
                  controller: _weightController,
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
                              lastDate: DateTime(2025))
                          .then((value) {
                        setState(() {
                          bdate = value!;
                        });
                      });
                      formattedBDate = DateFormat('dd-MM-yyyy').format(bdate);
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
                      subject('Add Birth date')
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
                              lastDate: DateTime(2025))
                          .then((value) {
                        setState(() {
                          adate = value!;
                        });
                      });
                      formattedADate = DateFormat('dd-MM-yyyy').format(bdate);
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
                      subject('Add Adoption date')
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
                        weight: _weightController.text,
                        image: image ?? '',
                        bday: formattedBDate ?? '',
                        aday: formattedADate ?? '',
                        isActive: true,
                        id: _pet!.id);
                    print(_pet!.id);
                    await _petInfoService.updatePet(_pet!.id, pet).then((_) {
                      _nameController.clear();
                      _breedController.clear();
                      _descriptionController.clear();
                      _weightController.clear();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Dashboard(petID: pet.id,)));
                      void complete()
                      {
                        Navigator.pop(context);
                      }
                      
                    });
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
