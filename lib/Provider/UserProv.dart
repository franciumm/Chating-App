import 'package:chataapproutecourse/models/utls/constants.dart';
import 'package:chataapproutecourse/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static UserModel user = UserModel(id: '', name: Name, Email: email);
}
