import 'dart:convert';
import 'dart:io';

import 'package:dealdiscover/screens/UserScreens/profile_screen.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? userData;
  const EditProfileScreen({super.key, this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _obscureActualPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _actualPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  int age = 25;

  File? _image;
  bool imagegeted = false;

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
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    String username = _userNameController.text.trim();
    String address = _addressController.text.trim();

    if (username.isEmpty || address.isEmpty) {
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Both username and address are required.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final token = await getToken();

    // Check if the fields are empty or passwords don't match
    if (newPassword.isNotEmpty && confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please confirm your new password.')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (newPassword.isNotEmpty && newPassword.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('New password must be at least 8 characters long.')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match.')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      var request = http.MultipartRequest(
          'PUT', Uri.parse('http://192.168.1.6:3000/users/update'));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data'
      });

      request.fields['username'] = username;
      request.fields['address'] = address; // Ensure correct spelling

      if (newPassword.isNotEmpty) {
        request.fields['password'] = newPassword;
      }

      if (imagegeted && _image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', _image!.path));
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully.')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      } else {
        print('Failed to update profile. Status code: ${response.statusCode}');
        print('Error response: $responseBody');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile.')),
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
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
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: [
                Container(
                  width: 350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image(
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                          image: imagegeted
                              ? FileImage(_image!)
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
                          if (image != null) {
                            setState(() {
                              _image = File(image.path);
                              imagegeted = true;
                            });
                            print("Image path: ${_image!.path}");
                          }
                        },
                        style: TextButton.styleFrom(
                          side: BorderSide(color: MyColors.btnBorderColor),
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
                      SizedBox(height: 30),
                      Text(
                        "User Name",
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
                          controller: _userNameController,
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
                      Text(
                        "Actual Password",
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
                          controller: _actualPasswordController,
                          obscureText: _obscureActualPassword,
                          decoration: InputDecoration(
                            hintText: "Enter your current password",
                            filled: true,
                            fillColor: MyColors.backbtn1,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureActualPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: MyColors.btnBorderColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureActualPassword =
                                      !_obscureActualPassword;
                                });
                              },
                            ),
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
                          controller: _newPasswordController,
                          obscureText: _obscureNewPassword,
                          decoration: InputDecoration(
                            hintText: "Enter your new password",
                            filled: true,
                            fillColor: MyColors.backbtn1,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureNewPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: MyColors.btnBorderColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureNewPassword = !_obscureNewPassword;
                                });
                              },
                            ),
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
                        "Confirm New Password",
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
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            hintText: "Confirm your new password",
                            filled: true,
                            fillColor: MyColors.backbtn1,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: MyColors.btnBorderColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
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
                      Container(
                        width: 350,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _updateProfile,
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
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  "Save",
                                  style: TextStyle(fontSize: 16),
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

  void loadingHandler(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }
}
