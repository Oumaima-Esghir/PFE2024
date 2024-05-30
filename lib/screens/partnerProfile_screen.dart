import 'package:dealdiscover/model/place.dart';
import 'package:dealdiscover/screens/dealDetails_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PartnerProfileScreen extends StatefulWidget {
  const PartnerProfileScreen({super.key});

  @override
  State<PartnerProfileScreen> createState() => _PartnerProfileScreenState();
}

class _PartnerProfileScreenState extends State<PartnerProfileScreen> {
  
   late Place place;
  bool isLoading1 = false;

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
                        borderRadius: BorderRadius.circular(
                            90), // Adjust the radius as needed

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // Distribute space evenly between boxes
                        children: [
                          SizedBox(
                            height: 65,
                            width: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.backbtn1,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: MyColors.btnColor,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "2", // Replace with your changeable text
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Posts", // Replace with your static text
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 65,
                            width: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.backbtn1,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: MyColors.btnColor,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "20", // Replace with your changeable text
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Reviews", // Replace with your static text
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 65,
                            width: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.backbtn1,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: MyColors.btnColor,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "60", // Replace with your changeable text
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      "Likes", // Replace with your static text
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                      "Posts",
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
            builder: (_) => DealDetailsScreen(placeId: place.id,place: place),
          ),
        );
      });
    });
  }
}
