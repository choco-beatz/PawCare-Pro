import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/textField.dart';

final fieldRadio = ButtonStyle(
    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: lightGrey, width: 1))),
    backgroundColor: const MaterialStatePropertyAll(fieldColor));

const line = Divider(
  thickness: 1.5,
  color: grey,
  height: 25,
);

sizes(String text, String weigth) {
  return SizedBox(
      width: 116,
      child: ListTile(
          title: Text(
            text,
            style: const TextStyle(color: white, fontSize: 18),
          ),
          subtitle: Text(
            weigth,
            style: const TextStyle(color: white),
          )));
}

class Fields extends StatelessWidget {
  String hint;
  Fields({
    super.key,
    required this.hint,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: 370,
      child: TextFormField(
        
        cursorColor: white,
        style: const TextStyle(color: white, fontSize: 20),
        decoration: fieldDecor(hint),
        controller: _controller,
      ),
    );
  }
}

SnackBar snackBar() {
  return const SnackBar(content: Text('Please Enter the neccessary details!'));
}

class TextArea extends StatelessWidget {
  const TextArea({
    super.key,
    required TextEditingController descriptionController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      child: TextFormField(
          cursorColor: white,
          style: const TextStyle(color: white, fontSize: 20),
          maxLines: 4,
          decoration: fieldDecor(" Enter Appearance and distinctive signs"),
          controller: _descriptionController),
    );
  }
}

class Weight extends StatelessWidget {
  const Weight({
    super.key,
    required TextEditingController weigthController,
  }) : _weigthController = weigthController;

  final TextEditingController _weigthController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: 370,
      child: TextFormField(
        cursorColor: white,
        style: const TextStyle(color: white, fontSize: 20),
        decoration: fieldDecor("Enter Weight in Kg"),
        controller: _weigthController,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
