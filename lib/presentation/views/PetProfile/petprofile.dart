import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';

import 'package:pawcare_pro/presentation/views/add_pet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/add_pet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/editpetprofile/editpetprofile.dart';

import 'package:pawcare_pro/presentation/views/PetProfile/widgets/data_style.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';

class PetProfile extends StatefulWidget {
  final int? petId;
  const PetProfile({super.key, this.petId});

  @override
  State<PetProfile> createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  final PetInfoService _petInfoService = PetInfoService();

  //to store all the values that is fetched from db
  // List<PetInfo> _pet = [];
  PetInfo? _pet;

  //loading/fetching data from the hive
  Future<void> _loadPets() async {
    //the datas recived from the db is stored
    _pet = await _petInfoService.getPet(widget.petId);
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
                  CircleAvatar(
                    backgroundColor: lightGrey,
                    radius: 90,
                    child: _pet!.image != null
                        ? CircleAvatar(
                            backgroundImage:
                                FileImage(File(_pet!.image ?? '')),
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
              space,
              space,
              label('Appearence and distinctive signs'),
              subject2(_pet!.description),
              space,
              line,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [subject2('Gender'), label2(_pet!.gender)],
              ),
              line,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [subject2('Size'), label2(_pet!.size)],
              ),
              line,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [subject2('Weight'), label2(_pet!.weight)],
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
                subtitle: label2(_pet!.bday),
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
                subtitle: label2(_pet!.aday),
              ),
              space,
              space,
              space,
              space,
              FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPetProfile(PetID: _pet!.id,)));
                  },
                  style: mainButton,
                  child: const Text('Edit'))
            ],
          ),
        ),
      ),
    );
  }
}
