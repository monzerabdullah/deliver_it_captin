import 'package:deliver_it_captin/widgets/view_selector.dart';
import 'package:flutter/material.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 25.0,
        crossAxisSpacing: 25.0,
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        children: const [
          ViewSelector(
            label: 'الملف الشخصي',
            icon: Icons.account_circle_outlined,
          ),
          ViewSelector(
            label: 'الإعدادات',
            icon: Icons.settings_outlined,
          ),
          ViewSelector(
            label: 'الدعم',
            icon: Icons.headset_mic_outlined,
          ),
          ViewSelector(
            label: 'سجل الرحلات',
            icon: Icons.grading,
          ),
          ViewSelector(
            label: 'التقييمات',
            icon: Icons.star_border_outlined,
          ),
          ViewSelector(
            label: 'تسجيل خروج',
            icon: Icons.logout_outlined,
          ),
        ],
      ),
    );
  }
}
