import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/Authentication/AcadmicDetails.dart';
import 'package:helloworld/Authentication/firstpage.dart';
import 'package:helloworld/Components/constants.dart' as cst;
import 'package:helloworld/Components/textfield.dart';
import 'package:helloworld/Screens/homepage.dart';
import 'package:helloworld/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _autovalidate = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController forgetController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  bool showPassword = false;

  Future<bool> getvalueformSharpred() async {
    final pref = await SharedPreferences.getInstance();
    final value = pref.getInt('firstTime');
    if (value == null) {
      pref.setInt('firstTime', 1);
      return true;
    } else {
      return false;
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getvalueformSharpred().then((value) {
      if (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FirstPage(),
          ),
        );
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Container(
          height: mq.size.height,
          width: mq.size.width,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                height: mq.size.height * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(55 * cst.responsiveCofficient(context)),
                    topRight:
                        Radius.circular(55 * cst.responsiveCofficient(context)),
                  ),
                ),
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 25 * cst.responsiveCofficient(context)),
                            child: CircleAvatar(
                              backgroundColor: Colors.lightBlueAccent,
                              radius: 80 * cst.responsiveCofficient(context),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 20 * cst.responsiveCofficient(context),
                              ),
                              child: Text(
                                'Welcome Back!',
                                style: TextStyle(
                                    fontSize:
                                        28 * cst.responsiveCofficient(context)),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10 * cst.responsiveCofficient(context)),
                              child: Text(
                                'Login to your account',
                                style: TextStyle(
                                  fontSize:
                                      16 * cst.responsiveCofficient(context),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                          Form(
                            key: _formkey,
                            autovalidateMode: _autovalidate
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            child: Column(
                              children: [
                                CustomTextField(
                                  validator: (String value) {
                                    bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value);
                                    if (emailValid)
                                      return null;
                                    else
                                      return 'Not a valid Email';
                                  },
                                  secure: false,
                                  size: mq.size,
                                  controller: emailController,
                                  hinttext: 'Email',
                                ),
                                CustomTextField(
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return 'Field should be not empty';
                                    else
                                      return null;
                                  },
                                  secure: !showPassword,
                                  size: mq.size,
                                  controller: passwordController,
                                  hinttext: 'Password',
                                  icondata: Icons.lock_outline,
                                  trailingWidget: IconButton(
                                      icon: Icon(
                                        showPassword
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.remove_red_eye,
                                        color: Colors.blueAccent,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formkey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                signin(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(
                                          user: value.user,
                                        ),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                }).catchError((onError) {
                                  setState(() {
                                    loading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Invalid Credentials");
                                });
                              }
                              setState(() {
                                _autovalidate = true;
                              });
                            },
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 15 * cst.responsiveCofficient(context),
                                ),
                                child: Container(
                                  height:
                                      50 * cst.responsiveCofficient(context),
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(
                                        25 * cst.responsiveCofficient(context)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18 *
                                            cst.responsiveCofficient(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 12 * cst.responsiveCofficient(context)),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    child: Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        height: 200 *
                                            cst.responsiveCofficient(context),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Please Enter Your Email Id',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            CustomTextField(
                                              validator: (String value) {
                                                bool emailValid = RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(value);
                                                if (emailValid)
                                                  return null;
                                                else
                                                  return 'Not a valid Email';
                                              },
                                              secure: false,
                                              size: mq.size,
                                              controller: forgetController,
                                              hinttext: 'Email',
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                bool emailValid = RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(
                                                        forgetController.text);
                                                if (emailValid) {
                                                  passReset(
                                                      email: forgetController
                                                          .text
                                                          .trim());
                                                  Navigator.pop(context);
                                                  Fluttertoast.showToast(
                                                      msg: "Check your email");
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: "Invalid Email");
                                                }
                                              },
                                              child: Text(
                                                'Send Link',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color: Colors.blueAccent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize:
                                        18 * cst.responsiveCofficient(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10 * cst.responsiveCofficient(context)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 0.8,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        10 * cst.responsiveCofficient(context),
                                  ),
                                  child: Text(
                                    'New User',
                                    style: TextStyle(
                                        fontSize: 16 *
                                            cst.responsiveCofficient(context)),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.8,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10 * cst.responsiveCofficient(context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account ?",
                                  style: TextStyle(
                                    fontSize:
                                        16 * cst.responsiveCofficient(context),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AcadmicDetails(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    ' Sign up here',
                                    style: TextStyle(
                                        fontSize: 16 *
                                            cst.responsiveCofficient(context),
                                        color: Colors.blueAccent),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
