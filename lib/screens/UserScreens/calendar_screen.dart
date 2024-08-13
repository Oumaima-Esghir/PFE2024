import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealdiscover/widgets/PlanningItem.dart' as PlanningItemWidget;
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // final String title = 'Calendar';

  // DateTime _currentDate = DateTime.now();

/*  Map<DateTime, List<String>> _events = {
    DateTime(2022, 4, 20): ['Event 1', 'Event 2'],
    DateTime(2022, 4, 21): ['Event 3'],
    DateTime(2022, 4, 22): ['Event 4', 'Event 5', 'Event 6'],
  };*/

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              loadingHandler(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 330),
              child: Image.asset(
                'assets/images/arrowL.png',
                width: 45.0,
                height: 45.0,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Planning.png'),
            fit: BoxFit.fill,
          ),
        ),
        //  child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*Container(
              margin: EdgeInsets.all(16.0),
              child: Text(
                'Events for ${DateFormat('MMMM yyyy').format(_currentDate)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),*/
                    //  _buildCalendar(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.white,
                      ),
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                PlanningItemWidget.PlanningItem(),
                                SizedBox(height: 20),
                                PlanningItemWidget.PlanningItem(),
                                SizedBox(height: 20),
                                PlanningItemWidget.PlanningItem(),
                                SizedBox(height: 20),
                                PlanningItemWidget.PlanningItem(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  void loadingHandler(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => const BottomNavBar(),
          ),
        );
      });
    });
  }
  /*Widget _buildCalendar() {
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
  }*/
}
