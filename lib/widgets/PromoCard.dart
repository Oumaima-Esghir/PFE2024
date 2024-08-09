import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/screens/dealDetails_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/material.dart';

class PromoCard extends StatefulWidget {
  final Pub pub;

  const PromoCard({super.key, required this.pub});
  @override
  _PromoCardCardState createState() => _PromoCardCardState();
}

class _PromoCardCardState extends State<PromoCard> {
  final String rating = '4.5';
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              color: MyColors.btnBorderColor,
              width: 2,
            ),
          ),
          child: Container(
            color: Colors.white,
            height: 220,
            padding: EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.pub.pubImage == null ||
                            widget.pub.pubImage!.isNotEmpty
                        ? widget.pub.pubImage!
                        : 'assets/images/vitrine1.png',
                    width: 160,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  widget.pub.rating?.toString() ?? '',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            // Wrap the favorite image with GestureDetector
                            onTap: () {
                              setState(() {
                                isFavorited = !isFavorited; // Toggle the state
                              });
                            },
                            child: Image.asset(
                              isFavorited
                                  ? 'assets/images/fav1.png' // Change the image path based on the state
                                  : 'assets/images/fav0.png',
                              width: 35,
                              height: 35,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35),
                      Center(
                        child: Text(
                          widget.pub.title ?? 'No Title',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DealDetailsScreen(
                                pubId: widget.pub.id,
                                pub: widget.pub,
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: MyColors.btnBorderColor,
                                width: 2,
                              ),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(200, 45),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'See Details',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward, color: Colors.black),
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
        Positioned(
          top: -27, // Adjust the top value to move the pin image further up
          left: 25,
          right: 0,
          child: Container(
            height: 80, // Adjust the height of the container
            child: Image.asset(
              'assets/images/pin.png',
              width: 30,
              height: 30,
            ),
          ),
        ),
      ],
    );
  }
}
