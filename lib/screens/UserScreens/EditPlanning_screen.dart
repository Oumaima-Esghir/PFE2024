import 'dart:convert';

import 'package:dealdiscover/model/plan.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/screens/UserScreens/calendar_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPlanningScreen extends StatefulWidget {
  final Plan plan;
  const EditPlanningScreen({super.key, required this.plan});

  @override
  State<EditPlanningScreen> createState() => _EditPlanningScreenState();
}

class _EditPlanningScreenState extends State<EditPlanningScreen> {
  bool isLoading = false;
  DateTime? fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  int numberOfPersons = 1;
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController reminderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the data from the Plan object
    fromDate = widget.plan.dateFrom != null
        ? DateTime.parse(widget.plan.dateFrom!)
        : null;
    toDate =
        widget.plan.dateTo != null ? DateTime.parse(widget.plan.dateTo!) : null;
    fromTime = widget.plan.timeFrom != null
        ? TimeOfDay(
            hour: int.parse(widget.plan.timeFrom!.split(':')[0]),
            minute: int.parse(widget.plan.timeFrom!.split(':')[1]),
          )
        : null;
    toTime = widget.plan.timeTo != null
        ? TimeOfDay(
            hour: int.parse(widget.plan.timeTo!.split(':')[0]),
            minute: int.parse(widget.plan.timeTo!.split(':')[1]),
          )
        : null;
    numberOfPersons = widget.plan.nb_persons ?? 1;
    titleController.text = widget.plan.title ?? '';
    addressController.text =
        widget.plan.pubId ?? ''; // Assuming pubId is used for address
    reminderController.text = widget.plan.reminder ?? '';
  }

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('yyyy-MM-dd').format(date) : '';
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
                height: 750,
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
                          hintText: "Enter title",
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
                              suffixIcon: Icon(Icons.access_time_rounded),
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
                              suffixIcon: Icon(Icons.access_time_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Number of Persons",
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
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(
                            text: numberOfPersons.toString()),
                        onChanged: (value) {
                          setState(() {
                            numberOfPersons = int.tryParse(value) ?? 1;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: numberOfPersons.toString(),
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
                          hintText: "Reminder",
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
                    SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        // Adjust the left margin as needed
                        child: Center(
                          child: SizedBox(
                            height: 60, // Adjust height as needed
                            width: 350, // Make button full width
                            child: TextButton(
                              onPressed: () => updateDeal(),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        MyColors.btnColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Colors.white,
                                      width: 4,
                                    ), // Add white border
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
            ],
          ),
        )),
      ),
    );
  }

  Future<void> loadingHandler(BuildContext context) async {
    setState(() {
      isLoading = !isLoading;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = !isLoading;
    });
    Navigator.of(context).pop();
  }

  Future<bool> updateDeal() async {
    setState(() {
      isLoading = true;
    });

    // API endpoint and request
    final url =
        Uri.parse('http://192.168.1.7:3000/plans/update/${widget.plan.id}');

    print("iddd:" + formatDate(fromDate));
    final token = await getToken();

    print("base64Image");
    final response = await http.put(
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
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalendarScreen(),
        ),
      );

      return true; // Successful update
    } else {
      print(response.statusCode);
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update deal')),
      );
      return false; // Failed update
    }
  }
}
