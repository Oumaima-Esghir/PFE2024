import 'dart:convert';

import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/screens/UserScreens/calendar_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddPlanningScreen extends StatefulWidget {
  final String? id;
  const AddPlanningScreen({super.key, required this.id});

  @override
  State<AddPlanningScreen> createState() => _AddPlanningScreenState();
}

class _AddPlanningScreenState extends State<AddPlanningScreen> {
  bool isLoading = false;
  DateTime? fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  int numberOfPersons = 1;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    addressController.dispose();
    reminderController.dispose();
    super.dispose();
  }

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('yyyy-MM-dd').format(date) : '';
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  Future<void> addPlanning() async {
    if (titleController.text.isEmpty ||
        addressController.text.isEmpty ||
        fromDate == null ||
        toDate == null ||
        fromTime == null ||
        toTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return;
    }
    print(widget.id);
    final url = Uri.parse('http://192.168.1.6:3000/plans/add/${widget.id}');

    final token = await getToken();

    print("base64Image");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': titleController.text,
        'adress': addressController.text,
        'dateFrom': "${formatDate(fromDate)}",
        'dateTo': "${formatDate(toDate)}",
        'nb_persons': numberOfPersons,
        'timeFrom':
            "${fromTime!.hour.toString() + ':' + fromTime!.minute.toString()}",
        'timeTo':
            "${toTime!.hour.toString() + ':' + toTime!.minute.toString()}",
        'reminder': reminderController.text,
      }),
    );

    // Here you can send the data to your backend or local storage
    // For now, we'll just print it out for demonstration purposes
    print('Title: ${titleController.text}');
    print('Address: ${addressController.text}');
    print('From Date: ${DateFormat('dd-MM-yyyy').format(fromDate!)}');
    print('To Date: ${DateFormat('dd-MM-yyyy').format(toDate!)}');
    print('From Time: ${fromTime!.hour}:${fromTime!.minute}');
    print('To Time: ${toTime!.hour}:${toTime!.minute}');
    print('Number of Persons: $numberOfPersons');
    print('Reminder: ${reminderController.text}');

    // After successful addition, you can navigate or update UI
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CalendarScreen(),
    //   ),
    // );
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalendarScreen(),
        ),
      );
    } else {
      print(response.body);
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add deal')),
      );
    }
  }

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
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/add_editbg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              children: [
                Container(
                  width: 350,
                  height: 655,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Title",
                        style: TextStyle(
                          color: MyColors.btnBorderColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 55,
                        child: TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            hintText: "Birthday Going Out",
                            filled: true,
                            fillColor: MyColors.backbtn1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.btnColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.btnBorderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Address",
                        style: TextStyle(
                          color: MyColors.btnBorderColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 55,
                        child: TextField(
                          controller: addressController,
                          decoration: InputDecoration(
                            hintText: "Update your address",
                            filled: true,
                            fillColor: MyColors.backbtn1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.btnColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.btnBorderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Date & Time",
                        style: TextStyle(
                          color: MyColors.btnBorderColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 170,
                            height: 55,
                            child: TextField(
                              readOnly: true,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: fromDate ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    setState(() {
                                      fromDate = selectedDate;
                                    });
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: fromDate != null
                                    ? "${DateFormat('dd-MM-yyyy').format(fromDate!)}"
                                    : "Select From Date",
                                filled: true,
                                fillColor: MyColors.backbtn1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.btnColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.btnBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                suffixIcon: Icon(Icons.calendar_month_rounded),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 170,
                            height: 55,
                            child: TextField(
                              readOnly: true,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: toDate ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    setState(() {
                                      toDate = selectedDate;
                                    });
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: toDate != null
                                    ? "${DateFormat('dd-MM-yyyy').format(toDate!)}"
                                    : "Select To Date",
                                filled: true,
                                fillColor: MyColors.backbtn1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.btnColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.btnBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                suffixIcon: Icon(Icons.calendar_month_rounded),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 170,
                            height: 55,
                            child: TextField(
                              readOnly: true,
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: fromTime ?? TimeOfDay.now(),
                                ).then((selectedTime) {
                                  if (selectedTime != null) {
                                    setState(() {
                                      fromTime = selectedTime;
                                    });
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: fromTime != null
                                    ? "${fromTime!.hour}:${fromTime!.minute}"
                                    : "Select From Time",
                                filled: true,
                                fillColor: MyColors.backbtn1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.btnColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.btnBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                suffixIcon: Icon(Icons.access_time),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 170,
                            height: 55,
                            child: TextField(
                              readOnly: true,
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: toTime ?? TimeOfDay.now(),
                                ).then((selectedTime) {
                                  if (selectedTime != null) {
                                    setState(() {
                                      toTime = selectedTime;
                                    });
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: toTime != null
                                    ? "${toTime!.hour}:${toTime!.minute}"
                                    : "Select To Time",
                                filled: true,
                                fillColor: MyColors.backbtn1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.btnColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.btnBorderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                suffixIcon: Icon(Icons.access_time),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Number Of Persons",
                        style: TextStyle(
                          color: MyColors.btnBorderColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 55,
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyColors.backbtn1,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: MyColors.btnColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (numberOfPersons > 1) {
                                      numberOfPersons--;
                                    }
                                  });
                                },
                                icon: Icon(Icons.arrow_drop_down),
                              ),
                              Text(
                                numberOfPersons.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    numberOfPersons++;
                                  });
                                },
                                icon: Icon(Icons.arrow_drop_up),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Reminder",
                        style: TextStyle(
                          color: MyColors.btnBorderColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 55,
                        child: TextField(
                          controller: reminderController,
                          decoration: InputDecoration(
                            hintText: "Add Reminder",
                            filled: true,
                            fillColor: MyColors.backbtn1,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.btnColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: MyColors.btnBorderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Center(
                      child: SizedBox(
                        height: 60,
                        width: 350,
                        child: TextButton(
                          onPressed: () {
                            addPlanning();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                MyColors.btnColor),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 4,
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            "Done",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
}
