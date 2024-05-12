import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/presentation/views/AddPet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/PetProfile/petprofile.dart';
import 'package:pawcare_pro/presentation/views/widgets/appbar.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';

class Dashboard extends StatefulWidget {
  final int? petID;
  const Dashboard({super.key, this.petID});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PetInfoService _petInfoService = PetInfoService();

  //to store all the values that is fetched from db
  // List<PetInfo?> _pet = [];
  late PetInfo? _pet;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(115), child: Appbar()),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PetProfile(petId: _pet!.id,)));
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
                  left: 160,
                  top: -50,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(28, 196, 229, 255),
                    radius: 120,
                    child: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(80, 196, 229, 255),
                        radius: 100,
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(100, 196, 229, 255),
                          radius: 80,
                          child: _pet!.image != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      FileImage(File(_pet!.image ?? '')),
                                  radius: 65,
                                )
                              : const CircleAvatar(
                                  radius: 65,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                        )),
                  ))
            ])
          ],
        ),
      ),
    );
  }
}
