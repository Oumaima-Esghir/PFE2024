import 'package:dealdiscover/screens/menus/hidden_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticsPartnerScreen extends StatefulWidget {
  const StatisticsPartnerScreen({super.key});

  @override
  State<StatisticsPartnerScreen> createState() =>
      _StatisticsPartnerScreenState();
}

class _StatisticsPartnerScreenState extends State<StatisticsPartnerScreen> {
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
        child: SingleChildScrollView(),
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
            builder: (_) => const HiddenDrawer(),
          ),
        );
      });
    });
  }
}
