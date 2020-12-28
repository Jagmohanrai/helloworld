import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/Components/constants.dart' as cst;
import 'package:helloworld/Screens/NotePdf.dart';

class QPList extends StatefulWidget {
  final String subjectName;

  const QPList({Key key, this.subjectName}) : super(key: key);

  @override
  _QPListState createState() => _QPListState();
}

class _QPListState extends State<QPList> {
  bool loading = true;
  List<dynamic> notes = [];
  fetchdata() async {
    await FirebaseFirestore.instance
        .collection('Subjects')
        .doc(widget.subjectName)
        .get()
        .then((v) {
      notes = v.data()["questionpapers"];
      setState(() {
        loading = false;
      });
    }).catchError((onError) {
      notes = null;
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: mq.size.height * 0.3,
                      child: Image.asset('assets/splash_bg.png'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: mq.size.height * 0.66,
                      child: notes != null
                          ? ListView.builder(
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PdfPage(
                                                  name: notes[i]
                                                      ['questionPaperName'],
                                                  title: notes[i]
                                                      ['questionPaperTitle'],
                                                )));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15 *
                                            cst.responsiveCofficient(context),
                                        vertical: 10 *
                                            cst.responsiveCofficient(context)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15 *
                                            cst.responsiveCofficient(context)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10,
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              offset: Offset(0, 0),
                                              spreadRadius: 0)
                                        ],
                                        color: Colors.white,
                                      ),
                                      height: 90 *
                                          cst.responsiveCofficient(context),
                                      child: Center(
                                        child: ListTile(
                                          title: Text(
                                            notes[i]['questionPaperTitle'],
                                            style: TextStyle(
                                              fontSize: 18 *
                                                  cst.responsiveCofficient(
                                                      context),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: EdgeInsets.only(
                                                left: 12 *
                                                    cst.responsiveCofficient(
                                                        context)),
                                            child: Text(
                                              notes[i]['createdBy'],
                                            ),
                                          ),
                                          leading: Image.asset(
                                              'assets/questionpaper.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: notes.length,
                            )
                          : Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        20 * cst.responsiveCofficient(context)),
                                child: Column(
                                  children: [
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Text(
                                      'Notes are not available for this subject',
                                      style: TextStyle(
                                          fontSize: 20 *
                                              cst.responsiveCofficient(
                                                  context)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
