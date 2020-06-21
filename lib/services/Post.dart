import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_app/shared_widgets/CustomerDetails.dart';
import 'package:learn_app/src/Cart.dart';

void postToFireStore() {

  var reference = Firestore.instance.collection('Order');

  reference.add({
    "Product": toList(),
    "name" : prefs.get('name'),
    "address" : prefs.get('address'),
    "phoneNo" : prefs.get('phone_no'),
  });
}

List<String> toList() {
  List<String> order = new List();
  products.forEach((item) {
    order.add(item.product['name']+"----------"+item.quantity.toString()+ " piece");
  });

  return order.toList();
}