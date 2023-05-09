import 'package:chataapproutecourse/models/category.dart';
import 'package:chataapproutecourse/models/utls/constants.dart';
import 'package:chataapproutecourse/screens/Addroom/add_room_vm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../DataBase/DataBase.dart';
import '../../Provider/UserProv.dart';
import '../../base.dart';
import '../../shared/components/Background/Background.dart';
import '../../shared/style/colors.dart';
import '../homeScreen/homeScreen.dart';

class AddRoomScreen extends StatefulWidget {
  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen>
    with SingleTickerProviderStateMixin
    implements Connector {
  GlobalKey<FormState> FormKey = GlobalKey();

  var AddRoom;
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 0),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => addRoomVm(),
      builder: (context, child) {
        AddRoom = Provider.of<addRoomVm>(context);
        AddRoom.connect = this;
        return Stack(
          children: [
            const BackgroundContainer(),
            Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Room Add',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              body: Form(
                key: FormKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26, //New
                                blurRadius: 25.0,
                                offset: Offset(0, -5))
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(19.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text(
                                'Create New Room',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ),
                            SizedBox(
                              height: 1 /
                                  10 *
                                  (MediaQuery.of(context).size.height * 1 / 3),
                            ),
                            Image.asset(
                                'assets/images/group-1824146_1280@3x.png',
                                fit: BoxFit.fitHeight,
                                height: 100,
                                filterQuality: FilterQuality.high),
                            SizedBox(
                              height: 1 /
                                  10 *
                                  (MediaQuery.of(context).size.height * 1 / 3),
                            ),
                            TextFormField(
                              onChanged: (e) {
                                RoomName = e;
                              },
                              validator: (text) {
                                if (text!.trim() == '') {
                                  return 'Please Enter Name ';
                                }
                                return null;
                              },
                              controller: RoomNameController,
                              autofocus: true,
                              decoration: const InputDecoration(
                                  label: Text('Enter Room name')),
                            ),
                            SizedBox(
                              height: 1 /
                                  35 *
                                  (MediaQuery.of(context).size.height * 1 / 3),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              width: double.infinity,
                              child: DropdownButton(
                                isExpanded: true,
                                value: dropdownValue,
                                onChanged: (String? value) {
                                  AddRoom.changeCat(value);
                                },
                                items: Catlist.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset('assets/images/$value.png',
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.fitHeight,
                                            filterQuality: FilterQuality.high),
                                        Text(value),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 1 /
                                  35 *
                                  (MediaQuery.of(context).size.height * 1 / 3),
                            ),
                            TextFormField(
                              onChanged: (e) {
                                RoomDes = e;
                              },
                              validator: (text) {
                                if (text!.trim() == '') {
                                  return 'Please Enter Description';
                                }
                                return null;
                              },
                              controller: RoomDesController,
                              obscureText: false,
                              keyboardType: TextInputType.visiblePassword,
                              autofocus: true,
                              decoration: const InputDecoration(
                                  label: Text('Room Description')),
                            ),
                            SizedBox(
                              height: 1 /
                                  9 *
                                  (MediaQuery.of(context).size.height * 1 / 3),
                            ),
                            SizedBox(
                              height: 1 /
                                  9 *
                                  (MediaQuery.of(context).size.height * 1 / 3),
                            ),
                            InkWell(
                              onTap: () {
                                if (FormKey.currentState!.validate()) {
                                  AddRoom.RoomAddToFirestore(Rooms(
                                      ownerid: FirebaseAuth
                                              .instance.currentUser?.uid ??
                                          '',
                                      name: RoomName,
                                      desc: RoomDes,
                                      cat: dropdownValue));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: PRIMARY_COLOR,
                                    borderRadius: BorderRadius.circular(32)),
                                width: double.infinity,
                                height: 60,
                                child: const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      'Create Room',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1 /
                                  9 *
                                  (MediaQuery.of(context).size.height * 1 / 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: PRIMARY_COLOR,
            title: const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))));
  }

  @override
  void showMessage(String text) {
    final snackBar = SnackBar(
      animation: animation,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(
        text,
        style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      margin: EdgeInsets.all(50),
      elevation: 30,
      action: SnackBarAction(
        textColor: PRIMARY_COLOR,
        label: 'OK',
        onPressed: () {},
      ),
      duration: Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  navtohome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const homeScreen()),
        (route) => false);
  }
}
