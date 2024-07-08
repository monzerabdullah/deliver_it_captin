import 'package:deliver_it_captin/views/orders_view.dart';
import 'package:deliver_it_captin/views/reviews_view.dart';
import 'package:deliver_it_captin/views/support_view.dart';
import 'package:deliver_it_captin/widgets/view_selector.dart';
import 'package:flutter/material.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Text('المزيد'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 25.0,
        crossAxisSpacing: 25.0,
        childAspectRatio: 2 / 2.2,
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        children: [
          ViewSelector(
            label: 'الملف الشخصي',
            icon: Icons.account_circle_outlined,
            onTap: () {},
          ),
          ViewSelector(
            label: 'الإعدادات',
            icon: Icons.settings_outlined,
            onTap: () {},
          ),
          ViewSelector(
            label: 'الدعم',
            icon: Icons.headset_mic_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SupportView(),
                ),
              );
            },
          ),
          ViewSelector(
            label: 'سجل الرحلات',
            icon: Icons.grading,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      appBar: AppBar(
                        title: const Text('سجل الرحلات'),
                      ),
                      body: const OrdersList(),
                    ),
                  ),
                ),
              );
            },
          ),
          ViewSelector(
            label: 'التقييمات',
            icon: Icons.star_border_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReviewsView(),
                ),
              );
            },
          ),
          ViewSelector(
            label: 'تسجيل خروج',
            icon: Icons.logout_outlined,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
