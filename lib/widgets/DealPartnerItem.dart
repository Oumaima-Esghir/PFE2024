import 'package:dealdiscover/client/client_service.dart';
import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/screens/PartnerScreens/dealDetailsforpartner_screen.dart';
import 'package:dealdiscover/screens/PartnerScreens/edit_deal_screen.dart';
import 'package:dealdiscover/screens/dealDetails_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DealPartnerItem extends StatefulWidget {
  final Pub pub;

  const DealPartnerItem({super.key, required this.pub});

  @override
  _DealPartnerItemState createState() => _DealPartnerItemState();
}

class _DealPartnerItemState extends State<DealPartnerItem> {
  ClientService clientService = ClientService();

  @override
  void initState() {
    super.initState();
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  void _deletePub(id) async {
    try {
      print("id" + id);
      final url =
          Uri.parse('http://192.168.1.7:3000/pubs/delete/${widget.pub.id}');
      print("iddd:" + widget.pub.toString());
      final token = await getToken();

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deal deleted successfully'),
        ),
      );
      // Optionally, notify parent widget or handle state update here
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete deal'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: MyColors.btnBorderColor,
          width: 2,
        ),
      ),
      child: Container(
        color: Colors.transparent,
        height: 75,
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.pub.title ?? 'No Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditDealScreen(pub: widget.pub),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/edit.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _deletePub(widget.pub.id),
                  child: Container(
                    margin: EdgeInsets.only(left: 6),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColors.red,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/delete.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PartnerDealDetailsScreen(
                          pub: widget.pub,
                          pubId: widget.pub.id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 6),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColors.btnBorderColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/details.png',
                        width: 35,
                        height: 35,
                      ),
                    ),
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
