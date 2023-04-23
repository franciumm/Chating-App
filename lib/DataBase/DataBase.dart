import 'package:chataapproutecourse/models/utls/constants.dart';
import 'package:chataapproutecourse/models/utls/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

Future<UserModel?> ReadUser(String id) async {
  var Usser = await getUserCollection().doc(id).get();
  user = Usser.data()!;
  return Usser.data();
}
