import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';
import 'package:pawcare_pro/presentation/views/addpet/add_pet.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/userprofile/edituserprofile.dart';
import 'package:pawcare_pro/presentation/views/userprofile/widget/usericontext.dart';
import 'package:pawcare_pro/presentation/views/widgets/normalappbar.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';
import 'package:pawcare_pro/service/user_service.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final UserInfoService _userInfoService = UserInfoService();
  final PetInfoService _petInfoService = PetInfoService();

  // late List<UserInfo?> _user;
  UserInfo? _user;
  List<PetInfo?> _pet = [];

  //loading/fetching data from the hive
  Future<void> _loadUser() async {
    //the datas recived from the db is stored
    final userList = await _userInfoService.getuser();
    if (mounted) {
      setState(() {
        if (userList.isNotEmpty) {
          _user = userList.first;
        }
      });
    }
  }

  //loading/fetching data from the hive
  Future<void> _loadPets() async {
    //the datas recived from the db is stored into list
    _pet = await _petInfoService.getPets();
    setState(() {});
  }

  @override
  void initState() {
    _loadUser();
    _loadPets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: mainBG,
        appBar: normalAppBar('User Profile'),
        body: Padding(
            padding: const EdgeInsets.all(20),
            // ignore: unnecessary_null_comparison
            child: _pet == null || _user == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 90,
                                  child: _user!.image.isNotEmpty
                                      ? CircleAvatar(
                                          backgroundImage:
                                              FileImage(File(_user!.image)),
                                          radius: 70,
                                        )
                                      : const CircleAvatar(
                                          radius: 70,
                                          backgroundColor: transparent1,
                                          child: FaIcon(
                                            size: 60,
                                            FontAwesomeIcons.user,
                                            color: white,
                                          ))),
                              Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        heading2(_user!.username),
                                        subject('You')
                                      ]))
                            ])),
                        sizedBox,
                        label('Pets Owned'),
                        space,
                        SizedBox(
                            width: width > 600 ? width * 0.9 : width,
                            height:
                                width > 600 ? height * 0.05 : height * 0.162,
                            child: Row(children: [
                              SizedBox(
                                  width:
                                      width > 600 ? width * 0.7 : width * 0.69,
                                  height: width > 600
                                      ? height * 0.05
                                      : height * 0.16,
                                  child: ListView.builder(
                                      itemCount: _pet.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final current = _pet[index];

                                        return GestureDetector(
                                            onDoubleTap: () {
                                              _petInfoService
                                                  .deletePet(current.id);
                                              setState(() {});
                                            },
                                            onTap: () {
                                              _petInfoService.updateIsActive(
                                                  current.id, current);
                                              setState(() {});
                                            },
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Column(children: [
                                                  CircleAvatar(
                                                      radius: width > 600
                                                          ? width * 0.05
                                                          : width * 0.1,
                                                      backgroundColor:
                                                          current!.isActive ==
                                                                  true
                                                              ? mainColor
                                                              : grey,
                                                      child: current
                                                              .image.isEmpty
                                                          ? CircleAvatar(
                                                              backgroundColor:
                                                                  mainBG,
                                                              radius:
                                                                  width > 600
                                                                      ? width *
                                                                          0.045
                                                                      : width *
                                                                          0.09,
                                                              child:
                                                                  const FaIcon(
                                                                size: 50,
                                                                FontAwesomeIcons
                                                                    .paw,
                                                                color: white,
                                                              ))
                                                          : CircleAvatar(
                                                              radius:
                                                                  width > 600
                                                                      ? width *
                                                                          0.045
                                                                      : width *
                                                                          0.09,
                                                              backgroundImage:
                                                                  FileImage(File(
                                                                      current
                                                                          .image)))),
                                                  space,
                                                  Text(
                                                    current.name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            current.isActive ==
                                                                    true
                                                                ? mainColor
                                                                : grey,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ])));
                                      })),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Column(children: [
                                    GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const AddPet()))),
                                        child: CircleAvatar(
                                            radius: width > 600
                                                ? width * 0.05
                                                : width * 0.1,
                                            backgroundColor: lightGrey,
                                            child: CircleAvatar(
                                                radius: width > 600
                                                    ? width * 0.045
                                                    : width * 0.09,
                                                backgroundColor: black54,
                                                child: userIcon1()))),
                                    space,
                                    userText1()
                                  ]))
                            ])),
                        Spacer(),
                        FilledButton(
                          onPressed: () async {
                            final updatedUser = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditUserProfile(
                                          userIndex: 0,
                                          user: _user!,
                                        )));
                            if (updatedUser != null) {
                              setState(() {
                                _user = updatedUser;
                              });
                            }
                          },
                          style: mainButton,
                          child: const Text('Edit'),
                        )
                      ])));
  }
}
