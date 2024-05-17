import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/certificate%20model/certificate.dart';
import 'package:pawcare_pro/service/certificate_services.dart';

class ViewCertificates extends StatefulWidget {
  const ViewCertificates({super.key});

  @override
  State<ViewCertificates> createState() => _ViewCertificatesState();
}

class _ViewCertificatesState extends State<ViewCertificates> {
  final CertificateService _certificateService = CertificateService();

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
                onPressed: () {
                  print(_certificate);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => AddCertificates())));
                },
                icon: Icon(
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
                      
                    },
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
