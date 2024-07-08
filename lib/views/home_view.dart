import 'package:deliver_it_captin/constants.dart';
import 'package:deliver_it_captin/widgets/day_data.dart';
import 'package:deliver_it_captin/widgets/work_timer.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: kWhite,
        //   onPressed: () {},
        //   child: const Icon(
        //     Icons.headset_mic_outlined,
        //     color: kPrimaryText,
        //   ),
        // ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          title: const Text('الرئيسية'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'اليوم',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18.0,
                      color: kPrimaryText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'السجل',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18.0,
                        color: kPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              const Text(
                '22 يونيو ، 2024 ',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 22.0,
                  color: kPrimaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const DayData(),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'الحالة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18.0,
                      color: kPrimaryText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'في إنتظار الطلبيات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18.0,
                        color: Colors.amber,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              const WorkTimer(),
            ],
          ),
        ),
      ),
    );
  }
}
