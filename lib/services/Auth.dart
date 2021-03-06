import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/shared_widgets/CustomerDetails.dart';
import 'package:learn_app/src/Home.dart';
import 'package:learn_app/src/LogIn.dart';

class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if(snapshot.connectionState==ConnectionState.active) {
            if (snapshot.hasData) {
              return MyHomePage();
            } else {
              return LoginPage();
            }
          }
          else {
            return Scaffold(
              body: Center(child: Image.asset("assets/covidsafe.png"),),
            );
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
    prefs.clear();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}