import 'package:chataapproutecourse/models/user_model.dart';
import 'package:chataapproutecourse/screens/homeScreen/homeVm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../Provider/UserProv.dart';
import '../models/category.dart';
import '../models/Message.dart';

import '../models/joinedUsers.dart';
import '../models/utls/constants.dart';

CollectionReference<UserModel> getUserCollection() {
  return FirebaseFirestore.instance
      .collection(UserModel.COLLECTION_NAME)
      .withConverter<UserModel>(
        fromFirestore: (snapshot, options) =>
            UserModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

Future<void> AddUserToData(UserModel? user) {
  return getUserCollection()
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .set(user!);
}

ReadUser(String? id, BuildContext context) {
  var Usser = getUserCollection().doc(id).get().then((value) {
    if (value.data() != null) {
      UserProvider.user = value.data()!;
      userindatabase = true;
    } else {
      userindatabase = false;
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, 'Login');
    }
  });
}

CollectionReference<Rooms> getRoomsCollections() {
  return FirebaseFirestore.instance
      .collection(Rooms.COLLECTION_NAME)
      .withConverter<Rooms>(
        fromFirestore: (snapshot, options) => Rooms.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
}

CollectionReference<Message> getMessagesCollection(String roomId) {
  return getRoomsCollections()
      .doc(roomId)
      .collection(Message.COLLECTION_NAME)
      .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson());
}

Future<void> addMessageToData(Message message) {
  var collection = getMessagesCollection(message.roomId);
  var docRef = collection.doc();
  message.id = docRef.id;
  return docRef.set(message);
}

Stream<QuerySnapshot<Message>> readMessage(String roomId) {
  return getMessagesCollection(roomId).orderBy("dateTime").snapshots();
}

Future<void> AddRoomToData(Rooms Room) {
  var collection = getRoomsCollections();
  var docRef = collection.doc();
  Room.id = docRef.id;
  return docRef.set(Room);
}

Stream<QuerySnapshot<Rooms>> RoomsRead() {
  var SnapRoom = getRoomsCollections().snapshots();

  return SnapRoom;
}

CollectionReference<JoinedUsers> getJoineduserCollection(String roomId) {
  return getRoomsCollections()
      .doc(roomId)
      .collection(JoinedUsers.COLLECTION_NAME)
      .withConverter<JoinedUsers>(
          fromFirestore: (snapshot, options) =>
              JoinedUsers.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson());
}

void addjoineduserToData(String UserId, String roomId) async {
  var collection = getJoineduserCollection(roomId);
  var docRef = collection.doc(UserId);
  var joined = JoinedUsers(UserId: UserId, RoomId: roomId);

  return await docRef.set(joined);
}

Future<List<Rooms?>> ChecckJoinedRoom(String userId) async {
  List<Rooms?> joinedrooms = [];

  var Roomss = await getRoomsCollections().get();
  for (int x = 0; x < Roomss.docs.length; x++) {
    var checkuser = await getJoineduserCollection(Roomss.docs[x].id).get();
    for (int x = 0; x < checkuser.docs.length; x++) {
      if (checkuser.docs[x].id == userId) {
        var Roomz = await getRoomsCollections()
            .doc(checkuser.docs[x].data().RoomId)
            .get();
        joinedrooms += [Roomz.data()];
      }
    }
    //if (checkuser.docs[x].data().UserId == userId) {
    // joinedrooms += [Roomss.docs[x].data()];
    // }
  }

  return joinedrooms;
}
