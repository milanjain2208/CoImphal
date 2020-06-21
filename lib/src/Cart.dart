import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/services/UpiPayment.dart';
import 'package:learn_app/shared_widgets/CustomerDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomerScreen.dart';
class ProductPair {
  dynamic product;
  double quantity;
  ProductPair({this.product,this.quantity});
}
List<ProductPair> products =  new List();
class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  Future<void> _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return;
  }

  @override

  void initState() {
    _getPrefs();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text("Items Added",style: TextStyle(
          color: Colors.blueAccent,
        ),),
      ),
      body: products.length==0?Center(child: Text("No items selected")):ListView.separated(
          itemCount: products.length,
          separatorBuilder: (context, index) =>Divider(),
          itemBuilder: (BuildContext context,int index) {
             return Dismissible(
               onDismissed: (direction){
                 setState(() {
                   products.removeAt(index);
                 });
               },
               background: Container(
                 color: Colors.redAccent,
               ),
               child: ListTile(
                 leading: ConstrainedBox(
                   constraints: BoxConstraints(
                     minWidth: 44,
                     minHeight: 44,
                     maxWidth: 64,
                     maxHeight: 64,
                   ),
                   child: Image.network(products[index].product['images'][0]),
                 ),
                 title:Text(products[index].product['name']),
                 subtitle: Text(products[index].quantity.toString()),
               ),
               key: ObjectKey(products[index]),
             );
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: products.length==0?null:FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        label: Text("Place Order"),
        onPressed: () {
           Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => prefs.get('name')==null ?Customer():UpiPayment()));
        },
      ),
    );
  }
}

