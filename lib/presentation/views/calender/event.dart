import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:intl/intl.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/calender/myevent.dart';
import 'package:table_calendar/table_calendar.dart';

class MyEvents {
  final String eventTitle;
  final String icon;

  MyEvents({required this.eventTitle, required this.icon});
}

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  DateTime _focusedCalendarDate = DateTime.now();
  DateTime? selectedCalendarDate;

  Map<DateTime, List<MyEvents>> mySelectedEvents = {};

  List<MyEvents> _listOfDayEvents(DateTime date) {
    return mySelectedEvents[date] ?? [];
  }

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: Colors.white,
        title: const Text(
          'Events',
          style: TextStyle(fontSize: 18),
        ),
      ),
      backgroundColor: mainBG,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                color: mainBG,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TableCalendar(
                  headerStyle: const HeaderStyle(
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                    decoration: BoxDecoration(
                      color: mainBG,
                    ),
                    formatButtonTextStyle:
                        TextStyle(color: Colors.white, fontSize: 18),
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 28,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    cellMargin: const EdgeInsets.all(2),
                    defaultDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: fieldColor,
                        border: Border.all(width: 2, color: grey)),
                    weekendDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: fieldColor,
                        border: Border.all(width: 2, color: grey)),
                    weekendTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 18),
                    defaultTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 18),
                    todayDecoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 2, color: Colors.white),
                      shape: BoxShape.rectangle,
                    ),
                    // highlighted color for selected day
                    selectedDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 2, color: Colors.white),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    weekdayStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
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
                    return _listOfDayEvents(day);
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isEmpty) return const SizedBox();
                      List<Widget> markers = [];
                      for (var event in events) {
                        final MyEvents myEvent = event as MyEvents;
                        Color dotColor;
                        if (myEvent.icon == 'Activity') {
                          dotColor = Colors.purple;
                        } else if (myEvent.icon == 'Medicine') {
                          dotColor = Colors.green;
                        } else if (myEvent.icon == 'Check up') {
                          dotColor = Colors.pink;
                        } else if (myEvent.icon == 'Groom') {
                          dotColor = Colors.yellow;
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
                              .take(3)
                              .toList(), // Display up to 3 markers
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (selectedCalendarDate != null)
                ..._listOfDayEvents(selectedCalendarDate!).map((myEvents) {
                  FaIcon leadingIcon;
                  if (myEvents.icon == 'Activity') {
                    leadingIcon = const FaIcon(
                      FontAwesomeIcons.futbol,
                      color: Colors.purple,
                      size: 40,
                    );
                  } else if (myEvents.icon == 'Medicine') {
                    leadingIcon = const FaIcon(
                      FontAwesomeIcons.pills,
                      color: Colors.green,
                      size: 40,
                    );
                  } else if (myEvents.icon == 'Check up') {
                    leadingIcon = const FaIcon(
                      FontAwesomeIcons.stethoscope,
                      color: Colors.pink,
                      size: 40,
                    );
                  } else if (myEvents.icon == 'Groom') {
                    leadingIcon = const FaIcon(
                      FontAwesomeIcons.scissors,
                      color: Colors.yellow,
                      size: 40,
                    );
                  } else {
                    leadingIcon = const FaIcon(
                      FontAwesomeIcons.question,
                      color: mainColor,
                      size: 40,
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      children: [
                        ListTile(
                          tileColor: fieldColor,
                          // add rounded border to list item
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: grey, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          leading: leadingIcon,
                          subtitle: leading(myEvents.eventTitle),
                          title: eventicon(
                            DateFormat.yMMMd().format(selectedCalendarDate!),
                          ),
                          trailing: IconButton(
                              onPressed: () => showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        backgroundColor: mainBG,
                                        title: const Text(
                                          'Delete?',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: const Text(
                                          'Are you sure?',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            style: cancelButton,
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TextButton(
                                            style: delButton,
                                            onPressed: () {
                                              setState(() {
                                                mySelectedEvents[
                                                        selectedCalendarDate!]!
                                                    .remove(myEvents);
                                                if (mySelectedEvents[
                                                        selectedCalendarDate!]!
                                                    .isEmpty) {
                                                  mySelectedEvents.remove(
                                                      selectedCalendarDate!);
                                                }
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      )),
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                size: 35,
                                color: Color.fromARGB(255, 211, 211, 211),
                              )),
                        )
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddEventScreen();
        },
        backgroundColor: mainColor,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  void _navigateToAddEventScreen() async {
    // Use Navigator.push to navigate to 'SecondScreen'.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MyEvent()), // Create the route.
    );

    // Check if a result is returned and if it is of type 'MyEvents'.
    if (result != null && result is MyEvents) {
      // Retrieve the list of events for
      // the selected calendar date
      // or initialize an empty list.
      final selectedDateEvents = mySelectedEvents[selectedCalendarDate] ?? [];

      // Update the list of events with
      // the result from 'SecondScreen'.
      setState(() {
        // Add the new event to the list
        selectedDateEvents.add(result);

        // Update the events for the selected date
        mySelectedEvents[selectedCalendarDate!] = selectedDateEvents;
      });
    }
  }

  Widget _buildEventsMarker(Color color) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
