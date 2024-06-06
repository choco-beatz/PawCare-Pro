import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/vaccine%20model/vaccine.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/presentation/views/healthcard/screens/vaccines/add_vaccines.dart';
import 'package:pawcare_pro/presentation/views/healthcard/screens/vaccines/emptyvaccine.dart';
import 'package:pawcare_pro/presentation/views/healthcard/widgets/bottom_sheet.dart';
import 'package:pawcare_pro/service/vaccine_services.dart';

class ViewVaccines extends StatefulWidget {
  final int petId;
  const ViewVaccines({super.key, required this.petId});

  @override
  State<ViewVaccines> createState() => _ViewVaccinesState();
}

class _ViewVaccinesState extends State<ViewVaccines> {
  final VaccineService _vaccineService = VaccineService();

  //we get all the datas in the db as list of type model
  List<Vaccine> _vaccine = [];
  List<Vaccine> currentVaccine = [];

  //loading/fetching data from the hive
  Future<void> _loadVaccines() async {
    //the datas recived from the db is stored
    _vaccine = await _vaccineService.getVaccines();
    for (var vac in _vaccine) {
      if (widget.petId == vac.petId) {
        currentVaccine.add(vac);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _loadVaccines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: Colors.white,
          title: const Text(
            'Vaccines',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  //the result(vaccine object) which is passed from the pop is recieved here
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => AddVaccines(
                                petId: widget.petId,
                              ))));

                  //to check if the returned result is not null and they type is Certificate
                  if (result != null && result is Vaccine) {
                    setState(() {
                      //the result that is recieved is added to the List that is to be displayed
                      _vaccine.add(result);
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
          child: currentVaccine.isEmpty
              ? EmptyVaccine(
                  petId: widget.petId,
                )
              : ListView.builder(
                  itemCount: currentVaccine.length,
                  itemBuilder: (context, index) {
                    final current = currentVaccine[index];
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
                                    height: height * 0.31,
                                    decoration: bottomSheetStyle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          label(current.name),
                                          label('Date'),
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
                                            style: mainButton,
                                            child: const Text('Done'),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          trailing: IconButton(
                              onPressed: () async {
                                await _vaccineService.deleteVaccine(current.id);
                                print('object');
                                setState(() {
                                  _vaccine.removeAt(index);
                                });
                              },
                              icon: const Icon(
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
