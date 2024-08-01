import 'dart:convert';

import 'package:dealdiscover/client/client_service.dart';
import 'package:dealdiscover/model/user.dart';
import 'package:dealdiscover/screens/PartnerScreens/signup_partner_screen.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/screens/authentication/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  //String? genderValue;
  int age = 20;
  String _email = '';
  String? _emailError;
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _signup() async {
    if (_email.isEmpty || !_isValidEmail(_email)) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
      return;
    }

    String _password = _passwordController.text;
    if (_password.isEmpty || _password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 8 characters long')),
      );
      return;
    }

    if (_password != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    User user = User(
      user_id: null,
      email: _email,
      password: _password,
      age: age,
      username: _usernameController.text,
      lastname: _lastnameController.text,
      adress: _adressController.text,
    );

    ClientService clientService = ClientService();
    try {
      http.Response response = await clientService.signupuser(user);

      // Log the response status code and body for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        // Parse the JSON response
        var responseData = jsonDecode(response.body);
        String message =
            responseData['message']; // Extract message from the response
        if (message == "User successfully created!") {
          String userId =
              responseData['user']['id']; // Extract user ID from the response
          String token =
              responseData['user']['token']; // Extract token from the response

          await storeUserInfo(userId, _usernameController.text, token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
          );
        } else {
          setState(() {
            _errorMessage = 'Registration failed: ${response.body}';
          });
        }
      } else if (response.statusCode == 500) {
        var responseData = jsonDecode(response.body);
        if (responseData['error'].contains('duplicate key error')) {
          setState(() {
            _errorMessage = 'The email address is already in use.';
          });
        } else {
          setState(() {
            _errorMessage = 'Registration failed: ${response.body}';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Registration failed: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> storeUserInfo(
      String userId, String userName, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('userName', userName);
    await prefs.setString('token', token); // Store the token as well
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Sign Up Screen"),
        backgroundColor: MyColors.PColor,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sgbg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 351.904,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        "Create Your Account",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Please enter your information to create your account",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20.4),
                      Image(image: AssetImage('assets/images/su.png'))
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1500,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 200),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 17),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 27, vertical: 30),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: MyColors.PColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 60, // Adjust height as needed
                                  width:
                                      double.infinity, // Make button full width
                                  child: TextButton(
                                    onPressed: () {
                                      // Add your sign in logic here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpPartnerScreen()),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              MyColors.border2),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.white,
                                            width: 4,
                                          ), // Add white border
                                        ),
                                      ),
                                      shadowColor: MaterialStateProperty.all<
                                          Color>(const Color.fromARGB(
                                              255, 113, 113, 113)
                                          .withOpacity(
                                              0.2)), // Adjust color and opacity
                                      elevation: MaterialStateProperty.all<
                                              double>(
                                          5.0), // Adjust elevation for depth (static shadow)
                                    ),
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.black,
                                          )
                                        : Text(
                                            "Sign Up As A Partner",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "User Name",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: "Enter your user name",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              Text(
                                "Last Name",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _lastnameController,
                                decoration: InputDecoration(
                                  hintText: "Enter your last name",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Adress",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _adressController,
                                decoration: InputDecoration(
                                  hintText: "Enter your adress",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 20),
                              // Email label and input text
                              Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "Enter your email address",
                                  border: OutlineInputBorder(),
                                  errorText: _emailError,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _email = value;
                                    if (_isValidEmail(value)) {
                                      _emailError = null;
                                    } else {
                                      _emailError =
                                          'Please enter a valid email address';
                                    }
                                  });
                                },
                              ),
                              Text(
                                _emailError ?? '',
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(height: 20),
                              // Password label, input text, and visibility toggle button
                              Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  border: OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              // Confirm password label, input text, and visibility toggle button
                              Text(
                                "Confirm Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _confirmPasswordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "Confirm your password",
                                  border: OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              /*
                              // Gender label
                              Text(
                                "Gender",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: 60, // Adjust height as needed
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black), // White border
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60), // Add horizontal padding
                                  child: Row(
                                    children: [
                                      // Gender radio buttons
                                      Radio<String>(
                                        value: "male",
                                        groupValue: genderValue,
                                        onChanged: (value) {
                                          setState(() {
                                            genderValue = value;
                                          });
                                        },
                                        activeColor: MyColors
                                            .btnBorderColor, // Change the color of the selected radio button
                                      ),
                                      Text("Male"),
                                      Radio<String>(
                                        value: "female",
                                        groupValue: genderValue,
                                        onChanged: (value) {
                                          setState(() {
                                            genderValue = value;
                                          });
                                        },
                                        activeColor: MyColors
                                            .btnBorderColor, // Change the color of the selected radio button
                                      ),
                                      Text("Female"),
                                    ],
                                  ),
                                ),
                              ),*/
                              SizedBox(height: 20),
                              // Age label
                              Text(
                                "Age",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              // Container with buttons and number display
                              Container(
                                height: 60, // Adjust height as needed
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black), // White border
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly, // Space buttons evenly
                                  children: [
                                    // Decrease button
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (age > 0) {
                                            age--;
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          color: MyColors.btnColor,
                                          border: Border.all(
                                            color: Colors
                                                .black, // Set the border color here
                                            width:
                                                1, // Set the border width here
                                          ),
                                        ),
                                        child: Icon(Icons.remove,
                                            color: Colors.black),
                                      ),
                                    ),
                                    // Number display
                                    Text(
                                      age.toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    // Increase button
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (age < 100) {
                                            age++;
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          color: MyColors.btnColor,
                                          border: Border.all(
                                            color: Colors
                                                .black, // Set the border color here
                                            width:
                                                1, // Set the border width here
                                          ),
                                        ),
                                        child: Icon(Icons.add,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 20),
                              // Sign Up button
                              Center(
                                child: SizedBox(
                                  height: 50, // Adjust height as needed
                                  width:
                                      double.infinity, // Make button full width
                                  child: TextButton(
                                    onPressed: _isLoading ? null : _signup,
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              MyColors.btnColor),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.white,
                                            width: 4,
                                          ), // Add white border
                                        ),
                                      ),
                                    ),
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.black)
                                        : Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              if (_errorMessage != null)
                                Text(
                                  _errorMessage!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        30), // Same margin as the button
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already Have Account ?",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Navigate to the sign-up screen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SigninScreen()),
                                        );
                                      },
                                      child: Text(
                                        "SignIn",
                                        style: TextStyle(
                                          color: MyColors
                                              .btnColor, // Set text color to match button color
                                          decoration: TextDecoration.underline,
                                          decorationColor: MyColors.btnColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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

  bool _isValidEmail(String email) {
    // Regular expression for email validation
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
