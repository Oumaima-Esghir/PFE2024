import 'package:dealdiscover/screens/UserScreens/profile_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _obscureActualPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _actualpasswordController =
      TextEditingController();
  bool isLoading = false;
  int age = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                height: 900,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/addP.png',
                      width: 200,
                      height: 200,
                    ),
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
                      width: 350, // Adjust width as needed
                      height: 55, // Adjust height as needed
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Update your user name",
                          filled:
                              true, // Set to true to fill the TextField background
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
                      "Adress",
                      style: TextStyle(
                        color: MyColors.btnBorderColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 350, // Adjust width as needed
                      height: 55, // Adjust height as needed
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Update your adress",
                          filled:
                              true, // Set to true to fill the TextField background
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
                      "Age",
                      style: TextStyle(
                        color: MyColors.btnBorderColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 60, // Adjust height as needed
                      decoration: BoxDecoration(
                        color: MyColors.backbtn1,
                        border: Border.all(
                            color: MyColors.btnColor), // White border
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
                                color: MyColors.border2,
                                border: Border.all(
                                  color: MyColors
                                      .btnColor, // Set the border color here
                                  width: 1, // Set the border width here
                                ),
                              ),
                              child: Icon(Icons.remove,
                                  color: MyColors.btnBorderColor),
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
                                color: MyColors.border2,
                                border: Border.all(
                                  color: MyColors
                                      .btnColor, // Set the border color here
                                  width: 1, // Set the border width here
                                ),
                              ),
                              child: Icon(Icons.add,
                                  color: MyColors.btnBorderColor),
                            ),
                          ),
                        ],
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
                      width: 350, // Adjust width as needed
                      height: 55, // Adjust height as needed
                      child: TextField(
                        controller: _actualpasswordController,
                        obscureText: _obscureActualPassword,
                        decoration: InputDecoration(
                          hintText: "Enter your  actual password",
                          filled:
                              true, // Set to true to fill the TextField background
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
                                _obscureActualPassword =
                                    !_obscureActualPassword;
                              });
                            },
                            icon: Icon(
                              _obscureActualPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
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
                      width: 350, // Adjust width as needed
                      height: 55, // Adjust height as needed
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscureNewPassword,
                        decoration: InputDecoration(
                          hintText: "Enter your  new password",
                          filled:
                              true, // Set to true to fill the TextField background
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
                      width: 350, // Adjust width as needed
                      height: 55, // Adjust height as needed
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          hintText: "Confirm your password",
                          filled:
                              true, // Set to true to fill the TextField background
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
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  // Adjust the left margin as needed
                  child: Center(
                    child: SizedBox(
                      height: 60, // Adjust height as needed
                      width: 350, // Make button full width
                      child: TextButton(
                        onPressed: () {
                          // Validate password
                          String password = _passwordController.text;
                          if (password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter your password'),
                              ),
                            );
                            return;
                          }

// Check if the password meets the minimum length requirement
                          if (password.length < 8) {
                            ScaffoldMessenger.of(context).showSnackBar(
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
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              MyColors.btnColor),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: Colors.white,
                                width: 4,
                              ), // Add white border
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
            builder: (_) => const ProfileScreen(),
          ),
        );
      });
    });
  }
}
