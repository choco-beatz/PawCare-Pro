import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/user%20model/user.dart';
import 'package:pawcare_pro/service/user_service.dart';

class Appbar extends StatefulWidget {
  final Color bg;
  Appbar({super.key, required this.bg});

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
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
    return AppBar(
      toolbarHeight: double.infinity,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: _user.isEmpty
          ? ListTile(
              title: const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Hello,',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              subtitle: Text(
                leading('Username'),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              leading: const CircleAvatar(
                backgroundColor: mainBG,
                child: CircleAvatar(
                  radius: 70,
                  child: FaIcon(
                    size: 65,
                    FontAwesomeIcons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : ListTile(
              title: Text(
                'Hello,',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              subtitle: Text(
                _user.first.username,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: mainBG,
                  child: CircleAvatar(
                    backgroundImage: FileImage(File(_user.first.image)),
                    radius: 80,
                  )),
            ),
      backgroundColor: widget.bg,
      foregroundColor: Colors.white,
    );
  }
}
