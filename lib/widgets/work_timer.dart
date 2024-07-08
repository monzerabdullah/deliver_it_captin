import 'package:deliver_it_captin/constants.dart';
import 'package:flutter/material.dart';

class WorkTimer extends StatelessWidget {
  const WorkTimer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: kSecondaryText.withOpacity(.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '12',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 22.0,
                          color: kPrimaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ثانية',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16.0,
                          color: kSecondaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 32.0,
                      color: kPrimaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '32',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 22.0,
                          color: kPrimaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'دقيقة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16.0,
                          color: kSecondaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 32.0,
                      color: kPrimaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '8',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 22.0,
                          color: kPrimaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ساعات',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16.0,
                          color: kSecondaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(51),
                backgroundColor: kRed,
              ),
              child: const Text(
                'التوقف عن العمل',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
