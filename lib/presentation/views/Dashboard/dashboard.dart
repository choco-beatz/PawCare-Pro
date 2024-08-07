import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/dashboard/widgets/active_profile.dart';
import 'package:pawcare_pro/presentation/views/calender/event.dart';
import 'package:pawcare_pro/presentation/views/dashboard/widgets/cardbutton.dart';
import 'package:pawcare_pro/presentation/views/HealthCard/Screens/healthcard_dashboard.dart';
import 'package:pawcare_pro/presentation/views/dashboard/widgets/drawer.dart';
import 'package:pawcare_pro/presentation/views/documents/view_documents.dart';
import 'package:pawcare_pro/presentation/views/nutrition/nutrition_dashbord.dart';
import 'package:pawcare_pro/presentation/views/userprofile/userprofile.dart';
import 'package:pawcare_pro/presentation/views/widgets/appbar.dart';
import 'package:pawcare_pro/service/petinfo_service.dart';

class Dashboard extends StatefulWidget {
  final int? petID;
  const Dashboard({super.key, this.petID});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PetInfoService _petInfoService = PetInfoService();

  //to store all the values that is fetched from db
  List<PetInfo?> _pets = [];
  PetInfo? _pet;

  //loading/fetching data from the hive
  Future<void> _loadPets() async {
    //the datas recived from the db is stored into list
    _pets = await _petInfoService.getPets();
    for (var pet in _pets) {
      if (pet!.isActive == true) {
        _pet = pet;
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.1),
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        width > 600 ? const CustDrawer() : const UserProfile()))),
            child: Appbar(
              bg: mainBG,
            ),
          )),
      backgroundColor: mainBG,
      drawer: const CustDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: _pet == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label('Active Pet Profile'),
                    space,
                    ActiveProfile(
                      petID: _pet!.id,
                    ),
                    space,
                    space,
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewDocuments(
                                            petID: _pet!.id!,
                                          )));
                            },
                            child: CardButton(
                              bg: lightBlue,
                              heading: 'Documents',
                              image: 'asset/document.png',
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HealthCardDashboard(
                                          petId: _pet!.id!,
                                        ))),
                            child: CardButton(
                              bg: lightgreen,
                              heading: 'Health Card',
                              image: 'asset/veterinary.png',
                            ),
                          ),
                        ],
                      ),
                      space,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NutritionDashboard(
                                          petId: _pet!.id!,
                                        ))),
                            child: CardButton(
                              bg: lightRed,
                              heading: 'Nutrition',
                              image: 'asset/pet-food.png',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowEvent(petId: _pet!.id!,)));
                            },
                            child: CardButton(
                              bg: lightPink,
                              heading: 'Calender',
                              image: 'asset/activity.png',
                            ),
                          ),
                        ],
                      )
                    ]),
                  ],
                ),
              ),
      ),
    );
  }
}
