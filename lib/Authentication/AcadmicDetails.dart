import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/Authentication/SignUpPage.dart';
import '../Components/constants.dart' as ctn;
import 'package:helloworld/Components/textfield.dart';

class AcadmicDetails extends StatefulWidget {
  @override
  _AcadmicDetailsState createState() => _AcadmicDetailsState();
}

class _AcadmicDetailsState extends State<AcadmicDetails> {
  TextEditingController enrollmentController = TextEditingController(text: "");

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _autovalidate = false;

  bool loading = false;
  bool showPassword = false;

  void dispose() {
    enrollmentController.dispose();
    super.dispose();
  }

  String institutevalue = 'Select Institute';
  String branchvalue = 'Select Branch';
  String semestervalue = 'Select Semester';

  bool checksem() {
    if (semestervalue == 'Select Semester') {
      return false;
    } else {
      return true;
    }
  }

  bool checkbranch() {
    if (semestervalue == 'Select Branch') {
      return false;
    } else {
      return true;
    }
  }

  bool checkinstitute() {
    if (semestervalue == 'Select Institute') {
      return false;
    } else {
      return true;
    }
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
                          'Acadmic Details',
                          style: TextStyle(
                              fontSize: 35 * ctn.responsiveCofficient(context),
                              color: Colors.blueAccent),
                        ),
                      ),
                      SizedBox(
                        height: 20 * ctn.responsiveCofficient(context),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: mq.size.height * 0.0195),
                        child: Container(
                          height: mq.size.height * 0.106,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: mq.size.height * 0.026,
                              right: mq.size.height * 0.013,
                            ),
                            child: Align(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      15 * ctn.responsiveCofficient(context)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent.withOpacity(0.6),
                                      offset: Offset(0, 0),
                                      blurRadius: 10,
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                height: mq.size.height * 0.08,
                                width: mq.size.width * 0.8,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20 *
                                            ctn.responsiveCofficient(context)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: institutevalue,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18 *
                                                ctn.responsiveCofficient(
                                                    context)),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            institutevalue = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Select Institute',
                                          'Guru Nanak Dev Institute of Technology',
                                          'Rajokari Institute of Technology',
                                          'Ambedkar Institute of Technology',
                                          'Aryabhat Institute of Technology',
                                          'kasturba Institute of Technology',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomTextField(
                        secure: false,
                        size: mq.size,
                        controller: enrollmentController,
                        keyboardType: TextInputType.phone,
                        hinttext: 'Enrollment Number*',
                        validator: (String value) {
                          if (value.trim().length < 10)
                            return 'invalid contact';
                          else
                            return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: mq.size.height * 0.0195),
                        child: Container(
                          height: mq.size.height * 0.106,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: mq.size.height * 0.026,
                              right: mq.size.height * 0.013,
                            ),
                            child: Align(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      15 * ctn.responsiveCofficient(context)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent.withOpacity(0.6),
                                      offset: Offset(0, 0),
                                      blurRadius: 10,
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                height: mq.size.height * 0.08,
                                width: mq.size.width * 0.8,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20 *
                                            ctn.responsiveCofficient(context)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: branchvalue,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18 *
                                                ctn.responsiveCofficient(
                                                    context)),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            branchvalue = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Select Branch',
                                          'Chemical Engineering',
                                          'Computer Engineering',
                                          'Digital Electronics',
                                          'ECE',
                                          'ITES&M',
                                          'Mechanical Engineering',
                                          'Medical Electronics',
                                          'Polymer Engineering',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: mq.size.height * 0.0195),
                        child: Container(
                          height: mq.size.height * 0.106,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: mq.size.height * 0.026,
                              right: mq.size.height * 0.013,
                            ),
                            child: Align(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      15 * ctn.responsiveCofficient(context)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent.withOpacity(0.6),
                                      offset: Offset(0, 0),
                                      blurRadius: 10,
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                height: mq.size.height * 0.08,
                                width: mq.size.width * 0.8,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20 *
                                            ctn.responsiveCofficient(context)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: semestervalue,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18 *
                                                ctn.responsiveCofficient(
                                                    context)),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            semestervalue = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Select Semester',
                                          '1',
                                          '2',
                                          '3',
                                          '4',
                                          '5',
                                          '6',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20 * ctn.responsiveCofficient(context),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25 * ctn.responsiveCofficient(context))),
                        onPressed: () {
                          if (checkbranch() && checkinstitute() && checksem()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(
                                  branch: branchvalue,
                                  institute: institutevalue,
                                  semester: semestervalue,
                                  enrollment: enrollmentController.text,
                                ),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Fields Should not be Empty');
                          }
                        },
                        color: Colors.blueAccent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  60 * ctn.responsiveCofficient(context),
                              vertical: 15 * ctn.responsiveCofficient(context)),
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    18 * ctn.responsiveCofficient(context)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10 * ctn.responsiveCofficient(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ?",
                              style: TextStyle(
                                fontSize:
                                    16 * ctn.responsiveCofficient(context),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                ' Login here',
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
