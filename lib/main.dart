import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliver_it_captin/constants.dart';
import 'package:deliver_it_captin/locator.dart';
import 'package:deliver_it_captin/services/authentication_service.dart';
import 'package:deliver_it_captin/views/home_view.dart';
import 'package:deliver_it_captin/views/more_view.dart';
import 'package:deliver_it_captin/views/orders_view.dart';
import 'package:deliver_it_captin/views/wrapper.dart';
import 'package:deliver_it_captin/widgets/nav_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
// ...
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class DeliverItCaptin extends StatefulWidget {
  const DeliverItCaptin({super.key});

  @override
  State<DeliverItCaptin> createState() => _DeliverItCaptinState();
}

class _DeliverItCaptinState extends State<DeliverItCaptin> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  int selectedIndex = 0;

  int activeOrders = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deliver It Captin',
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('orders')
                .where('rider_id', isEqualTo: user!.uid)
                .where('status', isNotEqualTo: 'pending')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                activeOrders = snapshot.data!.docs.length;
              }

              return Scaffold(
                // appBar: AppBar(
                //   title: const Text('الرئيسية'),
                // ),
                body: const [
                  HomeView(),
                  Orders(),
                  MoreView(),
                ][selectedIndex],
                drawer: NavDrawer(),
                bottomNavigationBar: NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  destinations: [
                    const NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'الرئيسية',
                    ),
                    NavigationDestination(
                      icon: Badge(
                        label: Text('$activeOrders'),
                        isLabelVisible: activeOrders < 0,
                        child: const Icon(Icons.grading),
                      ),
                      label: 'الطلبيات',
                    ),
                    const NavigationDestination(
                      icon: Icon(Icons.grid_on_outlined),
                      label: 'المزيد',
                    )
                  ],
                ),
              );
            }),
      ),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimary),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(cursorColor: kPrimary),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100],
          titleTextStyle: const TextStyle(
            color: kPrimary,
            fontFamily: 'Cairo',
            fontSize: 20.0,
          ),
          iconTheme: const IconThemeData(
            color: kPrimary,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: kPrimary,
          indicatorColor: kPrimaryText.withOpacity(.3),
          iconTheme: const WidgetStatePropertyAll(
            IconThemeData(
              color: kWhite,
            ),
          ),
          labelTextStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontFamily: 'Cairo',
              color: kWhite,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: AuthenticationService().user,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
