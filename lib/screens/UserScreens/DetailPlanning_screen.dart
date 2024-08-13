import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/screens/UserScreens/calendar_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPlanningScreen extends StatefulWidget {
  const DetailPlanningScreen({super.key});

  @override
  State<DetailPlanningScreen> createState() => _DetailPlanningScreenState();
}

class _DetailPlanningScreenState extends State<DetailPlanningScreen> {
  bool isLoading = false;
  DateTime? fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  int numberOfPersons = 1;

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
                    Container(
                      width: 350,
                      height: 55,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: MyColors.backbtn1,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: MyColors.btnColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Birthday Going Out",
                        style: TextStyle(fontSize: 16),
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
                    Container(
                      width: 350,
                      height: 55,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: MyColors.backbtn1,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: MyColors.btnColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Update your address",
                        style: TextStyle(fontSize: 16),
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
                        Container(
                          width: 170,
                          height: 55,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
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
                              Text("2024-07-28"),
                            ],
                          ),
                        ),
                        Container(
                          width: 170,
                          height: 55,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
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
                              Text(
                                "2024-07-28",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 170,
                          height: 55,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
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
                              Text(
                                "12:30",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 170,
                          height: 55,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
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
                              Text(
                                "17:30",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
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
                    Container(
                      width: 350,
                      height: 55,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: MyColors.backbtn1,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: MyColors.btnColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "1",
                        style: TextStyle(fontSize: 16),
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
                    Container(
                      width: 350,
                      height: 55,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: MyColors.backbtn1,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: MyColors.btnColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Add Reminder",
                        style: TextStyle(fontSize: 16),
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
