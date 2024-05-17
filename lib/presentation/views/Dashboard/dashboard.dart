import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/domain/pet%20model/pet.dart';
import 'package:pawcare_pro/presentation/views/AddPet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/Dashboard/widgets/active_profile.dart';
import 'package:pawcare_pro/presentation/views/Dashboard/widgets/healthcard.dart';
import 'package:pawcare_pro/presentation/views/HealthCard/Screens/healthcard_dashboard.dart';
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
  // List<PetInfo?> _pet = [];
  late PetInfo? _pet;

  //loading/fetching data from the hive
  Future<void> _loadPets() async {
    //the datas recived from the db is stored into list
    _pet = await _petInfoService.getPet(widget.petID);
    setState(() {});
  }

  @override
  void initState() {
    _loadPets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(115), child: Appbar()),
      backgroundColor: mainBG,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label('Active Pet Profile'),
            space,
            ActiveProfile(
              petID: _pet!.id,
            ),
            space,
            Column(children: [
              Row(
                children: [
                  CardButton(
                    bg: lightBlue,
                    heading: 'Documents',
                    image: 'asset/document.png',
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HealthCardDashboard())),
                    child: CardButton(
                      bg: lightgreen,
                      heading: 'Health Card',
                      image: 'asset/veterinary.png',
                    ),
                  )
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
