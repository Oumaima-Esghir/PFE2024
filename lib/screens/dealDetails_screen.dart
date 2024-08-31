import 'dart:convert';

import 'package:dealdiscover/client/client_service.dart';
import 'package:dealdiscover/model/comment.dart';
import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/model/rates.dart';
import 'package:dealdiscover/screens/UserScreens/AddPlanning_screen.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/screens/UserScreens/partner_profile_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:dealdiscover/widgets/CommentItem.dart' as CommentItemWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DealDetailsScreen extends StatefulWidget {
  final String? pubId;
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
  bool hasUserRated = false;
  late ClientService clientService; // Initialize your service
  late List<Comment> comments = [];
  late TextEditingController _commentController;

  @override
  @override
  void initState() {
    super.initState();
    clientService = ClientService(); // Initialize your service here
    _commentController = TextEditingController();
    print(widget.pub);
    _loadFavoritePlaces();
    rating = 0;
    checkIfUserRated();
    getComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> fetchTotalRatings() async {
    try {
      // final rates = await clientService.getRates(widget.pub.id!);
      // setState(() {
      //   totalRatings = rates.length;
      // });
    } catch (e) {
      print('Failed to fetch total ratings: $e');
    }
  }

  Future<void> checkIfUserRated() async {
    String userId = await getUserId();
    try {
      final rates = await clientService.getRates(widget.pub.id!);
      setState(() {
        rating = rates;
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

    // Rate rate = Rate(
    //   id: DateTime.now().millisecondsSinceEpoch.toString(),
    //   rate: rating,
    //   user_id: userId,
    //   rated_id: widget.pub.id!,
    //   review: 'Great place!',
    //   rated_name: widget.pub.title ?? 'No Title',
    // );

    try {
      await clientService.createRate(rating, widget.pub.id!);
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

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  void _addComment() async {
    final commentText = _commentController.text.trim();
    if (commentText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a comment')),
      );
      return;
    }

    try {
      final url = Uri.parse('http://10.0.2.2:3000/comments/${widget.pub.id}');
      final token = await getToken();

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'text': commentText,
        }),
      );

      if (response.statusCode == 200) {
        _commentController.clear(); // Clear the input field
        await getComments(); // Refresh the comment list
        setState(() {}); // Rebuild the UI with new comments
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Comment added successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add comment')),
        );
      }
    } catch (e) {
      print('Error adding comment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding comment: $e')),
      );
    }
  }

  void _loadFavoritePlaces() async {
    print("Loading favorite places...");
    try {
      final favouritePlaces = await clientService.getFavorites();

      setState(() {
        isFavorited = favouritePlaces.contains(widget.pub.id);
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
        final response = await clientService.addFavourite(widget.pub.id!);

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
      try {
        final response = await clientService.removeFavorite(widget.pub.id!);

        if (response.statusCode != 200) {
          setState(() {
            isFavorited = !isFavorited;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to remove favorite: ${response.body}')),
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
          SnackBar(content: Text('Error removing favorite status: $e')),
        );
      }
    }
  }

  Future<List<Comment>> getComments() async {
    print('**********');
    final url = Uri.parse(
        'http://10.0.2.2:3000/comments/${widget.pub.id}'); // Replace with your actual endpoint

    final response = await http.get(url);
    print('comments');
    print(response.body);
    if (response.statusCode == 200) {
      print("yes");
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Extract the list of comments from the "data" field
      final List<dynamic> data = jsonResponse['data'];

      // Map each item in the list to a Comment object
      comments = data
          .map((comment) => Comment.fromMap(comment as Map<String, dynamic>))
          .toList();

      print('comments');
      print(comments);

      return comments;
    } else {
      throw Exception('Failed to load pubs');
    }
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
                  height: 1000,
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
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PartnerProfileScreen(pub: widget.pub),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              elevation: MaterialStateProperty.all<double>(1),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                      color: MyColors.btnBorderColor),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
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
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Spacer(),
                              GestureDetector(
                                onTap: _toggleFavorite,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.asset(
                                    isFavorited
                                        ? 'assets/images/fav1.png'
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
                      SizedBox(height: 5),
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
                                onTap: hasUserRated
                                    ? null
                                    : () {
                                        setState(() {
                                          rating = index + 1;
                                        });
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
                            '$rating / 5',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 5),
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddPlanningScreen(
                                            id: widget.pub.id)),
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
                                          color: Colors.white, width: 4),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
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
                              itemCount: comments
                                  .length, // <- Correctly set the item count
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 5);
                              },
                              itemBuilder: (context, index) {
                                return CommentItemWidget.CommentItem(
                                    comments: comments[index]);
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
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 25, horizontal: 25),
                          hintText: "Write your comment",
                          filled: true,
                          fillColor: MyColors.backbtn1,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: MyColors.btnColor, width: 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.btnBorderColor, width: 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          suffixIcon: Container(
                            margin: EdgeInsets.only(right: 7),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.backbtn1,
                              border: Border.all(
                                  color: MyColors.btnColor, width: 1),
                            ),
                            child: ClipOval(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    _addComment();
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
