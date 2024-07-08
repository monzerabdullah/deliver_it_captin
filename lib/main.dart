import 'package:deliver_it_captin/constants.dart';
import 'package:deliver_it_captin/views/home_view.dart';
import 'package:deliver_it_captin/views/login_view.dart';
import 'package:deliver_it_captin/views/more_view.dart';
import 'package:deliver_it_captin/views/orders_view.dart';
import 'package:deliver_it_captin/widgets/nav_drawer.dart';
import 'package:deliver_it_captin/widgets/view_selector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deliver It Captin',
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // appBar: AppBar(
          //   title: const Text('الرئيسية'),
          // ),
          body: const [
            HomeView(),
            Orders(),
            MoreView(),
          ][selectedIndex],
          drawer: const NavDrawer(),
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'الرئيسية',
              ),
              NavigationDestination(
                icon: Icon(Icons.grading),
                label: 'الطلبيات',
              ),
              NavigationDestination(
                icon: Icon(Icons.grid_on_outlined),
                label: 'المزيد',
              )
            ],
          ),
        ),
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
            color: kPrimaryText,
            fontFamily: 'Cairo',
            fontSize: 20.0,
          ),
          iconTheme: const IconThemeData(
            color: kPrimaryText,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: kPrimary.withOpacity(.3),
          labelTextStyle: const MaterialStatePropertyAll(
            TextStyle(
              fontFamily: 'Cairo',
              color: kPrimaryText,
            ),
          ),
        ),
      ),
    );
  }
}
