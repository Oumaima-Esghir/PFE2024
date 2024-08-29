import 'package:dealdiscover/client/client_service.dart';
import 'package:dealdiscover/model/pub.dart';
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
  late Future<List<Pub>> partnerPubs;
  ClientService clientService = ClientService();

  @override
  void initState() {
    super.initState();
    partnerPubs = clientService.partnerpubs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Deals",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddDealScreen(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: MyColors.btnBorderColor, width: 2),
                          ),
                        ),
                        fixedSize:
                            MaterialStateProperty.all<Size>(Size(160, 50)),
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder<List<Pub>>(
                  future: partnerPubs,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: snapshot.data!.map((pub) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                children: [
                                  DealPartnerItem(pub: pub),
                                  SizedBox(
                                      height:
                                          10), // Ajoute un espace de 10 pixels entre les éléments
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      return Center(child: Text('No deals available'));
                    }
                  },
                ),
              ),
            ],
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
            builder: (_) => const SignUpPartnerScreen(),
          ),
        );
      });
    });
  }
}
