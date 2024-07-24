import 'package:deliver_it_captin/constants.dart';
import 'package:deliver_it_captin/locator.dart';
import 'package:deliver_it_captin/models/rider_model.dart';
import 'package:deliver_it_captin/services/authentication_service.dart';
import 'package:deliver_it_captin/services/firestore_service.dart';
import 'package:deliver_it_captin/views/orders_view.dart';
import 'package:deliver_it_captin/views/reviews_view.dart';
import 'package:deliver_it_captin/views/support_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({
    super.key,
  });

  final AuthenticationService _auth = locator<AuthenticationService>();
  final FirestoreService _firestore = locator<FirestoreService>();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firestore.getRider(user!.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(
              color: kPrimary,
            );
          }
          Rider rider = snapshot.data;
          return Drawer(
            child: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(rider.avatarImgUrl),
                      radius: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      rider.name,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 22.0,
                        color: kPrimaryText,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 250,
                        child: Divider(
                          color: kPrimaryText,
                          height: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.account_circle_outlined,
                    color: kPrimaryText,
                    size: 35,
                  ),
                  title: Text(
                    'الملف الشخصي',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: kPrimaryText,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.settings_outlined,
                    color: kPrimaryText,
                    size: 35,
                  ),
                  title: Text(
                    'الإعدادات',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: kPrimaryText,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
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
                  child: const ListTile(
                    leading: Icon(
                      Icons.grading,
                      color: kPrimaryText,
                      size: 35,
                    ),
                    title: Text(
                      'سجل الطلبيات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: kPrimaryText,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReviewsView(),
                      ),
                    );
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.star_border_outlined,
                      color: kPrimaryText,
                      size: 35,
                    ),
                    title: Text(
                      'التقييمات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: kPrimaryText,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SupportView(),
                      ),
                    );
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.headset_mic_outlined,
                      color: kPrimaryText,
                      size: 35,
                    ),
                    title: Text(
                      'المساعدة والدعم',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: kPrimaryText,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          width: 360,
                          height: 360 / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'هل أنت متأكد من الخروج',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: kSecondaryText,
                                  fontSize: 22.0,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        _auth.signOut();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kPrimaryText,
                                        minimumSize: const Size(115, 40),
                                      ),
                                      child: const Text(
                                        'خروج',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: kWhite,
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kWhite,
                                        minimumSize: const Size(115, 40),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            width: 2,
                                            color: kPrimaryText,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: const Text(
                                        'إلغاء',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: kPrimaryText,
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: kPrimaryText,
                      size: 35,
                      textDirection: TextDirection.rtl,
                    ),
                    title: Text(
                      'تسجيل خروج',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: kPrimaryText,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
