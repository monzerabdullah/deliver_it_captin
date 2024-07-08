import 'package:deliver_it_captin/constants.dart';
import 'package:deliver_it_captin/views/login_view.dart';
import 'package:deliver_it_captin/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deliver It Captin',
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('الرئيسية'),
          ),
          body: const LoginView(),
          drawer: const NavDrawer(),
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
      ),
    );
  }
}
