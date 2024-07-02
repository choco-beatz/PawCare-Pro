import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/presentation/views/addpet/add_pet.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/calender/event.dart';
import 'package:pawcare_pro/presentation/views/dashboard/widgets/drawerfunctions.dart';
import 'package:pawcare_pro/presentation/views/userprofile/userprofile.dart';
import 'package:pawcare_pro/presentation/views/widgets/aboutus.dart';
import 'package:pawcare_pro/presentation/views/widgets/appbar.dart';
import 'package:pawcare_pro/presentation/views/widgets/privacydialoge.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';

class CustDrawer extends StatefulWidget {
  const CustDrawer({super.key});

  @override
  State<CustDrawer> createState() => _CustDrawerState();
}

class _CustDrawerState extends State<CustDrawer> {
  final PetInfoService _petInfoService = PetInfoService();

  //to store all the values that is fetched from db
  List<PetInfo?> _pet = [];
  // late PetInfo? _pet;

  //loading/fetching data from the hive
  Future<void> _loadPets() async {
    //the datas recived from the db is stored into list
    _pet = await _petInfoService.getPets();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(children: [
        SizedBox(
            height: height * 0.15,
            child: DrawerHeader(
              child: Appbar(bg: Colors.black),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: leading('Your Pets'),
        ),
        space,
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              SizedBox(
                  width: width * 0.5,
                  height: height * 0.16,
                  child: ListView.builder(
                    itemCount: _pet.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final current = _pet[index];

                      return GestureDetector(
                        onDoubleTap: () {
                          _petInfoService.deletePet(current.id);
                          setState(() {});
                        },
                        onTap: () {
                          _petInfoService.updateIsActive(current.id, current);
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: width * 0.1,
                                backgroundColor: current!.isActive == true
                                    ? mainColor
                                    : grey,
                                child: current.image.isEmpty
                                    ? CircleAvatar(
                                        backgroundColor: mainBG,
                                        radius: width * 0.09,
                                        child: const FaIcon(
                                          size: 50,
                                          FontAwesomeIcons.paw,
                                          color: Colors.white,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: width * 0.09,
                                        backgroundImage:
                                            FileImage(File(current.image)),
                                      ),
                              ),
                              space,
                              Text(
                                current.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: current.isActive == true
                                        ? mainColor
                                        : grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => AddPet()))),
                      child: CircleAvatar(
                          radius: width * 0.1,
                          backgroundColor: lightGrey,
                          child: CircleAvatar(
                              radius: width * 0.09,
                              backgroundColor: Colors.black54,
                              child: const Icon(
                                Icons.add,
                                color: lightGrey,
                                size: 40,
                              ))),
                    ),
                    space,
                    const Text(
                      'Add pet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: lightGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        line,
        GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const UserProfile()))),
            child: DrawerList(
                icon: Icons.person_outline_outlined, text: 'User Account')),
        GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return PrivacyDialoge(mdFileName: 'termsandconditions.md');
                  });
            },
            child: DrawerList(
                icon: Icons.file_present_outlined,
                text: 'Terms and Conditions')),
        line,
        GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return PrivacyDialoge(mdFileName: 'privacypolicy.md');
                  });
            },
            child: DrawerList(
                icon: Icons.lock_outline_rounded, text: 'Privacy policy')),
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const AboutUs())));
            },
            child: DrawerList(icon: Icons.info_outlined, text: 'About us')),
      ]),
    );
  }
}
