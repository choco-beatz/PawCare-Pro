import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/certificate%20model/certificate.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/healthcard/Screens/Certificate/add_certificates.dart';
import 'package:pawcare_pro/presentation/views/healthcard/widgets/bottom_sheet.dart';
import 'package:pawcare_pro/service/certificate_services.dart';

class ViewCertificates extends StatefulWidget {
  const ViewCertificates({super.key});

  @override
  State<ViewCertificates> createState() => _ViewCertificatesState();
}

class _ViewCertificatesState extends State<ViewCertificates> {
  final CertificateService _certificateService = CertificateService();

  //for file
  String? file;

  //we get all the datas in the db as list of type model
  List<Certificate> _certificate = [];

  //loading/fetching data from the hive
  Future<void> _loadCertificates() async {
    //the datas recived from the db is stored
    _certificate = await _certificateService.getCertificates();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _loadCertificates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: Colors.white,
          title: const Text(
            'Certificates',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  //the result(certificate object) which is passed from the pop is recieved here
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AddCertificates())));

                  //to check if the returned result is not null and they type is Certificate
                  if (result != null && result is Certificate) {
                    setState(() {
                      //the result that is recieved is added to the List that is to be displayed
                      _certificate.add(result);
                    });
                  }
                },
                icon: const Icon(
                  Icons.add,
                  color: mainColor,
                ))
          ],
        ),
        backgroundColor: mainBG,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: _certificate.length,
            itemBuilder: (context, index) {
              final current = _certificate[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  color: grey,
                  child: ListTile(
                    
                    onTap: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: height * 0.62,
                              decoration: bottomSheetStyle,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          file = current.file;
                                        },
                                        child: file != null
                                            ? const CircleAvatar(
                                                backgroundColor: grey,
                                                radius: 95,
                                                child: CircleAvatar(
                                                    backgroundColor: lightGrey,
                                                    radius: 80,
                                                    child: FaIcon(
                                                        color: Colors.white,
                                                        size: 100,
                                                        FontAwesomeIcons
                                                            .fileCirclePlus)))
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
                                    space,
                                    space,
                                    label(current.name),
                                    space,
                                    space,
                                    label('Date'),
                                    space,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            subject2('Issued Date'),
                                            leading(current.idate)
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            subject2('Expiry Date'),
                                            leading(current.edate)
                                          ],
                                        )
                                      ],
                                    ),
                                    space,
                                    space,
                                    space,
                                    FilledButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Done'),
                                      style: mainButton,
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    trailing: IconButton(
                        onPressed: () async {
                          await _certificateService.deleteCertificate(current.id);
                          print('object');
                          setState(() {
                            _certificate.removeAt(index);
                          });
                        },
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          size: 35,
                          color: Color.fromARGB(255, 211, 211, 211),
                        )),
                    title: leading(current.name),
                    subtitle: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.calendar_today,
                            color: Color.fromARGB(255, 211, 211, 211),
                            size: 18,
                          ),
                        ),
                        subject2(current.idate)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
