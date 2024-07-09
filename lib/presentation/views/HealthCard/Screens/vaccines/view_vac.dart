import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';

class ViewVac extends StatelessWidget {
  final String name;
  final String idate;
  final String edate;

  ViewVac({
    super.key,
    required this.edate,
    required this.idate,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: white,
          title: const Text(
            'Vaccinations',
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: mainBG,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label(name),
              sizedBox,
              sizedBox,
              sizedBox,
              label('Date'),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [subject2('Issued Date'), leading(idate)],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [subject2('Expiry Date'), leading(edate)],
                  ),
                ],
              ),
              Spacer(),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: mainButton,
                child: const Text('Done'),
              )
            ],
          ),
        ));
  }
}
