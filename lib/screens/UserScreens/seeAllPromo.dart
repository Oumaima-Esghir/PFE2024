import 'package:dealdiscover/client/client_service.dart';
import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/screens/UserScreens/accueil_screen.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/widgets/PromoCard.dart' as PromoCardWidget;
import 'package:dealdiscover/widgets/PromoCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeeAllPromotionsScreen extends StatefulWidget {
  const SeeAllPromotionsScreen({super.key});

  @override
  State<SeeAllPromotionsScreen> createState() => _SeeAllDealsScreenState();
}

class _SeeAllDealsScreenState extends State<SeeAllPromotionsScreen> {
  bool isLoading = false;
  late Future<List<Pub>>? futurePubs;
 late Future<List<Pub>>? PromoPubs;
 ClientService clientService = ClientService();

  @override
  void initState() {
    super.initState();
    futurePubs = clientService.getPubs();
    PromoPubs = futurePubs?.then((pubs) => pubs.where((pub) => pub.state == 'promo').toList());
  }

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
            image: AssetImage('assets/images/partnerbg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                SizedBox(height: 80),
                Container(
                  width: double
                      .infinity, // Ensures the text takes the full width of the container
                  child: Text(
                    'All Promotions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left, // Aligns the text to the start
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
               FutureBuilder<List<Pub>>(
                  future: PromoPubs,
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
                              child: PromoCard(
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
            builder: (_) => const BottomNavBar(),
          ),
        );
      });
    });
  }
}
