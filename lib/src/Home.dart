import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_app/services/Auth.dart';
import 'package:learn_app/shared_widgets/Card_Badge.dart';

import 'ProductSpec.dart';


class MyHomePage extends StatelessWidget {
  Widget _productBuilder(String type,BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection(type).snapshots(),
        builder: (context,snapshot) {
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
//                    print("got Data");
          return ProductView(products: snapshot.data.documents);
        }
    );
  }
  List<Widget> _TabChildren(products) {
    int length = products.length;
    List<Widget> tabs= new List();
    for(int i=0;i<length;i++) {
      tabs.add(Tab(text: products[i]['name'],));
    }
    return tabs;
  }
  List<Widget> _TabBarChildren(products,BuildContext context) {
    int length = products.length;
    List<Widget> tabs= new List();
    for(int i=0;i<length;i++) {
      tabs.add(_productBuilder(products[i]['name'], context));
    }
    return tabs;
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('Items').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Center(child: Scaffold(body: Center(child: CircularProgressIndicator())));
        return DefaultTabController(
          length: snapshot.data.documents.length,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text('Shieldo IMF',style: TextStyle(
                color: Colors.blueAccent,
              ),
              ),
              bottom: TabBar(
                isScrollable: true,
                  indicatorColor: Colors.purple,
                  labelColor: Colors.blueAccent,
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: _TabChildren(snapshot.data.documents)
//                    Tab(text: 'Masks'),
//                    Tab(text: 'Masks'),


              ),
              actions: <Widget>[
                FlatButton.icon(
                  label: Text("LogOut"),
                  icon: Icon(Icons.person),
                  onPressed: () {
                    AuthService().signOut();
                  },
                ),
                CartBadge(),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(0.2),
              child: TabBarView(
                children: _TabBarChildren(snapshot.data.documents,context)
              ),
            ),
          ),
        );
      }
    );
  }

}

class ProductView extends StatelessWidget {
  final dynamic products;
  ProductView({this.products});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.purple,width: 4.0),borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(product: products[index],)));
              },
              child: Column(
                children: <Widget>[
                  Image.network(
                    products[index]['images'][0],
                    fit: BoxFit.fitWidth,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(products[index]['name'],style: TextStyle(
                          fontSize: 20,
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Rs "+ products[index]['price'].toString(),style: TextStyle(
                          fontSize: 20,
                        ),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}







