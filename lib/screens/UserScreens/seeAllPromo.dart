import 'package:dealdiscover/screens/UserScreens/accueil_screen.dart';
import 'package:dealdiscover/widgets/PromoCard.dart' as PromoCardWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeeAllPromotionsScreen extends StatefulWidget {
  const SeeAllPromotionsScreen({super.key});

  @override
  State<SeeAllPromotionsScreen> createState() => _SeeAllDealsScreenState();
}

class _SeeAllDealsScreenState extends State<SeeAllPromotionsScreen> {
  bool isLoading = false;

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
                SizedBox(height: 110),
                Container(
                  width: double
                      .infinity, // Ensures the text takes the full width of the container
                  child: Text(
                    'Top Promotions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left, // Aligns the text to the start
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                PromoCardWidget.PromoCard(),
                SizedBox(height: 20),
                PromoCardWidget.PromoCard(),
                SizedBox(height: 20),
                PromoCardWidget.PromoCard(),
                SizedBox(height: 20),
                PromoCardWidget.PromoCard(),
                SizedBox(height: 20),
                PromoCardWidget.PromoCard(),
                SizedBox(height: 20),
                PromoCardWidget.PromoCard(),
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
            builder: (_) => const AccueilScreen(),
          ),
        );
      });
    });
  }
}
