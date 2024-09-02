import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/screens/dealDetails_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:dealdiscover/client/client_service.dart';

class FavoriteCard extends StatefulWidget {
  final Pub pub;

  const FavoriteCard({super.key, required this.pub});

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  bool isFavorited = false;
  bool isLoading = false;

  ClientService clientService = ClientService();

  @override
  void initState() {
    super.initState();
    //_loadFavoriteStatus();
  }

  /*Future<void> _loadFavoriteStatus() async {
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
  }*/

  /*void _toggleFavorite() async {
    setState(() {
      isFavorited = !isFavorited; // Optimistically update the UI
    });
    if (isFavorited) {
      try {
        final response = await clientService.addFavourite(widget.place.id);
        if (response.statusCode != 200) {
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
        final response = await clientService.removeFavorite(widget.place.id);
        if (response.statusCode != 200) {
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
                        child: Image(
                          image: widget.pub.pubImage != null
                              ? NetworkImage(
                                  'http://192.168.1.7:3000/images/${widget.pub.pubImage}')
                              : AssetImage('assets/images/vitrine1.png')
                                  as ImageProvider,
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
                        // onTap: _toggleFavorite, // Handle favorite toggle
                        child: Image.asset(
                          'assets/images/fav1.png', // Full heart image
                          // Empty heart image
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
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    widget.pub.title ?? 'No Title',
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
                          builder: (context) => DealDetailsScreen(
                              pubId: widget.pub.id, pub: widget.pub),
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
