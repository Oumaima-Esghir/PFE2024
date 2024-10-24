import 'dart:convert'; // For jsonEncode
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dealdiscover/screens/PartnerScreens/profilepartner_screen.dart';
import 'package:dealdiscover/screens/menus/hidden_drawer.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePartnerScreen extends StatefulWidget {
  final Map<String, dynamic>? userData; // Expect userData as a Map

  const EditProfilePartnerScreen({super.key, this.userData});

  @override
  State<EditProfilePartnerScreen> createState() =>
      _EditProfilePartnerScreenState();
}

class _EditProfilePartnerScreenState extends State<EditProfilePartnerScreen> {
  bool _obscureActualPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  final TextEditingController _actualpasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool isLoading = false;

  File? _image;
  bool imagegeted = false;

  @override
  void initState() {
    super.initState();
    if (widget.userData != null) {
      _usernameController.text = widget.userData?['name'] ?? "";
      _addressController.text = widget.userData?['adress'] ?? "";

      bool imagegeted = false;
    }
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

  Future<void> _updateProfile() async {
    // Validate passwords

    String newPassword = _passwordController.text;
    String confirmPassword =
        _confirmpasswordController.text; // Assuming same controller

    setState(() {
      isLoading = true;
    });
    final token = await getToken();

    try {
      var request = http.MultipartRequest(
          'PUT', Uri.parse('http://192.168.1.6:3000/partenaires/update'));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data'
      });

      final body = jsonEncode({
        'name': _usernameController.text,
        'adress': _addressController.text,
        // 'actualPassword': actualPassword,
        'password': newPassword,
      });

      if (newPassword.isNotEmpty && confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('All fields are required')),
        );
        return;
      }

      if (newPassword.isNotEmpty && newPassword.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('New password must be at least 8 characters long')),
        );
        return;
      }

      if (newPassword != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      if (imagegeted == true) {
        request.files.add(
          await http.MultipartFile.fromPath('image', _image!.path),
        );
      }
      var response = await request.send();

      if (response.statusCode == 200) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HiddenDrawer(),
          ),
        );
      } else {
        // Failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
      }
    } catch (e) {
      // Handle exceptions
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
            child: Column(
              children: [
                Container(
                  width: 350,
                  height: 750,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            90), // Adjust the radius as needed
                        child: Image(
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover, // Adjust the fit as needed
                          image: imagegeted == true
                              ? FileImage(_image!)
                              //widget.userData != null &&
                              //      widget.userData?['image'] != null
                              : NetworkImage(
                                      'http://192.168.1.6:3000/images/${widget.userData?['image']}')
                                  as ImageProvider,
                        ),
                      ),

                      SizedBox(height: 15),
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
                              color: MyColors
                                  .btnBorderColor), // Add a border color
                        ),
                        child: Text(
                          "Edit Your Image",
                          style: TextStyle(
                            color: MyColors.btnBorderColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Partner Name",
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
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: "Update your user name",
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
                          controller: _addressController,
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
                      // Text(
                      //   "Actual Password",
                      //   style: TextStyle(
                      //     color: MyColors.btnBorderColor,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(height: 10),
                      // SizedBox(
                      //   width: 350,
                      //   height: 55,
                      //   child: TextField(
                      //     controller: _actualpasswordController,
                      //     obscureText: _obscureActualPassword,
                      //     decoration: InputDecoration(
                      //       hintText: "Enter your actual password",
                      //       filled: true,
                      //       fillColor: MyColors.backbtn1,
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: MyColors.btnColor,
                      //           width: 1,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: MyColors.btnBorderColor,
                      //           width: 1,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //       suffixIcon: IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             _obscureActualPassword =
                      //                 !_obscureActualPassword;
                      //           });
                      //         },
                      //         icon: Icon(
                      //           _obscureActualPassword
                      //               ? Icons.visibility
                      //               : Icons.visibility_off,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 20),
                      Text(
                        "New Password",
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
                          controller: _passwordController,
                          obscureText: _obscureNewPassword,
                          decoration: InputDecoration(
                            hintText: "Enter your new password",
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
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureNewPassword = !_obscureNewPassword;
                                });
                              },
                              icon: Icon(
                                _obscureNewPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Confirm Password",
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
                          controller: _confirmpasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            hintText: "Confirm your password",
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
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Center(
                      child: SizedBox(
                        height: 60,
                        width: 350,
                        child: TextButton(
                          onPressed:
                              _updateProfile, // Update profile on button press
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                MyColors.btnColor),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: Colors.white, width: 4),
                              ),
                            ),
                          ),
                          child: Text(
                            "Save",
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
            builder: (_) => const HiddenDrawer(),
          ),
        );
      });
    });
  }
}
