import 'package:chataapproutecourse/models/category.dart';
import 'package:flutter/cupertino.dart';

import '../../base.dart';

class HomeVM extends ChangeNotifier {
  late Connector connect;
  List<Rooms> rooms = [];
}
