import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/circleimage.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/icons.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/imagebuttondecor.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/dashboard/dashboard.dart';
import 'package:pawcare_pro/presentation/views/widgets/normalappbar.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPet extends StatefulWidget {
  const AddPet({super.key});
  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  //for radio
  String selected = 'none';
  String gender = 'none';
  String size = 'none';
  //for image
  String? image;
  //for dates
  DateTime bdate = DateTime.now();
  DateTime adate = DateTime.now();
  String formattedADate = 'Not set';
  String formattedBDate = 'Not set';
  final PetInfoService _petInfoService = PetInfoService();
  late PetInfo? pet;
  //TextEditingControllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _weigthController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: mainBG,
        appBar: normalAppBar('Add Pet Profile'),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(clipBehavior: Clip.none, children: [
                        CircleImage(image: image),
                        Positioned(
                            left: width > 600 ? width * 0.5 : 215,
                            top: 210,
                            child: Container(
                                decoration: imageButtonDecor(),
                                child: IconButton(
                                    onPressed: () async {
                                      getMainImagesFromGallery();
                                    },
                                    icon: imageIcon())))
                      ]),
                      label('Pet'),
                      Row(
                        children: [
                          SizedBox(
                              height: 120,
                              width: 170,
                              child: RadioMenuButton(
                                  value: 'Dog',
                                  style: fieldRadio,
                                  groupValue: selected,
                                  onChanged: (selection) {
                                    setState(() {
                                      selected = selection!;
                                    });
                                  },
                                  child: dog())),
                          hspace,
                          SizedBox(
                              height: 120,
                              width: 170,
                              child: RadioMenuButton(
                                  value: 'Cat',
                                  style: fieldRadio,
                                  groupValue: selected,
                                  onChanged: (selection) {
                                    setState(() {
                                      selected = selection!;
                                    });
                                  },
                                  child: cat()))
                        ],
                      ),
                      line,
                      label('Name'),
                      Fields(
                        controller: _nameController,
                        hint: " Enter pet's name",
                      ),
                      line,
                      label('Breed'),
                      Fields(
                        controller: _breedController,
                        hint: " Enter pet's breed",
                      ),
                      line,
                      label('Appearance and distinctive signs'),
                      TextArea(descriptionController: _descriptionController),
                      line,
                      label('Gender'),
                      Row(children: [
                        SizedBox(
                          height: 60,
                          width: 170,
                          child: RadioMenuButton(
                              value: 'Female',
                              style: fieldRadio,
                              groupValue: gender,
                              onChanged: (selection) {
                                setState(() {
                                  gender = selection!;
                                });
                              },
                              child: subject('Female')),
                        ),
                        hspace,
                        SizedBox(
                            height: 60,
                            width: 170,
                            child: RadioMenuButton(
                                value: 'Male',
                                style: fieldRadio,
                                groupValue: gender,
                                onChanged: (selection) {
                                  setState(() {
                                    gender = selection!;
                                  });
                                },
                                child: subject('Male')))
                      ]),
                      line,
                      label('Size'),
                      SizedBox(
                          height: 180,
                          child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              childAspectRatio: 2.1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: [
                                SizedBox(
                                    height: 60,
                                    width: 70,
                                    child: RadioMenuButton(
                                        value: 'Small',
                                        style: fieldRadio,
                                        groupValue: size,
                                        onChanged: (selection) {
                                          setState(() {
                                            size = selection!;
                                          });
                                        },
                                        child: sizes('Small', 'Under 14Kg'))),
                                SizedBox(
                                    height: 60,
                                    width: 70,
                                    child: RadioMenuButton(
                                        value: 'Medium',
                                        style: fieldRadio,
                                        groupValue: size,
                                        onChanged: (selection) {
                                          setState(() {
                                            size = selection!;
                                          });
                                        },
                                        child: sizes('Medium', '14-25Kg'))),
                                SizedBox(
                                    width: 70,
                                    child: RadioMenuButton(
                                        value: 'Huge',
                                        style: fieldRadio,
                                        groupValue: size,
                                        onChanged: (selection) {
                                          setState(() {
                                            size = selection!;
                                          });
                                        },
                                        child: sizes('Huge', 'Over 25Kg')))
                              ])),
                      line,
                      label('Weight'),
                      Weight(weigthController: _weigthController),
                      line,
                      label('Important Dates'),
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              showDatePicker(
                                      context: context,
                                      initialDate: bdate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now())
                                  .then((value) {
                                setState(() {
                                  bdate = value!;
                                  formattedBDate =
                                      DateFormat('dd-MM-yyyy').format(bdate);
                                });
                              });
                            });
                          },
                          style: dateButton,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                bday(),
                                hspace,
                                formattedBDate == 'Not set'
                                    ? subject('Add Birth date')
                                    : subject(formattedBDate)
                              ])),
                      line,
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              showDatePicker(
                                      context: context,
                                      initialDate: adate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now())
                                  .then((value) {
                                setState(() {
                                  adate = value!;
                                  formattedADate =
                                      DateFormat('dd-MM-yyyy').format(adate);
                                });
                              });
                            });
                          },
                          style: dateButton,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                adopt(),
                                hspace,
                                formattedADate == 'Not set'
                                    ? subject('Add Adoption date')
                                    : subject(formattedADate)
                              ])),
                      space,
                      space,
                      FilledButton(
                          onPressed: () async {
                            if (_nameController.text.isEmpty ||
                                selected.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar());
                              return;
                            } else {
                              final pet = PetInfo(
                                  type: selected,
                                  name: _nameController.text,
                                  breed: _breedController.text,
                                  description: _descriptionController.text,
                                  gender: gender,
                                  size: size,
                                  weight: _weigthController.text,
                                  image: image ?? '',
                                  bday: formattedBDate,
                                  aday: formattedADate,
                                  id: DateTime.now().microsecond,
                                  isActive: false);

                              await _petInfoService.addPet(pet);
                              await _petInfoService.updateIsActive(pet.id, pet);
                              setState(() {});
                              final SharedPreferences sP =
                                  await SharedPreferences.getInstance();
                              sP.setString('petname', pet.name);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard(
                                            petID: pet.id,
                                          )));
                            }
                          },
                          style: mainButton,
                          child: const Text('Save'))
                    ]))));
  }

  Future getMainImagesFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000);
    XFile xfilePick = pickedFile!;

    setState(() {
      image = xfilePick.path;
    });
  }
}

