import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';

class ViewDoc extends StatelessWidget {
  final String dname;
  final String didate;
  final String dedate;
  final String dfile;
  ViewDoc(
      {super.key,
      required this.dedate,
      required this.didate,
      required this.dname,
      required this.dfile});

  String? file;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final String fileName = path.basename(dfile);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: white,
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
              sizedBox,
              Center(
                child: GestureDetector(
                  onTap: () async {
                    file = await dfile;

                    OpenFile.open(file);
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
              label(dname),
              sizedBox,
              eventicon(fileName),
              sizedBox,
              label('Date'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [subject2('Issued Date'), leading(didate)],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [subject2('Expiry Date'), leading(dedate)],
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
