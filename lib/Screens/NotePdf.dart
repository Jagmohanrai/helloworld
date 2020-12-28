import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class PdfPage extends StatefulWidget {
  final String name;
  final String title;

  const PdfPage({Key key, this.name, this.title}) : super(key: key);
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  bool loading = true;
  String localfile;
  int current = 1;
  int total;
  Future<String> loaddata() async {
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + widget.name);

    await FirebaseStorage.instance
        .ref()
        .child(widget.name)
        .getData(50000000)
        .then((value) async {
      file.writeAsBytes(value);
    }).catchError((onError) {
      Fluttertoast.showToast(msg: onError);
    });
    return file.path;
  }

  @override
  void initState() {
    super.initState();
    loaddata().then((value) {
      setState(() {
        localfile = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PDFView(
              filePath: localfile,
              fitEachPage: true,
              onPageChanged: (t, c) {
                setState(() {
                  current = t + 1;
                  total = c;
                });
              },
            ),
      floatingActionButton: total != null
          ? FloatingActionButton.extended(
              backgroundColor: Colors.white,
              onPressed: () {},
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(current.toString(),
                      style: TextStyle(color: Colors.blue)),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    total.toString(),
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
            )
          : Container(),
    ));
  }
}
