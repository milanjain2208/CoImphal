import 'package:geolocator/geolocator.dart';
import 'package:learn_app/src/Cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

String phone_no;
String name="";
String address;
SharedPreferences prefs;
Position position ;
String txnId;
double totalamount;
double calc_amount() {
  double sum=0;
  for(int i=0;i<products.length;i++) {
    sum+=products[i].product['price']*products[i].quantity;
  }
  totalamount=sum;
  return sum;
}