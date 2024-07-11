import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';

class NoEvent extends StatelessWidget {
  const NoEvent({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: height * 0.35,
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              SizedBox(
                height: height * 0.15,
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage('asset/noevent.png'),
                ),
              ),
              sizedBox,
              subject('No events on this day')
            ])));
  }
}
