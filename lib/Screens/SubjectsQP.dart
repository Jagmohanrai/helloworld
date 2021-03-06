import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/Components/subjectTile.dart';
import 'package:helloworld/Screens/noteslist.dart';
import 'package:helloworld/Screens/questionpaerlist.dart';
import 'package:helloworld/services.dart';

class SubjectQP extends StatefulWidget {
  final User user;

  const SubjectQP({Key key, this.user}) : super(key: key);
  @override
  _SubjectQPState createState() => _SubjectQPState();
}

class _SubjectQPState extends State<SubjectQP> {
  List subject;
  bool loading = true;

  @override
  void initState() {
    getUserSubjects(widget.user).then((value) {
      subject = value;
      setState(() {
        loading = false;
      });
    }).catchError((e) {
      setState(() {
        loading = false;
        Fluttertoast.showToast(msg: 'Unable to fetch the Subjects');
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: mq.size.height - mq.padding.top,
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                        height: mq.size.height * 0.3,
                        child: Image.asset('assets/splash_bg.png')),
                    Container(
                      height: mq.size.height * 0.64,
                      child: ListView.builder(
                        itemBuilder: (context, i) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QPList(
                                  subjectName: subject[i],
                                ),
                              ),
                            );
                          },
                          child: SubjectTile(
                            subjectName: subject[i],
                          ),
                        ),
                        itemCount: subject.length,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
