import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('contact').snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return Center(child: Scaffold(body: Center(child: CircularProgressIndicator())));
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('For any queries',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Please call us on '),
                      InkWell(
                        child: Text('${snapshot.data.documents[0]['ph_no']}',style: TextStyle(color: Colors.blue),),
                        onTap: () {
                          _launchURL('tel:${snapshot.data.documents[0]['ph_no']}');
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Or mail us at '),
                      InkWell(
                        child: Text('${snapshot.data.documents[0]['mail']}',style: TextStyle(color: Colors.blue),),
                        onTap: () {
                          _launchURL('mailto:${snapshot.data.documents[0]['mail']}');
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Stay Home,Stay Safe'),
                ],
              ),
            ),
          );
        }
    );
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
