import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../base.dart';
import '../../models/utls/constants.dart';

class LoginViewModel extends ChangeNotifier {
  String message = '';
  late Connector connect;
  final FirebaseAuth auth = FirebaseAuth.instance;
  void Loginwithfirebaseauth() async {
    try {
      print('object');
      connect.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: Pass,
      );
      connect.hideLoading();
      connect.showMessage('Successfully Logged');
      connect.navtohome();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'Password or email are Wrong';
      } else if (e.code == 'wrong-password') {
        message = 'Password or email are Wrong';
      }
    } catch (e) {
      message = 'Something went wrong ${e.toString()}';
    }
    if (message != '') {
      connect.hideLoading();
      connect.showMessage(message);
    }
  }
}
