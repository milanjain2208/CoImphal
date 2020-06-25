import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/services/Auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:learn_app/shared_widgets/CustomerDetails.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool>  _pos = _position();
  static Future<bool> _position() async {
    position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double distanceInMeters = await Geolocator().distanceBetween(position.latitude, position.longitude, 24.8558, 93.94343);
    if(distanceInMeters>12000) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<void> _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return;
  }
  Future<void> requestPermission() async {
    final PermissionStatus permissionRequestResult = await LocationPermissions()
        .requestPermissions(permissionLevel: LocationPermissionLevel.location);

    setState(() {
      print(permissionRequestResult);
    });
  }


  @override

  void initState() {
    _getPrefs();
    super.initState();
  }
  Widget build(BuildContext context) {
      return FutureBuilder(
        future: _pos,
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.done) {
          print(snapshot.data);
          if(snapshot.data==null) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Give location permission to access the app"),
                        FlatButton(
                          child: Text('Press Me'),
                          onPressed: requestPermission,
                        )
                      ],
                    ),
                  ),
                )
            );
          }
            if(snapshot.data==true) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: Center(
                      child: Text("You are not in the region to access the app"),
                    ),
                  )
              );
            }
            else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: AuthService().handleAuth(),
              );
            }
           }
          else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Checking your Region"),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              )
            );
          }
          }
      );
  }
}








