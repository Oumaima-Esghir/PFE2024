import 'package:dealdiscover/screens/PartnerScreens/edit_deal_screen.dart';
import 'package:dealdiscover/screens/PromoDetails_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/material.dart';

class DealPartnerItem extends StatefulWidget {
  @override
  _DealPartnerItemState createState() => _DealPartnerItemState();
}

class _DealPartnerItemState extends State<DealPartnerItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
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
                    'The Secret Coffee Shop',
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
                              builder: (context) => EditDealScreen()),
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
                        )),
                      ),
                    ),
                    Container(
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
                      )),
                    ),
                    Container(
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
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
