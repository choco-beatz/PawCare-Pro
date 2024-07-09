import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/document%20model/document.dart';
import 'package:pawcare_pro/presentation/views/documents/add_documents.dart';
import 'package:pawcare_pro/presentation/views/documents/edit_doc.dart';
import 'package:pawcare_pro/presentation/views/documents/emptydocument.dart';
import 'package:pawcare_pro/presentation/views/documents/view_doc.dart';
import 'package:pawcare_pro/presentation/views/documents/widget/alert.dart';
import 'package:pawcare_pro/presentation/views/documents/widget/icons.dart';
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
    newDocuments.clear();
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
            foregroundColor: white,
            title: const Text(
              'Documents',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    //the result(document object) which is passed from the pop is recieved here
                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => AddDocuments(
                                  petId: widget.petID,
                                ))));

                    //to check if the returned result is not null and they type is Certificate
                    if (result != null && result is Documents) {
                      await _loadDocument();
                    }
                  },
                  icon: add())
            ]),
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
                                  },
                                  trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              final updatedDocInfo =
                                                  await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditDocuments(
                                                                did:
                                                                    current.did,
                                                                petId: current
                                                                    .petID,
                                                              )));

                                              if (updatedDocInfo != null &&
                                                  updatedDocInfo is Documents) {
                                                setState(() {
                                                  newDocuments[index] =
                                                      updatedDocInfo;
                                                });
                                              }
                                            },
                                            icon: edit()),
                                        IconButton(
                                            onPressed: () => showDialog<void>(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    AlertDialog(
                                                        backgroundColor: mainBG,
                                                        title: aleartText(
                                                            'Delete?'),
                                                        content: aleartText(
                                                            'Are you sure?'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                              style:
                                                                  cancelButton,
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: aleartText(
                                                                  'Cancel')),
                                                          TextButton(
                                                              style: delButton,
                                                              onPressed:
                                                                  () async {
                                                                await _documentService
                                                                    .deletedocument(
                                                                        current
                                                                            .did);
                                                                setState(() {
                                                                  newDocuments
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: aleartText(
                                                                  'OK'))
                                                        ])),
                                            icon: const Icon(
                                                Icons.delete_outline_rounded,
                                                size: 35,
                                                color: offwhite))
                                      ]),
                                  title: leading(current.dname),
                                  subtitle: Row(children: [
                                    const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: offwhite,
                                          size: 18,
                                        )),
                                    subject2(current.didate)
                                  ]))));
                    })));
  }
}
