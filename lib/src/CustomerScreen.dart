
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/shared_widgets/CustomerDetails.dart';



class Customer extends StatelessWidget {
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Your Details",
                style: TextStyle(color: Colors.blueAccent, fontSize: 40),),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    validator: (val)=>val.isEmpty?'Enter your name':null,
                    decoration: InputDecoration(
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purpleAccent))),
                    onChanged: (val) {
                      name = val;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    validator: (val)=>val.isEmpty?'Enter your home address':null,
                    decoration: InputDecoration(
                        hintText: 'Enter your Address',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purpleAccent))),
                    onChanged: (val) {
                      address = val;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.greenAccent,
                      child: Center(
                          child:Text('Save')),
                      onPressed: () {
                        if(formKey.currentState.validate()) {
                          prefs.setString('name', name);
                          prefs.setString('address',address);
                          Navigator.pop(context);
                        }

                      }))
            ],
          )),
    );
  }
}
