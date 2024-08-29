import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/screens/UserScreens/EditProfile_screen.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/screens/authentication/signin_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:dealdiscover/widgets/DealCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; // Import jwt_decoder

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading1 = false;
  bool isLoading2 = false;
  List<Pub> filteredPubs = [];
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  Future<void> _getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    print("helloo");
    if (token.isNotEmpty) {
      // Decode the token
      final decodedToken = JwtDecoder.decode(token);
      print(decodedToken);
    }
    //  Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => EditProfileScreen()),
    //                           );
  }

  /* @override
  void initState() {
    super.initState();
    filteredPubs = listOfIPubs
        .where((pub) => pub.state != null && pub.state == 'offre')
        .toList();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            loadingHandler1(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 10),
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
            image: AssetImage('assets/images/userp.png'),
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
                        borderRadius: BorderRadius.circular(90),
                        child: Image.asset(
                          'assets/images/user_pic.png',
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Oumaima Esghir",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          height: 60,
                          width: 250,
                          child: TextButton(
                            onPressed: () => _getUserDetails,
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
                                  ),
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
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Favories",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Display DealCard widgets here
                        /*   SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: filteredPubs.map((pub) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: DealCard(
                                  pub: pub,
                                ),
                              );
                            }).toList(),
                          ),
                        ),*/
                      ],
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

  void loadingHandler1(BuildContext context) {
    setState(() {
      isLoading1 = true;
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading1 = false;
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => BottomNavBar(),
          ),
        );
      });
    });
  }
}
