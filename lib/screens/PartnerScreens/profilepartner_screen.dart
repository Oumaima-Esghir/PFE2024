import 'package:dealdiscover/screens/PartnerScreens/edit_profile_partner.dart';
import 'package:dealdiscover/screens/authentication/signin_screen.dart';
import 'package:dealdiscover/screens/menus/hidden_drawer.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileAsPartnerScreen extends StatefulWidget {
  const ProfileAsPartnerScreen({super.key});

  @override
  State<ProfileAsPartnerScreen> createState() => _ProfileAsPartnerScreenState();
}

class _ProfileAsPartnerScreenState extends State<ProfileAsPartnerScreen> {
  //bool isLoading1 = false;
  bool isLoading2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            //  loadingHandler1(context);
          },
          /* child: Container(
            margin: EdgeInsets.only(left: 10), // Adjust margin as needed
            child: Image.asset(
              'assets/images/arrowL.png',
              width: 45.0,
              height: 45.0,
            ),
          ),*/
        ),
        actions: [
          GestureDetector(
            onTap: () {
              loadingHandler2(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/images/disconnect.png',
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            90), // Adjust the radius as needed*/

                        child: Image(
                          image: AssetImage('assets/images/vitrine1.png'),
                          width: 180,
                          height: 180,

                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        "The Secret Coffe Shop",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          height: 60, // Adjust height as needed
                          width: 250, // Make button full width
                          child: TextButton(
                            onPressed: () {
                              // Add your logic here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfilePartnerScreen()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  MyColors.btnColor),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: MyColors.backbtn1,
                                    width: 4,
                                  ), // Add white border
                                ),
                              ),
                            ),
                            child: Text(
                              "Edit Profile",
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 700,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20), // Adjust the left margin as needed
                    child: Text(
                      "My Deals",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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

  void loadingHandler2(BuildContext context) {
    setState(() {
      isLoading2 = true;
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading2 = false;
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => const SigninScreen(),
          ),
        );
      });
    });
  }

  /* void loadingHandler1(BuildContext context) {
    setState(() {
      isLoading1 = true;
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading1 = false;
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => HiddenDrawer(),
          ),
        );
      });
    });
  }*/
}
