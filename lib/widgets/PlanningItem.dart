import 'package:dealdiscover/screens/UserScreens/DetailPlanning_screen.dart';
import 'package:dealdiscover/screens/UserScreens/EditPlanning_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/material.dart';

class PlanningItem extends StatefulWidget {
  @override
  _PlanningItemState createState() => _PlanningItemState();
}

class _PlanningItemState extends State<PlanningItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: MyColors.btnColor,
          width: 1,
        ),
      ),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First row with time and menu icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: MyColors.btnColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      '08:00',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      ' - ',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '10:00',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    popupMenuTheme: PopupMenuThemeData(
                      color:
                          MyColors.border2, // Change this to your desired color
                    ),
                  ),
                  child: PopupMenuButton<int>(
                    icon: Icon(
                      Icons.more_vert,
                      color: MyColors.btnColor,
                    ),
                    onSelected: (int result) {
                      if (result == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPlanningScreen(),
                          ),
                        );
                      } else if (result == 2) {
                        // Handle delete action
                      } else if (result == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPlanningScreen(),
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text('Edit'),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Text('Delete'),
                      ),
                      PopupMenuItem<int>(
                        value: 3,
                        child: Text('Details'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            // Second row with title
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'The Secret Coffee Shop',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Third row with location icon and text
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Image.asset(
                  'assets/images/location.png', // Replace with your image path
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 8),
                Text(
                  'Sousse',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
