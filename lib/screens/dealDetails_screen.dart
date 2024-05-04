import 'package:dealdiscover/screens/AddPlanning_screen.dart';
import 'package:dealdiscover/screens/bottomnavbar.dart';
import 'package:dealdiscover/screens/partnerProfile_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:dealdiscover/widgets/Comment.dart' as CommentWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealDetailsScreen extends StatefulWidget {
  const DealDetailsScreen({super.key});

  @override
  State<DealDetailsScreen> createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<DealDetailsScreen> {
  bool isLoading = false;
  bool isFavorited = false;
  int rating = 0;
  int totalRatings = 15;
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
              margin: EdgeInsets.only(right: 350),
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
                      Image.asset(
                        'assets/images/vitrine1.png', // Provide the path to your image asset
                        width: MediaQuery.of(context)
                            .size
                            .width, // Adjust width as needed
                        height: 350, // Adjust height as needed
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Handle tap on the text
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PartnerProfileScreen()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 20,
                              ),
                              child: Text(
                                'The secret coffee Shop',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            // Wrap the favorite image with GestureDetector
                            onTap: () {
                              setState(() {
                                isFavorited = !isFavorited; // Toggle the state
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
                            'Sousse',
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
                              'As our loyal patrons know, the true secret to The Secret lies in the warmth of our hospitality and the genuine connections forged over a shared love of exceptional coffee. So come join us, and discover the magic that awaits  at The Secret Coffee Shop',
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
                            SizedBox(
                                height:
                                    20), // Add spacing between the previous content and the description
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                                height:
                                    10), // Add spacing between the label and the description text
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec leo eget odio ultrices lacinia.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                                height:
                                    20), // Add spacing between the description and the button
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
                                return CommentWidget.Comment();
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
