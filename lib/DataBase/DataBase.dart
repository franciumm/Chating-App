import 'package:chataapproutecourse/models/user_model.dart';
import 'package:chataapproutecourse/screens/homeScreen/homeVm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Provider/UserProv.dart';
import '../models/category.dart';
import '../models/utls/constants.dart';

CollectionReference<UserModel> getUserCollection() {
  return FirebaseFirestore.instance
      .collection('Users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, options) =>
            UserModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

Future<void> AddUserToData(UserModel user) {
  return getUserCollection().doc(user.id).set(user);
}

ReadUser(String id) async {
  var Usser = await getUserCollection().doc(id).get();

  if (Usser.data() != null) {
    UserProvider.user = Usser.data()!;
    userindatabase = true;
  } else {
    userindatabase = false;
  }

  print('The Email:${UserProvider.user.Email}');
  print('The id:${UserProvider.user.id}');
}

CollectionReference<Rooms> getRoomsCollections() {
  return FirebaseFirestore.instance.collection('Rooms').withConverter<Rooms>(
        fromFirestore: (snapshot, options) => Rooms.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

Future<void> AddRoomToData(Rooms Room) {
  var collection = getRoomsCollections();
  var docRef = collection.doc();
  Room.id = docRef.id;
  return docRef.set(Room);
}

Stream<QuerySnapshot<Rooms>> RoomsRead() {
  var SnapRooms = getRoomsCollections().get();
  var FutureRoom = getRoomsCollections().snapshots();
  return FutureRoom;
}
