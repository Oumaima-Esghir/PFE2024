import 'package:dealdiscover/client/client_service.dart';
import 'package:dealdiscover/model/place.dart';
import 'package:dealdiscover/model/rates.dart';
import 'package:dealdiscover/model/user.dart';
import 'package:dealdiscover/screens/AddPlanning_screen.dart';
import 'package:dealdiscover/screens/bottomnavbar.dart';
import 'package:dealdiscover/screens/partnerProfile_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:dealdiscover/widgets/CommentItem.dart' as CommentItemWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DealDetailsScreen extends StatefulWidget {
  final String placeId;
  final Place place;

  DealDetailsScreen({Key? key, required this.placeId, required this.place})
      : super(key: key);

  @override
  State<DealDetailsScreen> createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<DealDetailsScreen> {
  bool isLoading = false;
  bool isFavorited = false;
  int rating = 0;
  int totalRatings = 0;

// Initialisez votre service de taux
  ClientService clientService = ClientService();

  @override
  void initState() {
    super.initState();
    fetchTotalRatings();
  }

  Future<void> fetchTotalRatings() async {
    try {
      List<Rate> rates = await clientService.getRates(widget.placeId);
      setState(() {
        totalRatings = rates.length;
      });
    } catch (e) {
      print('Failed to fetch total ratings: $e');
    }
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') ?? '';
  }

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? '';
  }

  void createRate(int rating) async {
    String userId = await getUserId();
    String userName = await getUserName();

    Rate rate = Rate(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      rate: rating.toDouble(),
      userId: userId, // Use the userId from SharedPreferences
      ratedId: widget.placeId,
      topCount: 10,
      review: 'Great place!',
      userName: userName, // Use the userName from SharedPreferences
    );

    try {
      await clientService.createRate(rate);
      setState(() {
        totalRatings++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rating submitted successfully!')),
      );
    } catch (e) {
      print('Error submitting rating: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit rating. Please try again.')),
      );
    }
  }

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
                  height: 1200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Replace static image with dynamic list of images
                      ...widget.place.placeImage.map((imageUrl) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Image.network(
                            imageUrl, // Use imageUrl from placeImage list
                            width: MediaQuery.of(context).size.width,
                            height: 350,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle tap on the text
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PartnerProfileScreen(),
                                ),
                              );
                            },
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
                                widget.place.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 2), // Add space between the two rows
                          Row(
                            children: [
                              Spacer(), // Pushes the button to the left
                              GestureDetector(
                                // Wrap the favorite image with GestureDetector
                                onTap: () {
                                  setState(() {
                                    isFavorited =
                                        !isFavorited; // Toggle the state
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    isFavorited
                                        ? 'assets/images/fav1.png' // Change the image path based on the state
                                        : 'assets/images/fav0.png',
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                            widget.place.location,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Spacer(), // Pushes the remaining items to the right
                          Row(
                            children: List.generate(
                              5,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    rating = index + 1; // Update rating
                                  });
                                  // Call createRate method here
                                  createRate(rating);
                                },
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
                            '$rating / 5', // Show current rating
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
                            '($totalRatings reviews)', // Add space between text and reviews
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 15),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:
                                    20), // Add spacing between the previous content and the description
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                                height:
                                    10), // Add spacing between the label and the description text
                            Text(
                              widget.place.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20), // Add horizontal margin
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Add your button onPressed logic here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddPlanningScreen()),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          MyColors.btnColor),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: Colors.white,
                                        width: 4,
                                      ), // Add white border
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal:
                                          20), // Adjust padding as needed
                                  child: Text(
                                    'Add To Planning',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              separatorBuilder: (context, index) {
                                // Add space between comments
                                return SizedBox(
                                    height: 5); // Adjust the height as needed
                              },
                              itemBuilder: (context, index) {
                                // Replace 'This is a sample comment.' with actual comment data
                                return CommentItemWidget.CommentItem();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    // Adjust the left margin as needed
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 25,
                              horizontal: 25), // Adjust padding as needed
                          hintText: "write your comment",
                          filled: true,
                          fillColor: MyColors.backbtn1,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.btnColor, // Adjust border color
                              width: 1, // Adjust border width
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors
                                  .btnBorderColor, // Adjust border color
                              width: 1, // Adjust border width
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          suffixIcon: Container(
                            margin: EdgeInsets.only(right: 7),
                            width: 60, // Adjust the size of the circular button
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors
                                  .backbtn1, // Set color as transparent to show the border
                              border: Border.all(
                                color: MyColors.btnColor, // Set border color
                                width: 1, // Adjust border width as needed
                              ),
                            ),
                            child: ClipOval(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    // Add your logic here for button press
                                  },
                                  child: Image.asset(
                                    'assets/images/send.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
