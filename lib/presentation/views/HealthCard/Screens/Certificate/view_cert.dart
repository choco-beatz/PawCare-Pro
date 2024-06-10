import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:open_file/open_file.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';

class ViewCert extends StatelessWidget {
  final String name;
  final String idate;
  final String edate;
  final String file;
  ViewCert(
      {super.key,
      required this.edate,
      required this.idate,
      required this.name,
      required this.file});

  String? cert;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: Colors.white,
          title: const Text(
            'Documents',
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
              Center(
                child: GestureDetector(
                  onTap: () async {
                    cert = await file;
                  },
                  child: cert != null
                      ? GestureDetector(
                          onTap: () async {
                            final result = await OpenFile.open(cert);
                            print(result.message);
                          },
                          child: const CircleAvatar(
                              backgroundColor: grey,
                              radius: 95,
                              child: CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 80,
                                  child: FaIcon(
                                      color: Colors.white,
                                      size: 65,
                                      FontAwesomeIcons.fileCirclePlus))),
                        )
                      : const CircleAvatar(
                          backgroundColor: grey,
                          radius: 95,
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 80,
                            child: Icon(
                              size: 65,
                              Icons.file_copy_outlined,
                              color: Colors.white,
                            ),
                          )),
                ),
              ),
              sizedBox,
              sizedBox,
              sizedBox,
              sizedBox,
              label('Date'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [subject2('Issued Date'), leading(idate)],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [subject2('Expiry Date'), leading(edate)],
              ),
              SizedBox(
                height: height * 0.2,
              ),
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
