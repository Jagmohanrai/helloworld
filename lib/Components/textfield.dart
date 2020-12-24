import 'package:flutter/material.dart';
import './constants.dart' as cst;

class CustomTextField extends StatelessWidget {
  final bool secure;
  final Size size;
  final IconData icondata;
  final String hinttext;
  final TextEditingController controller;
  final Function validator;
  final Function onEditingComplete;
  final TextInputType keyboardType;
  Function onValueChanged = (String data) {};
  Widget trailingWidget;

  CustomTextField({
    this.controller,
    this.hinttext,
    this.icondata,
    this.secure,
    this.size,
    this.validator,
    this.onEditingComplete,
    this.keyboardType,
    this.onValueChanged,
    this.trailingWidget,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.0195),
      child: Container(
        height: size.height * 0.106,
        child: Padding(
          padding: EdgeInsets.only(
            left: size.height * 0.026,
            right: size.height * 0.013,
          ),
          child: Stack(
            children: [
              Align(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.6),
                        offset: Offset(0, 0),
                        blurRadius: 10,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18),
                        validator: validator,
                        obscureText: secure,
                        controller: controller,
                        onEditingComplete: onEditingComplete,
                        keyboardType: keyboardType,
                        onChanged: onValueChanged,
                        decoration: InputDecoration.collapsed(
                          hintText: hinttext,
                          hintStyle: TextStyle(
                              fontSize: 18 * cst.responsiveCofficient(context)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 35 * cst.responsiveCofficient(context),
                  ),
                  child: trailingWidget,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
