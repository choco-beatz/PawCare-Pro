import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:table_calendar/table_calendar.dart';

HeaderStyle headerStyle() {
  return const HeaderStyle(
    titleTextStyle: TextStyle(color: white, fontSize: 18),
    decoration: BoxDecoration(
      color: mainBG,
    ),
    formatButtonTextStyle: TextStyle(color: white, fontSize: 18),
    formatButtonDecoration: BoxDecoration(
      color: transparent,
    ),
    leftChevronIcon: Icon(
      Icons.chevron_left,
      color: white,
      size: 28,
    ),
    rightChevronIcon: Icon(
      Icons.chevron_right,
      color: white,
      size: 28,
    ),
  );
}

CalendarStyle calendarStyle() {
  return CalendarStyle(
    cellMargin: const EdgeInsets.all(2),
    defaultDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: fieldColor,
        border: Border.all(width: 2, color: grey)),
    weekendDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: fieldColor,
        border: Border.all(width: 2, color: grey)),
    weekendTextStyle: const TextStyle(color: white, fontSize: 18),
    defaultTextStyle: const TextStyle(color: white, fontSize: 18),
    todayDecoration: BoxDecoration(
      color: grey,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 2, color: white),
    ),
    // highlighted color for selected day
    selectedDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 2, color: white),
    ),
  );
}

Container dot(Color color) {
  return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ));
}

RoundedRectangleBorder recBorder() {
  return RoundedRectangleBorder(
    side: const BorderSide(color: grey, width: 2.0),
    borderRadius: BorderRadius.circular(10.0),
  );
}

DaysOfWeekStyle days() {
  return const DaysOfWeekStyle(
    weekendStyle: TextStyle(
      color: white,
      fontWeight: FontWeight.w500,
    ),
    weekdayStyle: TextStyle(color: white, fontWeight: FontWeight.w500),
  );
}
