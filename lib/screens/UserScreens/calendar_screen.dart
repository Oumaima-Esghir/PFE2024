import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final String title = 'Calendar';

  DateTime _currentDate = DateTime.now();

  Map<DateTime, List<String>> _events = {
    DateTime(2022, 4, 20): ['Event 1', 'Event 2'],
    DateTime(2022, 4, 21): ['Event 3'],
    DateTime(2022, 4, 22): ['Event 4', 'Event 5', 'Event 6'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              child: Text(
                'Events for ${DateFormat('MMMM yyyy').format(_currentDate)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            _buildCalendar(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: TableCalendar(
        firstDay: DateTime(2022, 4, 1),
        lastDay: DateTime(2022, 4, 30),
        focusedDay: _currentDate,
        eventLoader: (day) => _events[day] ?? [],
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          // This is where you integrate the customization
         // markersPositionBottom: true,
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _currentDate = selectedDay;
          });
        },
      ),
    );
  }

}
