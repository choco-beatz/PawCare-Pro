import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/colors.dart';

final appBar = PreferredSize(
  preferredSize: Size.fromHeight(115),
  child: AppBar(
    toolbarHeight: double.infinity,
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    title: const ListTile(
      title: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          'Hello,',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      subtitle: Text(
        'Username',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      leading: Padding(
        padding: EdgeInsets.only(bottom: 40, right: 15),
        child: CircleAvatar(
          backgroundColor: mainBG,
          child: FaIcon(
            size: 65,
            FontAwesomeIcons.circleUser,
            color: Colors.white,
          ),
        ),
      ),
    ),
    backgroundColor: mainBG,
    foregroundColor: Colors.white,
  ),
);
