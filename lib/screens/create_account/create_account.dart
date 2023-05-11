import 'package:chataapproutecourse/Provider/UserProv.dart';
import 'package:chataapproutecourse/screens/create_account/Createaccountveiwmodel.dart';
import 'package:chataapproutecourse/screens/homeScreen/homeScreen.dart';
import 'package:chataapproutecourse/shared/components/Background/Background.dart';
import 'package:chataapproutecourse/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base.dart';
import '../../models/utls/constants.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with SingleTickerProviderStateMixin
    implements Connector {
  bool passvision = true;
  var passIcon2 = const Icon(Icons.remove_red_eye);
  late Animation<double> animation;
  late AnimationController controller;
  var Createaccount;
  GlobalKey<FormState> formKey = GlobalKey();

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
      create: (context) => CreateAccountViewModel(),
      builder: (context, child) {
        Createaccount = Provider.of<CreateAccountViewModel>(context);
        Createaccount.connect = this;
        return Stack(children: [
          const BackgroundContainer(),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text('Create Account'),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height * 1 / 100),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 1 /
                              15 *
                              (MediaQuery.of(context).size.height * 1 / 3),
                        ),
                        Stack(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                CreateAccountViewModel.selectImage(
                                    Createaccount.getPhoto,
                                    Createaccount.getImage,
                                    context);
                                setState(() {});
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: PRIMARY_COLOR,
                                  border: Border.all(
                                      color: PRIMARY_COLOR, width: 1),
                                  shape: BoxShape.circle,
                                ),
                                child: image != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(75),
                                        child: Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : UserProvider.user?.photo != null
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                UserProvider.user!.photo
                                                    .toString()),
                                          )
                                        : const Icon(
                                            Icons.perm_identity,
                                            size: 90,
                                            color: Colors.black87,
                                          ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                left: 65,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: PRIMARY_COLOR,
                                  child: InkWell(
                                    onTap: () {
                                      CreateAccountViewModel.selectImage(
                                          Createaccount.getPhoto,
                                          Createaccount.getImage,
                                          context);
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.camera_alt_rounded,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 1 /
                              10 *
                              (MediaQuery.of(context).size.height * 1 / 3),
                        ),
                        TextFormField(
                          onChanged: (e) {
                            Name = e;
                          },
                          controller: NameController,
                          keyboardType: TextInputType.name,
                          validator: (text) {
                            if (text!.trim() == '') {
                              return 'Please Enter UserName ';
                            }
                            return null;
                          },
                          autofocus: true,
                          decoration:
                              const InputDecoration(label: Text('Username')),
                        ),
                        SizedBox(
                          height: 1 /
                              50 *
                              (MediaQuery.of(context).size.height * 1 / 3),
                        ),
                        TextFormField(
                          onChanged: (e) {
                            email = e;
                          },
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
                          onChanged: (e) {
                            Pass = e;
                          },
                          controller: PassController,
                          validator: (text) {
                            if (text!.trim() == '') {
                              return 'Please Enter Password ';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          autofocus: true,
                          obscureText: passvision,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passvision = !passvision;
                                    if (passvision == true) {
                                      passIcon2 =
                                          const Icon(Icons.remove_red_eye);
                                    } else if (passvision == false) {
                                      passIcon2 = const Icon(
                                          Icons.remove_red_eye_outlined);
                                    }
                                  });
                                },
                                icon: passIcon2,
                                splashColor: Colors.grey[200],
                                splashRadius: 20,
                                highlightColor: Colors.black87,
                              ),
                              label: Text('Password')),
                        ),
                        SizedBox(
                          height: 1 /
                              35 *
                              (MediaQuery.of(context).size.height * 1 / 3),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height * 1 / 7),
                    ),
                    InkWell(
                      onTap: () => {
                        if (formKey.currentState!.validate())
                          {
                            CreatAccountFun(),
                          }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: GREY_COLOR,
                                blurRadius: 8,
                                offset: const Offset(0, 5))
                          ]),
                          child: Container(
                            height: 50,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    'Create Account',
                                    style: TextStyle(color: GREY_COLOR),
                                  ),
                                ),
                                Icon(
                                  Icons.forward,
                                  color: GREY_COLOR,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]);
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

  CreatAccountFun() {
    Createaccount.CreateAccountWithFireAuthandStorage();
  }

  @override
  navtohome() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (ctx) => homeScreen()), (route) => false);
  }
}
