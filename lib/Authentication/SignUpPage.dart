import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/services.dart';

import '../Components/constants.dart' as ctn;
import '../Components/textfield.dart';

class RegisterPage extends StatefulWidget {
  final branch;
  final semester;
  final institute;
  final enrollment;

  const RegisterPage(
      {Key key, this.branch, this.semester, this.institute, this.enrollment})
      : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _autovalidate = false;

  bool loading = false;
  bool showPassword = false;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          height: mq.size.height - mq.padding.top,
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formkey,
                  autovalidateMode: _autovalidate
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Personal Details',
                          style: TextStyle(
                              fontSize: 35 * ctn.responsiveCofficient(context),
                              color: Colors.blueAccent),
                        ),
                      ),
                      SizedBox(
                        height: 20 * ctn.responsiveCofficient(context),
                      ),
                      CustomTextField(
                        secure: false,
                        size: mq.size,
                        controller: nameController,
                        hinttext: 'Name',
                        validator: (String value) {
                          if (value.trim().isEmpty)
                            return 'name should be not empty';
                          else
                            return null;
                        },
                        icondata: Icons.account_circle_outlined,
                      ),
                      CustomTextField(
                        secure: false,
                        size: mq.size,
                        controller: contactController,
                        keyboardType: TextInputType.phone,
                        hinttext: 'Contact number',
                        validator: (String value) {
                          if (value.trim().length < 10)
                            return 'invalid contact';
                          else
                            return null;
                        },
                        icondata: Icons.phone_android_outlined,
                      ),
                      CustomTextField(
                        secure: false,
                        size: mq.size,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        hinttext: 'Email',
                        validator: (String value) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (emailValid)
                            return null;
                          else
                            return 'Not a valid Email';
                        },
                        icondata: Icons.alternate_email,
                      ),
                      CustomTextField(
                        secure: !showPassword,
                        size: mq.size,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        hinttext: 'Password',
                        validator: (String value) {
                          if (value.trim().length < 8)
                            return 'Password should more than 8 characters';
                          else
                            return null;
                        },
                        icondata: Icons.lock_outlined,
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
                      SizedBox(
                        height: 20 * ctn.responsiveCofficient(context),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25 * ctn.responsiveCofficient(context))),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            signup(
                              branch: widget.branch,
                              enrollment: widget.enrollment,
                              institute: widget.institute,
                              semester: widget.semester,
                              contact: contactController.text,
                              email: emailController.text,
                              name: nameController.text,
                              password: passwordController.text,
                            ).then((value) {
                              setState(() {
                                loading = false;
                                signOut().then((value) => Navigator.of(context)
                                    .popUntil((route) => route.isFirst));
                                Fluttertoast.showToast(msg: 'Account Created');
                              });
                            }).catchError((onError) {
                              setState(() {
                                loading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: "not able to sign up");
                            });
                          }
                          setState(() {
                            _autovalidate = true;
                          });
                        },
                        color: Colors.blueAccent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  60 * ctn.responsiveCofficient(context),
                              vertical: 15 * ctn.responsiveCofficient(context)),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    18 * ctn.responsiveCofficient(context)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30 * ctn.responsiveCofficient(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Terms And Conditions.",
                              style: TextStyle(
                                fontSize:
                                    16 * ctn.responsiveCofficient(context),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                ' Click here',
                                style: TextStyle(
                                    fontSize:
                                        16 * ctn.responsiveCofficient(context),
                                    color: Colors.blueAccent),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      )),
    );
  }
}
