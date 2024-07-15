import 'package:deliver_it_captin/constants.dart';
import 'package:flutter/material.dart';

class DayData extends StatelessWidget {
  const DayData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'المسافة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.0,
                    color: kSecondaryText,
                  ),
                ),
                Text(
                  '12.4km',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryText,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'الطلبات',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.0,
                    color: kSecondaryText,
                  ),
                ),
                Text(
                  '2',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryText,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'الدخل',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.0,
                    color: kSecondaryText,
                  ),
                ),
                Text(
                  '\$20',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryText,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
