import 'package:flutter/material.dart';

import 'package:deliver_it_captin/constants.dart';

class ViewSelector extends StatelessWidget {
  const ViewSelector({
    super.key,
    required this.label,
    required this.icon,
  });
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 70,
              color: kPrimaryText,
            ),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 22.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
