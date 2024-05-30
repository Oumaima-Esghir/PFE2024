import 'package:dealdiscover/model/place.dart';
import 'package:dealdiscover/screens/dealDetails_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/material.dart';

class DealCard extends StatelessWidget {
  final Place place;

 const DealCard({Key? key, required this.place}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              color: MyColors.btnBorderColor,
              width: 2,
            ),
          ),
          child: Container(
            color: Colors.white,
            width: 250,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 10, // Add space between the top and the main image
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: MyColors.btnBorderColor,
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          place.placeImage.isNotEmpty
                              ? place.placeImage[0] // Use the first image in the list
                         : 'assets/images/placeholder.png',
                          width: 220,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        // Wrap the favorite image with GestureDetector
                        onTap: () {
                          // Handle favorite toggle
                        },
                        child: Image.asset(
                          'assets/images/fav0.png',
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          border:
                              Border.all(color: Colors.black), // Black border
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                              place.rate?.toString() ?? '', // Handle null rate
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
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    place.name, // Display place name
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DealDetailsScreen(placeId: place.id,place: place),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: MyColors.btnBorderColor, width: 2),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(Size(180, 45)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'See Details',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 15),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -27, // Adjust the top value to move the pin image further up
          left: 0,
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
