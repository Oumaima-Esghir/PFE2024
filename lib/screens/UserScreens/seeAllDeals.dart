import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/screens/UserScreens/accueil_screen.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/widgets/AllDealsCard.dart' as AllDealsCardWidget;
import 'package:dealdiscover/widgets/PromoCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeeAllDealsScreen extends StatefulWidget {
  const SeeAllDealsScreen({super.key});

  @override
  State<SeeAllDealsScreen> createState() => _SeeAllDealsScreenState();
}

class _SeeAllDealsScreenState extends State<SeeAllDealsScreen> {
  bool isLoading = false;
  List<Pub> PromoPubs = [];

  @override
  void initState() {
    super.initState();
    PromoPubs = listOfIPubs
        .where((pub) => pub.state != null && pub.state == 'offre')
        .toList();
    // futurePubs = clientService.getPubs();
    // print("zz" + futurePubs.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
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
                SizedBox(height: 120),
                Container(
                  width: double
                      .infinity, // Ensures the text takes the full width of the container
                  child: Text(
                    'All Deals',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left, // Aligns the text to the start
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Builder(builder: (BuildContext context) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: PromoPubs.map((pub) {
                        print(pub);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: PromoCard(
                            pub: pub, // Pass the pub to DealCard
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
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
            builder: (_) => BottomNavBar(),
          ),
        );
      });
    });
  }
}
