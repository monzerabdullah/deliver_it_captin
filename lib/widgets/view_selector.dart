import 'package:flutter/material.dart';

import 'package:deliver_it_captin/constants.dart';

class ViewSelector extends StatelessWidget {
  ViewSelector({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
