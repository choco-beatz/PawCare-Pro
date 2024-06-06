import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/document%20model/document.dart';
import 'package:pawcare_pro/presentation/views/documents/add_documents.dart';
import 'package:pawcare_pro/presentation/views/documents/emptydocument.dart';
import 'package:pawcare_pro/presentation/views/documents/view_doc.dart';
import 'package:pawcare_pro/service/document_services.dart';

class ViewDocuments extends StatefulWidget {
  final int petID;
  const ViewDocuments({super.key, required this.petID});

  @override
  State<ViewDocuments> createState() => _ViewDocumentsState();
}

class _ViewDocumentsState extends State<ViewDocuments> {
  final DocumentService _documentService = DocumentService();

  //we get all the datas in the db as list of type model
  List<Documents> _document = [];
  List<Documents> newDocuments = [];

  //loading/fetching data from the hive
  Future<void> _loadDocument() async {
    //the datas recived from the db is stored
    _document = await _documentService.getdocuments();
    for (var doc in _document) {
      if (widget.petID == doc.petID) {
        newDocuments.add(doc);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _loadDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainBG,
          foregroundColor: Colors.white,
          title: const Text(
            'Documents',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  //the result(vaccine object) which is passed from the pop is recieved here
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => AddDocuments(
                                petId: widget.petID,
                              ))));

                  //to check if the returned result is not null and they type is Certificate
                  if (result != null && result is Documents) {
                    setState(() async {
                      //the result that is recieved is added to the List that is to be displayed
                      // _document.add(result);
                      await _loadDocument();
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
          child: newDocuments.isEmpty
              ? EmptyDoc(
                  petId: widget.petID,
                )
              : ListView.builder(
                  itemCount: newDocuments.length,
                  itemBuilder: (context, index) {
                    final current = newDocuments[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Card(
                        color: grey,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewDoc(
                                          dname: current.dname,
                                          dedate: current.dedate,
                                          didate: current.didate,
                                          dfile: current.dfile,
                                        )));

                            // showBottomSheet(
                            //     context: context,
                            //     builder: (context) {
                            //       return Container(
                            //         height: height * 0.31,
                            //         decoration: bottomSheetStyle,
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(20),
                            //           child: Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               label(current.dname),
                            //               label('Date'),
                            //               Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Column(
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.start,
                            //                     children: [
                            //                       subject2('Issued Date'),
                            //                       leading(current.didate)
                            //                     ],
                            //                   ),
                            //                   Column(
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.start,
                            //                     children: [
                            //                       subject2('Expiry Date'),
                            //                       leading(current.dedate)
                            //                     ],
                            //                   )
                            //                 ],
                            //               ),
                            //               space,
                            //               space,
                            //               space,
                            //               FilledButton(
                            //                 onPressed: () {
                            //                   Navigator.pop(context);
                            //                 },
                            //                 style: mainButton,
                            //                 child: const Text('Done'),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       );
                            //     });
                          },
                          trailing: IconButton(
                              onPressed: () async {
                                await _documentService
                                    .deletedocument(current.did);
                                setState(() {
                                  newDocuments.removeAt(index);
                                });
                              },
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                size: 35,
                                color: Color.fromARGB(255, 211, 211, 211),
                              )),
                          title: leading(current.dname),
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
                              subject2(current.didate)
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
