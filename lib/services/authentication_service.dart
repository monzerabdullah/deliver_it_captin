import 'package:deliver_it_captin/locator.dart';
import 'package:deliver_it_captin/models/rider_model.dart';
import 'package:deliver_it_captin/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestore = locator<FirestoreService>();
  late Rider _rider;
  Rider get rider => _rider;
  Future loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await populateCurrentRider(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.toString();
    }
  }

  Future signUpWithEmail({
    required String email,
    required String password,
    required name,
    required phoneNumber,
    required idCardNumber,
    required plateNumber,
    required avatarImgUrl,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _rider = Rider(
        id: authResult.user!.uid,
        name: name,
        phoneNumber: phoneNumber,
        idCardNumber: idCardNumber,
        plateNumber: plateNumber,
        avatarImgUrl: avatarImgUrl,
      );
      await _firestore.createRider(_rider);
      return authResult.user != null;
    } catch (e) {
      // return e.toString();
      print(e.toString());
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> userIsLoggedIn() async {
    var result = _firebaseAuth.currentUser;
    populateCurrentRider(result);
    return result != null;
  }

  Future populateCurrentRider(User? user) async {
    if (user != null) {
      await _firestore.getRider(user.uid);
    }
  }

  Stream<User?> get user => _firebaseAuth.authStateChanges();
}
