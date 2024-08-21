import 'package:dealdiscover/client/client_service.dart';
import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/screens/UserScreens/seeAllDeals.dart';
import 'package:dealdiscover/screens/UserScreens/seeAllPromo.dart';
import 'package:dealdiscover/screens/authentication/signin_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:dealdiscover/widgets/DealCard.dart' as DealCardWidget;
import 'package:dealdiscover/widgets/DealCard.dart';
import 'package:dealdiscover/widgets/PromoCard.dart' as PromoCardWidget;
import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/widgets/PromoCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({Key? key}) : super(key: key);
  @override
  _AccueilScreenState createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  late Future<List<Pub>>? futurePubs;
  late Future<List<Pub>>? bestDealsPubs;
  late Future<List<Pub>>? topPromotionsPubs;
  ClientService clientService = ClientService();
  //List<Pub> filteredPubs = [];
  //List<Pub> PromoPubs = [];

  @override
   void initState() {
    super.initState();
    futurePubs = clientService.getPubs();
    bestDealsPubs = futurePubs?.then((pubs) => pubs.where((pub) => pub.state == 'offre').toList());
    topPromotionsPubs = futurePubs?.then((pubs) => pubs.where((pub) => pub.state == 'promo').toList());
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            image: AssetImage('assets/images/botbg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              children: [
                Container(
                  width: 280,
                  height: 65,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.1),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.search, color: Colors.white),
                        SizedBox(width: 50),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle button tap
                          },
                          child: Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.grey,
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/filter.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.btnColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                Container(
                  width: 400,
                  height: 3000,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Best Deals',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SeeAllDealsScreen()),
                                );
                              },
                              child: Text(
                                'See All Deals', // Replace with your desired text
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black, // Link color
                                  decoration:
                                      TextDecoration.underline, // Underline
                                ),
                              ),
                            ),
                          ],
                        ),
                       SizedBox(height: 20),
                FutureBuilder<List<Pub>>(
                  future: bestDealsPubs,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: snapshot.data!.map((pub) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: DealCard(
                                pub: pub,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      return Text('No deals available');
                    }
                  },
                ),
                SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Top Promotions',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SeeAllPromotionsScreen()),
                                );
                              },
                              child: Text(
                                'See All Promotions', // Replace with your desired text
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black, // Link color
                                  decoration:
                                      TextDecoration.underline, // Underline
                                ),
                              ),
                            ),
                          ],
                        ),
                       SizedBox(height: 10),
                FutureBuilder<List<Pub>>(
                  future: topPromotionsPubs,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: snapshot.data!.map((pub) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: PromoCard(
                                pub: pub,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      return Text('No promotions available');
                    }
                  },
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
            builder: (_) => const SigninScreen(),
          ),
        );
      });
    });
  }
}
