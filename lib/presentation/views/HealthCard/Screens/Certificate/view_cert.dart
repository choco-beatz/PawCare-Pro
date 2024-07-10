import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
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
    final String fileName = path.basename(file);
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: white,
          title: const Text(
            'Certificate',
            style: TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: mainBG,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox,
              Center(
                child: GestureDetector(
                  onTap: () async {
                    cert = await file;
                    OpenFile.open(cert);
                  },
                  child: CircleAvatar(
                      backgroundColor: grey,
                      radius: 95,
                      child: CircleAvatar(
                          backgroundColor: transGrey,
                          radius: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                  color: white,
                                  size: 65,
                                  Icons.file_open_outlined),
                              sSpace,
                              eventicon('Tap to view the file')
                            ],
                          ))),
                ),
              ),
              sizedBox,
              label(name),
              sizedBox,
              eventicon(fileName),
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
