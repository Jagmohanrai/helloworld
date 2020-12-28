import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/Components/constants.dart' as ctn;
import 'package:helloworld/Screens/SubjectsNotes.dart';
import 'package:helloworld/Screens/SubjectsQP.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget buildHomeTile({Size size, String assetname, String title}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius:
            BorderRadius.circular(20 * ctn.responsiveCofficient(context)),
      ),
      height: 170 * ctn.responsiveCofficient(context),
      width: 170 * ctn.responsiveCofficient(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            assetname,
            height: 120 * ctn.responsiveCofficient(context),
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20 * ctn.responsiveCofficient(context)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Hello World'),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    setState(() {});
                  })
            ],
          ),
          drawer: Drawer(),
          body: Container(
            height: mq.size.height - mq.padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Subjects(
                              user: widget.user,
                            ),
                          ),
                        );
                      },
                      child: buildHomeTile(
                        size: mq.size,
                        assetname: "assets/notes.png",
                        title: "Notes",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubjectQP(
                              user: widget.user,
                            ),
                          ),
                        );
                      },
                      child: buildHomeTile(
                        size: mq.size,
                        assetname: "assets/question.png",
                        title: "Question Papers",
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildHomeTile(
                      size: mq.size,
                      assetname: "assets/internship.png",
                      title: "Internship",
                    ),
                    buildHomeTile(
                      size: mq.size,
                      assetname: "assets/books.png",
                      title: "BookBank",
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
