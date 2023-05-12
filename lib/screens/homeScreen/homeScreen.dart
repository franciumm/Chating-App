import 'package:chataapproutecourse/DataBase/DataBase.dart';
import 'package:chataapproutecourse/Provider/UserProv.dart';
import 'package:chataapproutecourse/shared/components/Room/RoomItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base.dart';

import '../../shared/components/Background/Background.dart';
import '../Addroom/add_room.dart';
import 'NavDrawer.dart';
import 'homeVm.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen>
    with SingleTickerProviderStateMixin
    implements Connector {
  var HomeProv;
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => UserProvider.user =
        ReadUser(FirebaseAuth.instance.currentUser?.uid, context));
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
    return DefaultTabController(
      length: 2,
      child: ChangeNotifierProvider(
        create: (BuildContext context) => HomeVM(),
        builder: (context, child) {
          HomeProv = Provider.of<HomeVM>(context);
          HomeProv.connect = this;

          return Stack(children: [
            const BackgroundContainer(),
            Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddRoomScreen()));
                },
                child: Icon(Icons.add),
              ),
              drawer: const NavDrawer(),
              backgroundColor: Colors.transparent,
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    const SliverAppBar(
                      centerTitle: true,
                      pinned: true,
                      floating: true,
                      bottom: TabBar(
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(
                            text: 'My Rooms',
                          ),
                          Tab(
                            text: 'Browse',
                          ),
                        ],
                      ),
                      title: Text(
                        'Chat App',
                        style: TextStyle(fontSize: 25),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ];
                },
                body: TabBarView(
                    dragStartBehavior: DragStartBehavior.down,
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          setState(() {});
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            FutureBuilder(
                              future:
                                  ChecckJoinedRoom(UserProvider.user?.id ?? ''),
                              builder: (c, snapshot) {
                                if (snapshot.hasData) {
                                  return Expanded(
                                    child: GridView.builder(
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (conetxt, index) {
                                        return RoomItem(snapshot.data![index]!);
                                      },
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 2,
                                        childAspectRatio: 9 / 10,
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            StreamBuilder(
                                stream: RoomsRead(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: Text('Something went wrong'),
                                    );
                                  }
                                  var snapRoomsList = snapshot.data?.docs
                                          .map((e) => e.data())
                                          .toList() ??
                                      [];

                                  return Expanded(
                                    child: GridView.builder(
                                      itemCount: snapRoomsList.length,
                                      itemBuilder: (conetxt, index) {
                                        return RoomItem(snapRoomsList[index]);
                                      },
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 2,
                                        childAspectRatio: 9 / 10,
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      )
                    ]),
              ),
            )
          ]);
        },
      ),
    );
  }

  @override
  void navtohome() {}

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
            backgroundColor: Theme.of(context).primaryColor,
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
        style: TextStyle(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      margin: const EdgeInsets.all(50),
      elevation: 30,
      action: SnackBarAction(
        textColor: Theme.of(context).primaryColor,
        label: 'OK',
        onPressed: () {},
      ),
      duration: const Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
