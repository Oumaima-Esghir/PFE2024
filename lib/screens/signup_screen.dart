import 'package:dealdiscover/screens/bottomnavbar.dart';
import 'package:dealdiscover/screens/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  String? genderValue;
  int age = 10;
  String _email = '';
  String? _emailError;
  final TextEditingController _passwordController = TextEditingController();

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
                          Container(
                            child: Image.asset(
                              'assets/images/addP.png',
                              width: 100, // Adjust the width as needed
                              height: 100, // Adjust the height as needed
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "User Name",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "Enter your user name",
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
                              // Password label, input text, and visibility toggle button
                              Text(
                                "Confirm Password",
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
                              // Gender label
                              Text(
                                "Gender",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              // Box with the same size as input text confirm password
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
                              ),
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
                                    onPressed: () {
                                      // Add your  logic here
                                      // Validate email
                                      if (_email.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Please enter your email address'),
                                          ),
                                        );
                                        return;
                                      } else if (!_isValidEmail(_email)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Please enter a valid email address'),
                                          ),
                                        );
                                        return;
                                      }

                                      // Validate password
                                      String password =
                                          _passwordController.text;
                                      if (password.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Please enter your password'),
                                          ),
                                        );
                                        return;
                                      }

// Check if the password meets the minimum length requirement
                                      if (password.length < 8) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Password must be at least 8 characters long'),
                                          ),
                                        );
                                        return;
                                      }

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavBar()),
                                      );
                                    },
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
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
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
