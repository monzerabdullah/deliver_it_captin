import 'package:deliver_it_captin/views/authenticate.dart';
import 'package:deliver_it_captin/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return const HomeView();
    }
  }
}


// 
        