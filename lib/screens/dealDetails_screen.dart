import 'package:dealdiscover/client/client_service.dart';
import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/model/rates.dart';
import 'package:dealdiscover/model/user.dart';
import 'package:dealdiscover/screens/UserScreens/AddPlanning_screen.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/screens/UserScreens/partner_profile_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:dealdiscover/widgets/CommentItem.dart' as CommentItemWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DealDetailsScreen extends StatefulWidget {
  final String pubId;
  final Pub pub;

  DealDetailsScreen({Key? key, required this.pubId, required this.pub})
      : super(key: key);

  @override
  State<DealDetailsScreen> createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<DealDetailsScreen> {
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
    // fetchTotalRatings();
    // checkIfUserRated();
    //Get Favorite places then check if current postId exists in favourite
    //if place exists isFavoited = true else false
    // _loadFavoritePlaces();
    clientService = ClientService();
  }

  /* Future<void> fetchTotalRatings() async {
    try {
      final rates = await clientService.getRates(widget.placeId);
      setState(() {
        totalRatings = rates.length;
      });
    } catch (e) {
      print('Failed to fetch total ratings: $e');
    }
  }
  Future<void> checkIfUserRated() async {
    String userId = await getUserId();
    try {
      final rates = await clientService.getRates(widget.placeId);
      setState(() {
        hasUserRated = rates.any((rate) => rate.user_id == userId);
      });
    } catch (e) {
      print('Failed to fetch rates: $e');
    }
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') ?? '';
  }

  void createRate(int rating) async {
    if (hasUserRated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have already submitted a review.')),
      );
      return;
    }

    String userId = await getUserId();

    Rate rate = Rate(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      rate: rating,
      user_id: userId,
      rated_id: widget.place.id,
      review: 'Great place!',
      rated_name: widget.place.name,
    );

    try {
      await clientService.createRate(rate, widget.place.id);
      setState(() {
        totalRatings++;
        hasUserRated = true;
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

  void _loadFavoritePlaces() async {
    try {
      final favouritePlaces = await clientService.getFavorites();
      setState(() {
        isFavorited = favouritePlaces.contains(widget.place.id);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading favorite places: $e')),
      );
    }
  }

  void _toggleFavorite() async {
    setState(() {
      isFavorited = !isFavorited; // Optimistically update the UI
    });
    if (isFavorited) {
      try {
        final response = await clientService.addFavourite(widget.place.id);

        if (response.statusCode != 200) {
          // If the server fails, revert the UI change
          setState(() {
            isFavorited = !isFavorited;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to update favorite status: ${response.body}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Favorite status updated successfully')),
          );
        }
      } catch (e) {
        setState(() {
          isFavorited = !isFavorited;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating favorite status: $e')),
        );
      }
    } else {
      //remove function
      try {
        final response = await clientService.removeFavorite(widget.place.id);

        if (response.statusCode != 200) {
          // If the server fails, revert the UI change
          setState(() {
            isFavorited = !isFavorited;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to update favorite status: ${response.body}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Favorite removed')),
          );
        }
      } catch (e) {
        setState(() {
          isFavorited = !isFavorited;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating favorite status: $e')),
        );
      }
    }
  }*/

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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.network(
                          widget.pub.pubImage!.isNotEmpty
                              ? widget.pub.pubImage!
                              : 'assets/images/vitrine1.png', // Use the single image or a default image
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
                          Row(
                            children: [
                              Spacer(), // Pushes the button to the left
                              GestureDetector(
                                // onTap: _toggleFavorite,
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
                            widget.pub.address ?? 'No Address',
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
