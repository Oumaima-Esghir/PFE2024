import 'package:dealdiscover/client/client.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/screens/onboarding%20_screen%20.dart';
import 'package:dealdiscover/screens/UserScreens/signup_user_screen.dart';
import 'package:dealdiscover/screens/menus/hidden_drawer.dart'; // Import HiddenDrawer screen
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dealdiscover/client/client_service.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isLoading1 = false;
  bool isLoading2 = false;
  bool _obscureText = true;
  String _email = '';
  String? _emailError;
  String? _passwordError;
  String _selectedUserType = 'user'; // default to 'user'
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            loadingHandler1(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 10), // Adjust margin as needed
            child: Image.asset(
              'assets/images/arrowL.png',
              width: 45.0,
              height: 45.0,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              loadingHandler2(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/images/arrowR.png',
                width: 45.0,
                height: 45.0,
              ),
            ),
          ),
        ],
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
                  height: 500,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/demo.png'),
                        width: 350, // Set the width of the image
                        height: 350,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Welcome Back !!",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Please  enter your informations",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 900,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 200),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 17),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 27, vertical: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: MyColors.backbtn1,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButton<String>(
                            value: _selectedUserType,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedUserType = newValue!;
                              });
                            },
                            items: <String>['user', 'partner']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value == 'user' ? 'User' : 'Partner',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20),
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
                              // Validate email on every change
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
                          // User type dropdown
                          SizedBox(height: 20),

                          // SizedBox(height: 5),
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
                              errorText: _passwordError,
                            ),
                          ),
                          SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  // Add your forgot password function here
                                  print('Forgot Password tapped');
                                  // You can navigate to the forgot password screen or show a dialog
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors
                                        .black, // Optional: Add color to indicate it's clickable
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Sign In button
                          Center(
                            child: SizedBox(
                              height: 50, // Adjust height as needed
                              width: double.infinity, // Make button full width
                              child: TextButton(
                                onPressed: _signin,
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
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: Colors.white,
                                        width: 4,
                                      ), // Add white border
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  10), // Add spacing between the button and the text
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 8), // Same margin as the button
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Not A Member ? ",
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
                                                SignUpScreen()),
                                      );
                                    },
                                    child: Text(
                                      "SignUp",
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

  void _signin() async {
    String email = _email;
    String password = _passwordController.text;

    if (email.isEmpty) {
      setState(() {
        _emailError = 'Please enter your email address';
      });
      return;
    } else if (!_isValidEmail(email)) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Please enter your password';
      });
      return;
    }

    if (password.length < 8) {
      setState(() {
        _passwordError = 'Password must be at least 8 characters long';
      });
      return;
    }

    try {
      ClientService clientService = ClientService();
      http.Response response;

      if (_selectedUserType == 'user') {
        response = await clientService.signinuser(email, password);
      } else {
        response = await clientService.partnersignin(email, password);
      }

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final user = jsonResponse['user'] as Map<String, dynamic>;

        if (user.containsKey('token') &&
            user['token'] != null &&
            user.containsKey('roles') &&
            user['roles'] != null) {
          String token = user['token'];
          List<dynamic> roles = user['roles'];
          String userType = roles.contains('partenaire') ? 'partner' : 'user';

          print("Token: $token");
          print("User Type: $userType");

          Client client = Client();
          client.setToken(token);

          // Delay SnackBar display
          Future.delayed(Duration(milliseconds: 100), () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login successful'),
              ),
            );
          });

          if (userType == 'partner') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HiddenDrawer()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
            );
          }
        } else {
          throw Exception("Missing or null token/roles in response");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${response.body}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  void loadingHandler1(BuildContext context) {
    setState(() {
      isLoading1 = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      ).then((_) {
        setState(() {
          isLoading1 = false;
        });
      });
    });
  }

  void loadingHandler2(BuildContext context) {
    setState(() {
      isLoading2 = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => const BottomNavBar(),
        ),
      ).then((_) {
        setState(() {
          isLoading2 = false;
        });
      });
    });
  }
}
