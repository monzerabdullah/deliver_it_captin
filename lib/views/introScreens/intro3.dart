import 'package:deliver_it_captin/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({super.key});

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
            'images/svgs/income.svg',
            width: 299,
          ),
          const SizedBox(
            height: 80,
          ),
          const Text(
            'دخل زيادة',
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
              'مع وصلها ،  رسوم التوصيل كلها ليك ، وتقدر تزيد من دخلك ،بالإكراميات ، والحوافز اللي بنقدمها لمندوبينا',
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
