import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/document%20model/document.dart';
import 'package:pawcare_pro/presentation/views/documents/add_documents.dart';
import 'package:pawcare_pro/presentation/views/documents/view_documents.dart';

class EmptyDoc extends StatelessWidget {
  final int petId;
  const EmptyDoc({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mainBG,
      body: Padding(
        padding: const EdgeInsets.only(right: 25, left: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.14,
              ),
              SizedBox(
                height: height * 0.24,
                width: width * 0.5,
                child: const Image(
                  fit: BoxFit.fill,
                  image: AssetImage('asset/story.png'),
                ),
              ),
              space,
              space,
              heading('No documents added'),
              sizedBox,
              subject(
                  "Organize your pet's vaccinations effortlessly. Store certificates for complete care."),
              SizedBox(height: height * 0.15),
              OutlinedButton(
                  onPressed: () async {
                    final result = await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDocuments(petId: petId),
                      ),
                    );

                    if (result != null && result is Documents) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewDocuments(petID: petId),
                        ),
                      );
                    }
                  },
                  style: dateButton,
                  child: subject('Add Documents +'))
            ],
          ),
        ),
      ),
    );
  }
}
