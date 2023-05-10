import 'package:flutter/foundation.dart';
import '../../DataBase/DataBase.dart';
import '../../Provider/UserProv.dart';
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
      addjoineduserToData(UserProvider.user?.id ?? '', room.id);
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
