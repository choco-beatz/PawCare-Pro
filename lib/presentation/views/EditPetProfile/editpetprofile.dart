import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/icons.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/imagebuttondecor.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/editpetprofile/widget/fields.dart';
import 'package:pawcare_pro/presentation/views/editpetprofile/widget/loading.dart';
import 'package:pawcare_pro/presentation/views/widgets/normalappbar.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';

class EditPetProfile extends StatefulWidget {
  final int? petID;
  const EditPetProfile({super.key, this.petID});

  @override
  State<EditPetProfile> createState() => _EditPetProfileState();
}

class _EditPetProfileState extends State<EditPetProfile> {
  String selected = 'none';
  String gender = 'none';
  String size = 'none';
  String? image;
  DateTime bdate = DateTime.now();
  DateTime adate = DateTime.now();
  String formattedADate = 'Not set';
  String formattedBDate = 'Not set';
  final PetInfoService _petInfoService = PetInfoService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  PetInfo? _pet;

  Future<void> _loadPets() async {
    _pet = await _petInfoService.getPet(widget.petID);
    setState(() {
      _nameController.text = _pet!.name;
      _breedController.text = _pet!.breed;
      _descriptionController.text = _pet!.description;
      _weightController.text = _pet!.weight;
      selected = _pet!.type;
      gender = _pet!.gender;
      size = _pet!.size;
      formattedBDate = _pet!.bday;
      formattedADate = _pet!.aday;
      image = _pet!.image;
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _loadPets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: mainBG,
        appBar: normalAppBar('Edit Pet Profile'),
        body: _pet == null
            ? loading()
            : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                Stack(children: [
                                  CircleAvatar(
                                      backgroundColor: lightGrey,
                                      radius: 90,
                                      child: _pet!.image.isNotEmpty
                                          ? CircleAvatar(
                                              backgroundImage:
                                                  FileImage(File(image!)),
                                              radius: 70,
                                            )
                                          : const CircleAvatar(
                                              backgroundColor: lightGrey,
                                              radius: 70,
                                              child: Icon(
                                                size: 60,
                                                Icons.camera_alt_outlined,
                                                color: white,
                                              ),
                                            )),
                                  Positioned(
                                      left: 120,
                                      top: 120,
                                      child: Container(
                                          decoration: imageButtonDecor(),
                                          child: IconButton(
                                              onPressed: () async {
                                                getMainImagesFromGallery();
                                              },
                                              icon: imageIcon())))
                                ]),
                                Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Name(
                                              width: width,
                                              nameController: _nameController),
                                          subject(
                                              '${_pet!.type} | ${_pet!.breed}')
                                        ]))
                              ])),
                          label('Pet'),
                          Row(children: [
                            SizedBox(
                                height: 120,
                                width: 170,
                                child: RadioMenuButton(
                                    value: 'Dog',
                                    style: fieldRadio,
                                    groupValue: _pet!.type,
                                    onChanged: (selection) {
                                      setState(() {
                                        selected = selection!;
                                        _pet!.type = selected;
                                      });
                                    },
                                    child: dog())),
                            hspace,
                            SizedBox(
                                height: 120,
                                width: 170,
                                child: RadioMenuButton(
                                    value: 'Cat',
                                    style: fieldRadio,
                                    groupValue: _pet!.type,
                                    onChanged: (selection) {
                                      setState(() {
                                        selected = selection!;
                                        _pet!.type = selected;
                                      });
                                    },
                                    child: cat()))
                          ]),
                          line,
                          label('Breed'),
                          Fields(
                            controller: _breedController,
                            hint: " Enter pet's breed",
                          ),
                          line,
                          label('Appearance and distinctive signs'),
                          TextArea(
                              descriptionController: _descriptionController),
                          line,
                          label('Gender'),
                          Row(children: [
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: RadioMenuButton(
                                  value: 'Female',
                                  style: fieldRadio,
                                  groupValue: _pet!.gender,
                                  onChanged: (selection) {
                                    setState(() {
                                      gender = selection!;
                                      _pet!.gender = gender;
                                    });
                                  },
                                  child: subject('Female')),
                            ),
                            hspace,
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: RadioMenuButton(
                                  value: 'Male',
                                  style: fieldRadio,
                                  groupValue: _pet!.gender,
                                  onChanged: (selection) {
                                    setState(() {
                                      gender = selection!;
                                      _pet!.gender = gender;
                                    });
                                  },
                                  child: subject('Male')),
                            )
                          ]),
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
                                            value: 'Small',
                                            style: fieldRadio,
                                            groupValue: _pet!.size,
                                            onChanged: (selection) {
                                              setState(() {
                                                size = selection!;
                                                _pet!.size = size;
                                              });
                                            },
                                            child:
                                                sizes('Small', 'Under 14Kg'))),
                                    SizedBox(
                                        height: 60,
                                        width: 95,
                                        child: RadioMenuButton(
                                            value: 'Medium',
                                            style: fieldRadio,
                                            groupValue: _pet!.size,
                                            onChanged: (selection) {
                                              setState(() {
                                                size = selection!;
                                                _pet!.size = size;
                                              });
                                            },
                                            child: sizes('Medium', '14-25Kg'))),
                                    SizedBox(
                                        width: 95,
                                        child: RadioMenuButton(
                                            value: 'Huge',
                                            style: fieldRadio,
                                            groupValue: _pet!.size,
                                            onChanged: (selection) {
                                              setState(() {
                                                size = selection!;
                                                _pet!.size = size;
                                              });
                                            },
                                            child: sizes('Huge', 'Over 25Kg')))
                                  ])),
                          line,
                          label('Weight'),
                          Weight(weigthController: _weightController),
                          line,
                          label('Important Dates'),
                          OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  showDatePicker(
                                          context: context,
                                          initialDate: bdate,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now())
                                      .then((value) {
                                    setState(() {
                                      bdate = value!;
                                      formattedBDate = DateFormat('dd-MM-yyyy')
                                          .format(bdate);
                                    });
                                  });
                                });
                              },
                              style: dateButton,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    bday(),
                                    hspace,
                                    subject(formattedBDate)
                                  ])),
                          line,
                          OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  showDatePicker(
                                          context: context,
                                          initialDate: adate,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now())
                                      .then((value) {
                                    setState(() {
                                      adate = value!;
                                      formattedADate = DateFormat('dd-MM-yyyy')
                                          .format(adate);
                                    });
                                  });
                                });
                              },
                              style: dateButton,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    adopt(),
                                    hspace,
                                    subject(formattedADate)
                                  ])),
                          oBSB,
                          FilledButton(
                              onPressed: () async {
                                if (_nameController.text.isEmpty ||
                                    selected.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar());
                                  return;
                                } else {
                                  final pet = PetInfo(
                                      type: selected,
                                      name: _nameController.text.trim(),
                                      breed: _breedController.text.trim(),
                                      description: _descriptionController.text.trim(),
                                      gender: gender,
                                      size: size,
                                      weight: _weightController.text.trim(),
                                      image: image ?? _pet!.image,
                                      bday: formattedBDate,
                                      aday: formattedADate,
                                      isActive: true,
                                      id: _pet!.id);

                                  await _petInfoService
                                      .updatePet(_pet!.id, pet)
                                      .then((_) {
                                    if (mounted) {
                                      setState(() {
                                        _pet = pet;
                                      });
                                    }
                                    Navigator.pop(context, _pet);
                                  });
                                }
                              },
                              style: mainButton,
                              child: const Text('Save'))
                        ]))));
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
