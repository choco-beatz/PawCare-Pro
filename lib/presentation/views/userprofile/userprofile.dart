import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';
import 'package:pawcare_pro/presentation/views/addpet/add_pet.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/userprofile/edituserprofile.dart';
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

  //to store all the values that is fetched from db
  // List<PetInfo> _pet = [];
  late List<UserInfo?> _user;
  List<PetInfo?> _pet = [];

  //loading/fetching data from the hive
  Future<void> _loadUser() async {
    //the datas recived from the db is stored
    _user = await _userInfoService.getuser();
    if (mounted) {
      setState(() {});
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
        backgroundColor: mainBG,
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: Colors.white,
          title: const Text(
            'User Profile',
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            // ignore: unnecessary_null_comparison
            child: _pet == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 90,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        FileImage(File(_user.first!.image)),
                                    radius: 70,
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    heading2(_user.first!.username),
                                    subject('You')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        sizedBox,
                        label('Pets Owned'),
                        space,
                        Row(
                          children: [
                            SizedBox(
                                width: width * 0.69,
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
                                        _petInfoService.updateIsActive(
                                            current.id, current);
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: width * 0.1,
                                              backgroundColor:
                                                  current!.isActive == true
                                                      ? mainColor
                                                      : grey,
                                              child: CircleAvatar(
                                                radius: width * 0.09,
                                                backgroundImage: FileImage(
                                                    File(current.image)),
                                              ),
                                            ),
                                            space,
                                            Text(
                                              current.name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color:
                                                      current.isActive == true
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
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => AddPet()))),
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
                        SizedBox(height: height * 0.27),
                        FilledButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditUserProfile()));
                          },
                          style: mainButton,
                          child: const Text('Edit'),
                        )
                      ]))));
  }
}
