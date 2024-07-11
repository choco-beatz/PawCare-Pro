import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:intl/intl.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/domain/event%20model/event.dart';
import 'package:pawcare_pro/presentation/views/calender/myevent.dart';
import 'package:pawcare_pro/presentation/views/calender/widget/calendaricons.dart';
import 'package:pawcare_pro/presentation/views/calender/widget/calenderstyle.dart';
import 'package:pawcare_pro/presentation/views/calender/widget/noevent.dart';
import 'package:pawcare_pro/presentation/views/documents/widget/alert.dart';
import 'package:pawcare_pro/presentation/views/documents/widget/icons.dart';
import 'package:pawcare_pro/presentation/views/petprofile/widgets/data_style.dart';
import 'package:pawcare_pro/presentation/views/widgets/normalappbar.dart';
import 'package:pawcare_pro/service/event_service.dart';
import 'package:table_calendar/table_calendar.dart';

class ShowEvent extends StatefulWidget {
  final int petId;
  const ShowEvent({super.key, required this.petId});

  @override
  State<ShowEvent> createState() => _ShowEventState();
}

class _ShowEventState extends State<ShowEvent> {
  DateTime _focusedCalendarDate = DateTime.now();
  DateTime selectedCalendarDate = DateTime.now();

  final EventService _eventService = EventService();

  Map<DateTime, List<Event>> mySelectedEvents = {};

  List<Event> _listOfDayEvents(DateTime date) {
    DateTime normalizedDate = DateTime(date.year, date.month, date.day);
    List<Event> events = mySelectedEvents[normalizedDate] ?? [];
    return events;
  }

  @override
  void initState() {
    super.initState();
    selectedCalendarDate = _focusedCalendarDate;
    loadEvents();
  }

  void loadEvents() async {
    final events = await _eventService.getEvents();

    setState(() {
      mySelectedEvents.clear();
      for (var event in events) {
        DateTime eventDate = DateFormat.yMMMd().parse(event.date);
        eventDate = DateTime(eventDate.year, eventDate.month, eventDate.day);
        if (mySelectedEvents[eventDate] == null) {
          mySelectedEvents[eventDate] = [];
        }
        mySelectedEvents[eventDate]!.add(event);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: normalAppBar('Events'),
        backgroundColor: mainBG,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Card(
                      color: mainBG,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TableCalendar(
                          headerStyle: headerStyle(),
                          calendarStyle: calendarStyle(),
                          daysOfWeekStyle: days(),
                          focusedDay: DateTime.now(),
                          firstDay: DateTime(2002),
                          lastDay: DateTime(2050),
                          calendarFormat: CalendarFormat.month,
                          selectedDayPredicate: (currentSelectedDate) {
                            return (isSameDay(
                                selectedCalendarDate, currentSelectedDate));
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            if (!isSameDay(selectedCalendarDate, selectedDay)) {
                              setState(() {
                                selectedCalendarDate = selectedDay;
                                _focusedCalendarDate = focusedDay;
                              });
                            }
                          },
                          eventLoader: (day) {
                            return _listOfDayEvents(
                                DateTime(day.year, day.month, day.day));
                          },
                          calendarBuilders: CalendarBuilders(
                              markerBuilder: (context, date, events) {
                            if (events.isEmpty) {
                              return const SizedBox();
                            }
                            List<Widget> markers = [];
                            for (var event in events) {
                              final Event myEvent = event as Event;
                              Color dotColor = mainColor;
                              if (myEvent.iname == 'Activity') {
                                dotColor = purple;
                              } else if (myEvent.iname == 'Medicine') {
                                dotColor = green;
                              } else if (myEvent.iname == 'Check up') {
                                dotColor = pink;
                              } else if (myEvent.iname == 'Groom') {
                                dotColor = yellow;
                              } else {
                                dotColor = mainColor;
                              }
                              markers.add(_buildEventsMarker(dotColor));
                            }
                            return Positioned(
                                top: 40,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: markers
                                        .take(4)
                                        .toList() // Display up to 4 markers
                                    ));
                          }))),
                  _listOfDayEvents(selectedCalendarDate).isNotEmpty
                      ? Column(
                          children: _listOfDayEvents(selectedCalendarDate)
                              .map((myEvents) {
                            FaIcon leadingIcon = other();
                            if (myEvents.iname == 'Activity') {
                              leadingIcon = football();
                            } else if (myEvents.iname == 'Medicine') {
                              leadingIcon = pill();
                            } else if (myEvents.iname == 'Check up') {
                              leadingIcon = doctor();
                            } else if (myEvents.iname == 'Groom') {
                              leadingIcon = groom();
                            } else {
                              leadingIcon = other();
                            }

                            return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Column(children: [
                                  ListTile(
                                      tileColor: fieldColor,
                                      shape: recBorder(),
                                      leading: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: leadingIcon,
                                      ),
                                      subtitle: leading(myEvents.title),
                                      title: eventicon(
                                        DateFormat.yMMMd()
                                            .format(selectedCalendarDate),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () => showDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                      backgroundColor: mainBG,
                                                      title:
                                                          aleartText('Delete?'),
                                                      content: aleartText(
                                                          'Are you sure?'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                            style: cancelButton,
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: aleartText(
                                                                'Cancel')),
                                                        TextButton(
                                                            style: delButton,
                                                            onPressed:
                                                                () async {
                                                              await _eventService
                                                                  .deleteEvent(
                                                                      myEvents
                                                                          .id);
                                                              setState(() {
                                                                DateTime eventDate = DateTime(
                                                                    selectedCalendarDate
                                                                        .year,
                                                                    selectedCalendarDate
                                                                        .month,
                                                                    selectedCalendarDate
                                                                        .day);
                                                                mySelectedEvents[
                                                                        eventDate]
                                                                    ?.remove(
                                                                        myEvents);
                                                                if (mySelectedEvents[
                                                                            eventDate]
                                                                        ?.isEmpty ??
                                                                    false) {
                                                                  mySelectedEvents
                                                                      .remove(
                                                                          eventDate);
                                                                }
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: aleartText(
                                                                'OK'))
                                                      ])),
                                          icon: delete()))
                                ]));
                          }).toList(),
                        )
                      : NoEvent()
                ]))),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _navigateToAddEventScreen();
          },
          backgroundColor: mainColor,
          label: label2('Add a new event'),
          icon: calendarIcon1(),
        ));
  }

  void _navigateToAddEventScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyEvent(
                petId: widget.petId,
                date: DateFormat.yMMMd().format(selectedCalendarDate),
              )),
    );
    if (result != null && result is Event) {
      loadEvents();
    }
  }

  Widget _buildEventsMarker(Color color) {
    return dot(color);
  }
}
