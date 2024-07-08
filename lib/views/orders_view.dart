import 'package:deliver_it_captin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('images/svgs/history.svg'),
            const SizedBox(
              height: 45,
            ),
            const Text(
              'لا توجد رحلات سابقة اليوم',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: kSecondaryText,
                fontSize: 22.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
