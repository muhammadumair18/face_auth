import 'package:flutter/material.dart';

void customBottomSnackbar(BuildContext screencontext,String message){
  ScaffoldMessenger.of(screencontext).showSnackBar(SnackBar(
    content: Text(message,style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
    duration: Duration(milliseconds: 3000),
  ));
}