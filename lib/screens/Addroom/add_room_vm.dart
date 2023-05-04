import 'package:flutter/foundation.dart';
import '../../DataBase/DataBase.dart';
import '../../base.dart';
import '../../models/category.dart';
import '../../models/utls/constants.dart';

class addRoomVm extends ChangeNotifier {
  late Connector connect;

  changeCat(String value) {
    dropdownValue = value;
    notifyListeners();
  }

  RoomAddToFirestore(Rooms room) {
    connect.showLoading();
    AddRoomToData(room).then((value) {
      connect.hideLoading();
      connect.hideLoading();

      RoomDes = '';
      RoomName = '';
      RoomDesController.clear();
      RoomNameController.clear();
      connect.showMessage('Room Created');
    }).catchError((err) {
      connect.hideLoading();
      connect.showMessage(err);
    });
  }
}
