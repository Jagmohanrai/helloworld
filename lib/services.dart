library authentication;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _db = FirebaseFirestore.instance;

Future<UserCredential> signin({String email, String password}) {
  return _auth.signInWithEmailAndPassword(email: email, password: password);
}

Future signOut() {
  return _auth.signOut();
}

Future signup({
  @required String email,
  @required String password,
  @required String name,
  @required String institute,
  @required String contact,
  @required String branch,
  @required String semester,
  @required String enrollment,
}) {
  return _auth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((value) {
    _db.collection("Users").doc(value.user.uid).set({
      "email": value.user.email,
      "name": name,
      "institute": institute,
      "contact": contact,
      "branch": branch,
      "enrollment": enrollment,
      "semester": semester,
      "bookbank": "",
    });
  });
}

Future passReset({
  @required String email,
}) {
  return _auth.sendPasswordResetEmail(email: email);
}

Future<List> getUserSubjects(User user) async {
  List value;
  await _db.collection('Users').doc(user.uid).get().then((data) async {
    await _db
        .collection('Branch')
        .doc(data['branch'])
        .get()
        .then((branch) async {
      value = branch[data['semester'].toString()];
    });
  });
  return value;
}
