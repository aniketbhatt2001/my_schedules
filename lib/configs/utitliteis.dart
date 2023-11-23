import 'package:flutter/material.dart';

String timeOfDayToString(TimeOfDay timeOfDay) {
  // Convert to 12-hour format
  int hour = timeOfDay.hourOfPeriod;
  String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

  // Format the TimeOfDay object as a string in 12-hour format
  return '${hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')} $period';
}
