import 'package:flutter/material.dart';
import 'package:helloworld/Components/constants.dart' as cst;

class SubjectTile extends StatelessWidget {
  final subjectName;

  const SubjectTile({Key key, this.subjectName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 15 * cst.responsiveCofficient(context),
          vertical: 10 * cst.responsiveCofficient(context)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(15 * cst.responsiveCofficient(context)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 0),
                spreadRadius: 0)
          ],
          color: Colors.white,
        ),
        height: 90 * cst.responsiveCofficient(context),
        child: Center(
          child: ListTile(
            title: Text(
              subjectName,
              style: TextStyle(
                fontSize: 18 * cst.responsiveCofficient(context),
              ),
            ),
            leading: Image.asset('assets/subjecticon.png'),
          ),
        ),
      ),
    );
  }
}
