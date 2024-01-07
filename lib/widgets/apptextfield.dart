import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  //void Function(String)? onChangedVal;
   AppTextField({super.key,
   required this.hintText,
   required this.controller,
   required this.validator,
   required this.keyboardType,
   //required this.onChangedVal
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      hintText: hintText,
      ),
      validator: validator,
      //onChanged: onChangedVal,
      keyboardType: keyboardType,
    );
  }
}