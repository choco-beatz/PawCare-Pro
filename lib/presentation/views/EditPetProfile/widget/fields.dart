import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/constant/textField.dart';

class Name extends StatelessWidget {
  const Name({
    super.key,
    required this.width,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final double width;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: width * 0.4,
      child: TextFormField(
        cursorColor: white,
        style: name,
        decoration: nameField('Name'),
        controller: _nameController,
      ),
    );
  }
}
