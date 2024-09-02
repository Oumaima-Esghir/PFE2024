import 'dart:convert'; // Import for JSON encoding

import 'dart:io';
import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/screens/PartnerScreens/deals_management_screen.dart';
import 'package:dealdiscover/screens/menus/hidden_drawer.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for HTTP requests

class EditDealScreen extends StatefulWidget {
  final Pub pub;
  const EditDealScreen({super.key, required this.pub});

  @override
  State<EditDealScreen> createState() => _EditDealScreenState();
}

class _EditDealScreenState extends State<EditDealScreen> {
  String? stateValue;
  bool isLoading = false;
  late TextEditingController titleController;
  late TextEditingController addressController;
  late TextEditingController descriptionController;
  late TextEditingController dureeController;
  late TextEditingController pourcentageController;
  File? _image;
  bool imagegeted = false;
  @override
  void initState() {
    super.initState();
    // Initialize controllers with pub data
    titleController = TextEditingController(text: widget.pub.title);
    addressController = TextEditingController(text: widget.pub.adress);
    descriptionController = TextEditingController(text: widget.pub.description);
    dureeController = TextEditingController(text: widget.pub.duree);
    pourcentageController =
        TextEditingController(text: widget.pub.pourcentage.toString());
    stateValue = widget.pub.state == 'promo' ? 'promo' : 'not in promo';
    bool imagegeted = false;
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    titleController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    dureeController.dispose();
    pourcentageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPromoDisabled = widget.pub.state == 'offre';
    String imageUrl = '';
    TimeOfDay selectedTime = TimeOfDay.now();

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
                          : NetworkImage(
                                  'http://192.168.1.7:3000/images/${widget.pub.pubImage}')
                              as ImageProvider,
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
                        "Edit Your Image",
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
                  height: 855,
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
                          controller: titleController,
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
                          controller: addressController,
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
                          controller: descriptionController,
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
                                onChanged: isPromoDisabled
                                    ? null
                                    : (value) {
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
                      if (widget.pub.state != 'offre') ...[
                        Text(
                          "Duration",
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
                            controller: dureeController,
                            decoration: InputDecoration(
                              hintText: "Write duration",
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
                          "pourcentage",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 110, 127, 139),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 350,
                          height: 55,
                          child: TextField(
                            controller: pourcentageController,
                            decoration: InputDecoration(
                              hintText: "Write pourcentage",
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
                      ] else ...[
                        Text(
                          "Deal State",
                          style: TextStyle(
                            color: MyColors.btnBorderColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      SizedBox(height: 25),
                      Container(
                        width: 350,
                        height: 50,
                        child: SizedBox(
                          height: 60,
                          width: 350,
                          child: TextButton(
                            onPressed: () async {
                              updateDeal();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  MyColors.btnColor),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

// Ensure the token is correctly retrieved
  Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  void updateDeal() async {
    setState(() {
      isLoading = true;
    });

    // API endpoint and request

    final token = await getToken();

    // Encode image to base64 if it's been changed
    try {
      var request = http.MultipartRequest(
          'PUT', Uri.parse('http://192.168.1.7:3000/pubs/${widget.pub.id}'));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data'
      });
      request.fields['title'] = titleController.text;
      request.fields['adress'] = addressController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['duree'] = dureeController.text;
      request.fields['pourcentage'] = pourcentageController.text;
      request.fields['state'] = stateValue!;

      if (imagegeted == true) {
        request.files.add(
          await http.MultipartFile.fromPath('pubImage', _image!.path),
        );
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        print('Deal updated successfully');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DealsManagementScreen()));
      } else {
        print('Error updating deal');
        print('Response code: ${response.statusCode}');
        // Debugging response body
        var responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
