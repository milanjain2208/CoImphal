import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:learn_app/shared_widgets/Card_Badge.dart';
import 'Cart.dart';


class Details extends StatefulWidget {
  final dynamic product;
  Details({this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var _value = 1.0;
  void _onValueChanged(double value) {
    setState(() {
      _value = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text('Covid Care Imphal',style: TextStyle(
        color: Colors.blueAccent,
       ),),
        actions: <Widget>[
          CartBadge(),
        ],
      ),
      body: Builder(
        builder: (context)
    {
      return Column(
        children: <Widget>[
          Container(
              height: 250,
              child: HorizontalList(product: widget.product,)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(widget.product['name'], style: TextStyle(
                fontSize: 30,
                color: Colors.blueAccent,
              ),),
              Text("Rs " + widget.product['price'].toString(), style: TextStyle(
                fontSize: 30,
                color: Colors.blueAccent,
              ),),
            ],
          ),
          Text(widget.product['description'], style: TextStyle(
            fontSize: 20,
            color: Colors.blueAccent,
          ),),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
              child: Text("Select quantity")),
          Slider(
            value: _value,
            min: 1.0,
            max: 10.0,
            divisions: 9,
            activeColor: Colors.purple,
            onChanged: _onValueChanged,
            label: _value.floor().toString() + "Box",
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.blueAccent,
            textColor: Colors.white,
            child: Text("Add to Cart"),
            onPressed: () {
              products.add(
                  ProductPair(product: widget.product, quantity: _value));
              cartBadge.setState(() {});
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(widget.product['name'] + " added to cart",style: TextStyle(color: Colors.black),),
                backgroundColor: Colors.greenAccent,
              ));
            },
          ),
        ],
      );
    },
      )
    );
  }
}
class HorizontalList extends StatelessWidget {
  final dynamic product;
  @override
  HorizontalList({this.product});
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return new Image.network(
          product['images'][index],
        );
      },
      itemCount: product['images'].length,
      pagination: new SwiperPagination(),
      control: new SwiperControl(),
    );
  }
}

