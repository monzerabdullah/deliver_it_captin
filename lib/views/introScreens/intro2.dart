import 'package:deliver_it_captin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'images/svgs/independant.svg',
            width: 299,
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            'خليك مستقل',
            style: TextStyle(
              color: kPrimaryText,
              fontSize: 32.0,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'مع وصلها ، إنت اللي مدير نفسك ، اختار الطرق اللي تناسبك والرحلات اللي تناسبك',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kSecondaryText,
                fontSize: 16.0,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
