import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../DataBase/DataBase.dart';
import '../../base.dart';
import '../../models/utls/constants.dart';
import '../Login/loginVM.dart';

class CreateAccountViewModel extends ChangeNotifier {
  late Connector connect;
  void CreateAccountWithFireAuthandStorage() async {
    if (FormKey.currentState!.validate()) {
      try {
        connect.showLoading();
        final credential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: Pass,
        );

        var uid = auth.currentUser?.uid;
        user.id = uid ?? '';
        UploadImage();

        AddUserToData(user).then((value) => {
              connect.hideLoading(),
              connect.showMessage('Successfully Created'),
              connect.navtohome(),
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == weakpassword) {
          connect.hideLoading();
          connect.showMessage('The Password is weak');
        } else if (e.code == EmailInUse) {
          connect.hideLoading();
          connect.showMessage('The account already exists for that email.');
        }
      } catch (e) {
        connect.hideLoading();
        connect.showMessage(e.toString());
      }
    }
  }

  void UploadImage() async {
    try {
      if (image != null) {
        Reference ref = FirebaseStorage.instance.ref().child('${user.id}.jpg');
        await ref.putFile(File(image!.path));
        ref.getDownloadURL().then((value) => {
              user.photo = value,
            });
      }
    } catch (e) {
      connect.showMessage(e.toString());
    }
    notifyListeners();
  }

  Future getPhoto() async {
    try {
      final foto1 = await ImagePicker().pickImage(source: ImageSource.camera);
      if (foto1 == null) return;

      final image1Temporary = File(foto1.path);

      image = image1Temporary;
    } on PlatformException catch (e) {
      connect.showMessage('Failed to pick an image : $e');
    }
    notifyListeners();
  }

  Future getImage() async {
    try {
      final imagee = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagee == null) return;

      final imageTemporary = File(imagee.path);
      image = imageTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      connect.showMessage('Failed to pick an image : $e');
    }

    print('done');
  }

  static selectImage(getPhoto, getImage, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("Please select the media to upload"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    getImage();
                  },
                  label: const Text('Gallery'),
                  icon: const Icon(Icons.image),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    getPhoto();
                  },
                  label: const Text('Camera'),
                  icon: const Icon(Icons.camera_alt_outlined),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
