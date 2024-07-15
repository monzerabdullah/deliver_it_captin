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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kPrimary.withOpacity(.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: double.infinity,
                      height: 150,
                    ),
                    Positioned(
                      bottom: -30,
                      left: 0,
                      right: 0,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height,
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        child: Card(
                          elevation: 4.0,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            tileColor: Colors.white,
                            trailing: const CircleAvatar(
                              radius: 20,
                              backgroundColor: kPrimary,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: kWhite,
                              ),
                            ),
                            title: const Text(
                              'منطقة التوصيل',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: kPrimaryText,
                              ),
                            ),
                            subtitle: const Text(
                              'السادس من أكتوبر ، الحي السادس',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: kSecondaryText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 45,
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
                          fontWeight: FontWeight.bold,
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
                  height: 20,
                ),
                const WorkTimer(),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
