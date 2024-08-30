import 'dart:convert';

import 'package:dealdiscover/client/client_service.dart'; // Import your client service
import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/screens/PartnerScreens/deals_management_screen.dart';
import 'package:dealdiscover/screens/menus/hidden_drawer.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddDealScreen extends StatefulWidget {
  const AddDealScreen({super.key});

  @override
  State<AddDealScreen> createState() => _AddDealScreenState();
}

enum DealCategory {
  hotel,
  restaurant,
  cafe,
  park,
  destination,
  beach,
  monument
}

extension DealCategoryExtension on DealCategory {
  String get name {
    switch (this) {
      case DealCategory.hotel:
        return 'hotel';
      case DealCategory.restaurant:
        return 'restaurant';
      case DealCategory.cafe:
        return 'cafe';
      case DealCategory.park:
        return 'park';
      case DealCategory.destination:
        return 'destination';
      case DealCategory.beach:
        return 'beach';
      case DealCategory.monument:
        return 'monument';
    }
  }
}

class _AddDealScreenState extends State<AddDealScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _promoField1Controller =
      TextEditingController(); // New field 1
  final TextEditingController _promoField2Controller =
      TextEditingController(); // New field 2
  DealCategory? _selectedCategory;
  String? stateValue;
  bool isLoading = false;

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  void _addDeal() async {
    final String title = _titleController.text.trim();
    final String adress = _adressController.text.trim();
    final String description = _descriptionController.text.trim();
    int? pourcentage;
    try {
      pourcentage = int.tryParse(_promoField1Controller.text.trim());
    } catch (e) {
      // Handle any parsing errors if needed
      print('Error parsing promo field 1 to integer: $e');
    }

    final String? duree = _promoField2Controller.text.trim();

    if (title.isEmpty ||
        adress.isEmpty ||
        description.isEmpty ||
        stateValue == null ||
        _selectedCategory == null ||
        (stateValue == "promo" && (duree?.isEmpty ?? true))) {
      // Show an error message or a dialog to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Please fill all fields and select a deal state and category')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Create a Pub object

    try {
      final url = Uri.parse('http://10.0.2.2:3000/pubs/');

      final token = await getToken();

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'title': title,
          'adress': adress,
          'description': description,
          'category': _selectedCategory!.name,
          'state': stateValue == "not in promo" ? "offre" : stateValue,
          'pourcentage': stateValue == "promo"
              ? pourcentage
              : null, // Add promo fields to the body if needed
          'duree': stateValue == "promo" ? duree : null,
        }),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HiddenDrawer(),
        ),
      );
    } catch (e) {
      // Handle any errors that might occur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add the deal')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
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
              // loadingHandler(context);
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
            image: AssetImage('assets/images/partnerbg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/addP.png',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Add An Image",
                      style: TextStyle(
                        color: MyColors.btnBorderColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 350,
                  height: 800,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
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
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Write Your Title",
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
                          controller: _adressController,
                          decoration: InputDecoration(
                            hintText: "Write Your Address",
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
                        "Description",
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
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: "Write Your Description",
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
                        "Deal State",
                        style: TextStyle(
                          color: MyColors.btnBorderColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: MyColors.backbtn1,
                          border: Border.all(color: MyColors.btnColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Row(
                            children: [
                              Radio<String>(
                                value: "promo",
                                groupValue: stateValue,
                                onChanged: (value) {
                                  setState(() {
                                    stateValue = value;
                                  });
                                },
                                activeColor: MyColors.btnBorderColor,
                              ),
                              Text("Promo"),
                              Radio<String>(
                                value: "not in promo",
                                groupValue: stateValue,
                                onChanged: (value) {
                                  setState(() {
                                    stateValue = value;
                                  });
                                },
                                activeColor: MyColors.btnBorderColor,
                              ),
                              Text("Not in Promo"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      if (stateValue == "promo") ...[
                        Text(
                          "pourcentage",
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
                            keyboardType: TextInputType
                                .number, // Corrected to accept numeric input

                            controller: _promoField1Controller,
                            decoration: InputDecoration(
                              hintText: "Enter Promo Field 1",
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
                          "duree",
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
                            controller: _promoField2Controller,
                            decoration: InputDecoration(
                              hintText: "Enter Promo Field 2",
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
                      SizedBox(height: 20),
                      Text(
                        "Category",
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
                        decoration: BoxDecoration(
                          color: MyColors.backbtn1,
                          border: Border.all(color: MyColors.btnColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<DealCategory>(
                            value: _selectedCategory,
                            hint: Text('Select Category'),
                            items: DealCategory.values
                                .map((DealCategory category) {
                              return DropdownMenuItem<DealCategory>(
                                value: category,
                                child: Text(category.name),
                              );
                            }).toList(),
                            onChanged: (DealCategory? newCategory) {
                              setState(() {
                                _selectedCategory = newCategory;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.only(left: 18),
                    child: Center(
                      child: SizedBox(
                        height: 60,
                        width: 350,
                        child: TextButton(
                          onPressed: _addDeal,
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
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
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
            builder: (_) => const HiddenDrawer(),
          ),
        );
      });
    });
  }
}
