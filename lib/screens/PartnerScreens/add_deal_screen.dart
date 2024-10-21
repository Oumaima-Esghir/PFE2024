import 'dart:convert';
import 'dart:io';

import 'package:dealdiscover/client/client_service.dart'; // Import your client service
import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/screens/PartnerScreens/deals_management_screen.dart';
import 'package:dealdiscover/screens/menus/hidden_drawer.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _image;
  bool imagegeted = false;
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  void _addDeal() async {
    final String title = _titleController.text.trim();
    final String address = _adressController.text.trim();
    final String description = _descriptionController.text.trim();
    int? percentage;

    try {
      percentage = int.tryParse(_promoField1Controller.text.trim());
    } catch (e) {
      print('Error parsing promo field 1 to integer: $e');
    }

    final String? duration = _promoField2Controller.text.trim();

    if (title.isEmpty ||
        address.isEmpty ||
        description.isEmpty ||
        stateValue == null ||
        _selectedCategory == null ||
        (stateValue == "promo" && (duration?.isEmpty ?? true))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all fields and select a deal state and category',
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final token = await getToken();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.6:3000/pubs/'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      request.fields['title'] = title;
      request.fields['address'] = address;
      request.fields['description'] = description;
      request.fields['duree'] = duration ?? '';
      request.fields['pourcentage'] =
          stateValue == "promo" ? (percentage?.toString() ?? '') : '';
      request.fields['state'] = stateValue != "promo" ? 'offre' : 'promo';
      request.fields['category'] = _selectedCategory!.name;

      if (imagegeted == true && _image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('pubImage', _image!.path),
        );
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print('Response code: ${response.statusCode}');
      print('Response body: $responseBody');

      if (response.statusCode == 201) {
        print('Deal added successfully');
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HiddenDrawer(),
            ),
          );
          print('Navigating to HiddenDrawer...');
        } else {
          print('Context is not mounted, unable to navigate.');
        }
      } else {
        print('Error adding deal');
        print('Response code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (context.mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
                    CircleAvatar(
                      radius:
                          100, // Adjust the radius to control the size of the circle
                      backgroundImage: imagegeted == true
                          ? FileImage(_image!)
                          : AssetImage(
                              'assets/images/addP.png',
                            ) as ImageProvider,
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();

                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        _image = File(image!.path);

                        if (image != null) {
                          setState(() {
                            imagegeted = true;
                          });
                          print("L'image: ${_image!.path}");
                        }
                      },
                      style: TextButton.styleFrom(
                        side: BorderSide(
                            color:
                                MyColors.btnBorderColor), // Add a border color
                      ),
                      child: Text(
                        "Add Your Image",
                        style: TextStyle(
                          color: MyColors.btnBorderColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
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
