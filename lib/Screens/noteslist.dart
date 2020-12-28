import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/Components/constants.dart' as cst;
import 'package:helloworld/Screens/NotePdf.dart';

class NotesList extends StatefulWidget {
  final String subjectName;

  const NotesList({Key key, this.subjectName}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  bool loading = true;
  List<dynamic> notes = [];
  fetchdata() async {
    await FirebaseFirestore.instance
        .collection('Subjects')
        .doc(widget.subjectName)
        .get()
        .then((v) {
      notes = v.data()["notes"];
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
                                                  name: notes[i]['noteName'],
                                                  title: notes[i]['noteTitle'],
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
                                            notes[i]['noteTitle'],
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
                                              'assets/notebook.png'),
                                          trailing: IconButton(
                                            icon: Icon(Icons.info_outline),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                child: AlertDialog(
                                                  titleTextStyle: TextStyle(
                                                    fontSize: 20 *
                                                        cst.responsiveCofficient(
                                                            context),
                                                    color: Colors.black,
                                                  ),
                                                  title: Text('Topic Covered'),
                                                  content: Text(
                                                    notes[i]['topicCovered'],
                                                  ),
                                                  contentTextStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16 *
                                                        cst.responsiveCofficient(
                                                            context),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 25 *
                                                        cst.responsiveCofficient(
                                                            context),
                                                    top: 10 *
                                                        cst.responsiveCofficient(
                                                            context),
                                                    bottom: 20 *
                                                        cst.responsiveCofficient(
                                                            context),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
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
