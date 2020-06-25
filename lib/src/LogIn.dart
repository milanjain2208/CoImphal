import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/services/Auth.dart';
import 'package:learn_app/shared_widgets/CustomerDetails.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Shieldo IMF",style: TextStyle(color: Colors.blueAccent,fontSize: 40),),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    validator: (val){
                      if(val.length!=10) {
                        return "Invalid phoneNo";
                      }
                      else {
                        return "Valid";
                      }
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter phone number',prefixText: '+91',
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.purpleAccent))),
                    onChanged: (val)  {
                      phone_no = val;
                      setState(() {
                        this.phoneNo = '+91' + val;
                        if(val.length<10) {
                          this.codeSent = false;
                        }
                      });
                    },
                  )),
              codeSent ? Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Enter OTP'),
                    onChanged: (val) {
                      setState(() {
                        this.smsCode = val;
                      });
                    },
                  )) : Container(),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.greenAccent,
                      child: Center(child: codeSent ? Text('Login'):Text('Verify')),
                      onPressed: () {
                        prefs.setString('phone_no', phone_no);
                        codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                      }))
            ],
          )),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = false;
      });
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}