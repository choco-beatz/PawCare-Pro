import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/presentation/views/PetProfile/petprofile.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';

class ActiveProfile extends StatefulWidget {
  final int? petID;
  const ActiveProfile({super.key, this.petID});

  @override
  State<ActiveProfile> createState() => _ActiveProfileState();
}

class _ActiveProfileState extends State<ActiveProfile> {
  final PetInfoService _petInfoService = PetInfoService();

  //to store all the values that is fetched from db
  // List<PetInfo?> _pet = [];
  PetInfo? _pet;

  //loading/fetching data from the hive
  Future<void> _loadPets() async {
    //the datas recived from the db is stored into list
    _pet = await _petInfoService.getPet(widget.petID);
    setState(() {});
  }

  @override
  void initState() {
    _loadPets();
    super.initState();
  }

  //for image

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (_pet == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Stack(children: [
      GestureDetector(
        onTap: () async {
          final updatedPetInfo = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetProfile(
                petId: _pet!.id,
              ),
            ),
          );

          if (updatedPetInfo != null && updatedPetInfo is PetInfo) {
            setState(() {
              _pet = updatedPetInfo;
            });
          }
        },
        child: Container(
          height: width > 600 ? height * 0.225 : height * 0.18,
          decoration: BoxDecoration(
              color: mainColor, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    heading2(_pet!.name),
                    subject('${_pet!.type} | ${_pet!.breed}')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
          left: width > 600 ? width * 0.8 : 160,
          top: -45,
          child: CircleAvatar(
              backgroundColor: transparent3,
              radius: 120,
              child: CircleAvatar(
                  backgroundColor: transparent2,
                  radius: 100,
                  child: CircleAvatar(
                      backgroundColor: transparent1,
                      radius: 80,
                      child: _pet!.image.isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: FileImage(File(_pet!.image)),
                              radius: 65,
                            )
                          : const CircleAvatar(
                              radius: 80,
                              backgroundColor:
                                  transparent1,
                              child: FaIcon(
                                size: 100,
                                FontAwesomeIcons.paw,
                                color: white,
                              ))))))
    ]);
  }
}
