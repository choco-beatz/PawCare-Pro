import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';
import 'package:pawcare_pro/service/user_service.dart';

class CustDrawerHeader extends StatefulWidget {
  const CustDrawerHeader({super.key});

  @override
  State<CustDrawerHeader> createState() => _CustDrawerHeaderState();
}

class _CustDrawerHeaderState extends State<CustDrawerHeader> {
  final UserInfoService _userInfoService = UserInfoService();

  //to store all the values that is fetched from db
  List<UserInfo> _user = [];

  //loading/fetching data from the hive
  Future<void> _loadUsers() async {
    //the datas recived from the db is stored into list
    _user = await _userInfoService.getuser();
    setState(() {});
  }

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _user.isEmpty
        ? ListTile(
            title: const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Hello,',
                style: TextStyle(
                    color: white, fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            subtitle: leading('Username'),
            leading: const CircleAvatar(
              backgroundColor: mainBG,
              child: CircleAvatar(
                radius: 70,
                child: FaIcon(
                  size: 65,
                  FontAwesomeIcons.person,
                  color: white,
                ),
              ),
            ),
          )
        : ListTile(
            title: const Text(
              'Hello,',
              style: TextStyle(
                  color: white, fontSize: 16, fontWeight: FontWeight.w400),
            ),
            subtitle: Text(
              _user.first.username,
              style: const TextStyle(
                  color: white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            leading: CircleAvatar(
                radius: 30,
                backgroundColor: mainBG,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(File(_user.first.image)),
                )),
          );
  }
}
