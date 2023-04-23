import 'package:chataapproutecourse/DataBase/DataBase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../base.dart';
import '../../models/utls/constants.dart';

class LoginViewModel extends ChangeNotifier {
  String message = '';
  late Connector connect;

  void Loginwithfirebaseauth() async {
    try {
      connect.showLoading();
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: Pass,
      );
      user.id = auth.currentUser?.uid ?? '';
      connect.hideLoading();
      connect.showMessage('Successfully Logged');
      connect.navtohome();
      user = (await ReadUser(user.id))!;
      return;
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
