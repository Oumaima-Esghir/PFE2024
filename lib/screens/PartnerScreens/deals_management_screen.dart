import 'package:dealdiscover/screens/PartnerScreens/add_deal_screen.dart';
import 'package:dealdiscover/screens/PartnerScreens/signup_partner_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:dealdiscover/widgets/DealPartnerItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealsManagementScreen extends StatefulWidget {
  const DealsManagementScreen({super.key});

  @override
  State<DealsManagementScreen> createState() => _DealsManagementScreenState();
}

class _DealsManagementScreenState extends State<DealsManagementScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      /* appBar: AppBar(
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
      ),*/
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
                width: 350,
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Deals",
                          style: TextStyle(
                            fontSize: 22, // Customize the text style as needed
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your sign in logic here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddDealScreen()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: MyColors.btnBorderColor, width: 2),
                                ),
                              ),
                              fixedSize: MaterialStateProperty.all<Size>(
                                  Size(160, 50)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Add Deal',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(width: 10),
                                Image.asset(
                                  'assets/images/add.png',
                                  width: 40,
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Add more widgets here as needed
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: EdgeInsets.all(
                    10,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        DealPartnerItem(),
                        SizedBox(height: 10),
                        DealPartnerItem(),
                        SizedBox(height: 10),
                        DealPartnerItem(),
                        SizedBox(height: 10),
                        DealPartnerItem(),
                        SizedBox(height: 10),
                        DealPartnerItem(),
                      ],
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
            builder: (_) => const SignUpPartnerScreen(),
          ),
        );
      });
    });
  }
}
