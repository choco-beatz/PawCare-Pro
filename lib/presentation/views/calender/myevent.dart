import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/textField.dart';
import 'package:pawcare_pro/domain/event%20model/event.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';
import 'package:pawcare_pro/service/event_service.dart';

class MyEvent extends StatefulWidget {
  final int petId;
  final String date;
  const MyEvent({super.key, required this.petId, required this.date});

  @override
  State<MyEvent> createState() => _MyEventState();
}

class _MyEventState extends State<MyEvent> {
  final titleController = TextEditingController();

  final EventService _eventService = EventService();

  String eventIcon = 'not selected';

  void _onIconTap(String iconName) {
    setState(() {
      eventIcon = iconName;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: white,
        title: const Text(
          'Events',
          style: TextStyle(fontSize: 18),
        ),
      ),
      backgroundColor: mainBG,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBox,
            label('Schedule Events'),
            sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconContainer(
                  iconName: 'Activity',
                  icon: FontAwesomeIcons.futbol,
                  color: purple,
                  height: height,
                  width: width,
                ),
                _buildIconContainer(
                  iconName: 'Medicine',
                  icon: FontAwesomeIcons.pills,
                  color: green,
                  height: height,
                  width: width,
                ),
                _buildIconContainer(
                  iconName: 'Check up',
                  icon: FontAwesomeIcons.stethoscope,
                  color: pink,
                  height: height,
                  width: width,
                ),
                _buildIconContainer(
                  iconName: 'Groom',
                  icon: FontAwesomeIcons.scissors,
                  color: yellow,
                  height: height,
                  width: width,
                ),
              ],
            ),
            space,
            line,
            space,
            label('Event title'),
            SizedBox(
              height: 52,
              width: 370,
              child: TextFormField(
                cursorColor: white,
                style: const TextStyle(color: white, fontSize: 20),
                decoration: fieldDecor("Enter the Event"),
                controller: titleController,
              ),
            ),
            Spacer(),
            FilledButton(
                onPressed: () async {
                  if (titleController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter title')));
                    return;
                  } else {
                    final event = Event(
                        iname: eventIcon,
                        title: titleController.text,
                        id: DateTime.now().millisecond,
                        petId: widget.petId,
                        date: widget.date);
                    await _eventService.updateEvent(event.id, event);
                    Navigator.pop(context, event);
                  }
                },
                style: mainButton,
                child: const Text('Done'))
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer({
    required String iconName,
    required IconData icon,
    required Color color,
    required double height,
    required double width,
  }) {
    return GestureDetector(
      onTap: () => _onIconTap(iconName),
      child: Container(
        height: height * 0.1,
        width: width * 0.2,
        decoration: BoxDecoration(
          color: eventIcon == iconName ? grey : fieldColor,
          border: Border.all(color: grey, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              size: 30,
              color: color,
            ),
            eventicon(iconName),
          ],
        ),
      ),
    );
  }

  Widget eventicon(String iconName) {
    return Text(
      iconName,
      style: const TextStyle(color: white),
    );
  }
}
