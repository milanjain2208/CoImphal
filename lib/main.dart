import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/services/Auth.dart';
import 'package:learn_app/shared_widgets/CustomerDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthService().handleAuth(),
    );
  }
}







