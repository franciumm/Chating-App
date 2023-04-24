import 'package:chataapproutecourse/models/utls/constants.dart';
import 'package:chataapproutecourse/models/utls/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Provider/UserProv.dart';

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
  UserProvider.user = Usser.data()!;
  print('The Email:${UserProvider.user.Email}');
  print('The id:${UserProvider.user.id}');
}
