import 'package:chataapproutecourse/shared/components/Background/Background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base.dart';
import '../../models/utls/constants.dart';
import '../../shared/style/colors.dart';
import '../create_account/create_account.dart';
import '../homeScreen/homeScreen.dart';
import 'loginVM.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin
    implements Connector {
  GlobalKey<FormState> FormKey = GlobalKey();
  late Animation<double> animation;
  late AnimationController controller;
  var LoginAccount;

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
      create: (BuildContext context) => LoginViewModel(),
      builder: (context, child) {
        LoginAccount = Provider.of<LoginViewModel>(context);
        LoginAccount.connect = this;
        return Stack(
          children: [
            const BackgroundContainer(),
            Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Center(
                    child: Text(
                  'Login',
                  style: TextStyle(fontSize: 25),
                )),
              ),
              body: Form(
                key: FormKey,
                autovalidateMode: AutovalidateMode.always,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:
                            (MediaQuery.of(context).size.height * 1 / 4 - 56),
                      ),
                      Text(
                        'Welcome back!',
                        style: TextStyle(
                            color: ItemsClr,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1 /
                            10 *
                            (MediaQuery.of(context).size.height * 1 / 3),
                      ),
                      TextFormField(
                        controller: EmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {
                          if (text!.trim() == '') {
                            return 'Please Enter E-mail ';
                          }

                          final emailvalide = RegExp(pattern).hasMatch(text);
                          if (!emailvalide) {
                            return "Please Enter vaild E-mail";
                          }

                          return null;
                        },
                        autofocus: true,
                        decoration: const InputDecoration(
                            label: Text('E-mail Address')),
                      ),
                      SizedBox(
                        height: 1 /
                            35 *
                            (MediaQuery.of(context).size.height * 1 / 3),
                      ),
                      TextFormField(
                        controller: PassController,
                        obscureText: false,
                        keyboardType: TextInputType.visiblePassword,
                        autofocus: true,
                        decoration:
                            const InputDecoration(label: Text('Password')),
                      ),
                      SizedBox(
                        height: 1 /
                            9 *
                            (MediaQuery.of(context).size.height * 1 / 3),
                      ),
                      InkWell(
                          onTap: () {}, child: const Text('Forgot Password?')),
                      SizedBox(
                        height: 1 /
                            9 *
                            (MediaQuery.of(context).size.height * 1 / 3),
                      ),
                      InkWell(
                        onTap: () {
                          if (FormKey.currentState!.validate()) {
                            LoginAccount.Loginwithfirebaseauth();
                          }
                          ;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(12)),
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Icon(
                                  Icons.forward,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1 /
                            9 *
                            (MediaQuery.of(context).size.height * 1 / 3),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CreateAccountScreen()));
                          },
                          child: Text(
                            'Create My Account',
                            style: TextStyle(fontSize: 15, color: GREY_COLOR),
                          )),
                    ],
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
            title: Center(
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
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (ctx) => homeScreen()), (route) => false);
  }
}
