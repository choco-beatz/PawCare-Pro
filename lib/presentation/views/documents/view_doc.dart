import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:open_file/open_file.dart';
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
  ViewDoc({super.key,required this.dedate,required this.didate,required this.dname,required this.dfile});

  String? file;

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
              label(dname),
              sizedBox,
              sizedBox,
              Center(
                child: GestureDetector(
                  onTap: () async {
                    file = await dfile;
                  },
                  child: file != null
                      ? GestureDetector(
                          onTap: () async {
                            final result = await OpenFile.open(file);
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
                  )
                ],
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
