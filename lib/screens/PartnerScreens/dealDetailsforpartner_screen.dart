import 'package:dealdiscover/client/client_service.dart';
import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/model/rates.dart';
import 'package:dealdiscover/model/user.dart';
import 'package:dealdiscover/screens/PartnerScreens/deals_management_screen.dart';
import 'package:dealdiscover/screens/UserScreens/AddPlanning_screen.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/screens/UserScreens/partner_profile_screen.dart';
import 'package:dealdiscover/screens/menus/hidden_drawer.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:dealdiscover/widgets/CommentItem.dart' as CommentItemWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PartnerDealDetailsScreen extends StatefulWidget {
  final String? pubId;
  final Pub pub;

  PartnerDealDetailsScreen({Key? key, required this.pubId, required this.pub})
      : super(key: key);

  @override
  State<PartnerDealDetailsScreen> createState() =>
      _PartnerDealDetailsScreenState();
}

class _PartnerDealDetailsScreenState extends State<PartnerDealDetailsScreen> {
  bool isLoading = false;
  bool isFavorited = false;
  int rating = 0;
  int totalRatings = 0;
  bool hasUserRated = false; // Track if user has rated in this session
  late ClientService clientService;
// Initialisez votre service de taux

  @override
  void initState() {
    super.initState();

    clientService = ClientService();
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
            image: AssetImage('assets/images/chatbg.png'),
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
                  height: 850,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image(
                          image: widget.pub.pubImage != null
                              ? NetworkImage(
                                  'http://10.0.2.2:3000/images/${widget.pub.pubImage}')
                              : AssetImage('assets/images/vitrine1.png')
                                  as ImageProvider,
                          width: MediaQuery.of(context).size.width,
                          height: 350,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              elevation: MaterialStateProperty.all<double>(
                                  1), // Remove elevation
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Set border radius
                                  side: BorderSide(
                                      color: MyColors
                                          .btnBorderColor), // Set border color
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              child: Text(
                                widget.pub.title ?? 'No Title',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 2), // Add space between the two rows
                        ],
                      ),

                      SizedBox(height: 5), // Add spacing between rows
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                          ),
                          Image.asset(
                            'assets/images/location.png',
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.pub.adress ?? 'No Address',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: List.generate(
                              5,
                              (index) => GestureDetector(
                                /*  onTap: hasUserRated
                                    ? null
                                    : () {
                                        setState(() {
                                          rating = index + 1;
                                        });
                                        createRate(rating);
                                      },*/
                                child: Icon(
                                  Icons.star,
                                  color: index < rating
                                      ? Colors.yellow
                                      : Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '$rating / 5',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                          ),
                          Text(
                            '($totalRatings reviews)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 15),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20), // Add horizontal margin
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            // ListView.separated(
                            //   shrinkWrap: true,
                            //   physics: NeverScrollableScrollPhysics(),
                            //   itemCount: 1,
                            //   separatorBuilder: (context, index) {
                            //     // Add space between comments
                            //     return SizedBox(
                            //         height: 5); // Adjust the height as needed
                            //   },
                            //   itemBuilder: (context, index) {
                            //     // Replace 'This is a sample comment.' with actual comment data
                            //     return CommentItemWidget.CommentItem();
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ],
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
            builder: (_) => const HiddenDrawer(),
          ),
        );
      });
    });
  }
}
