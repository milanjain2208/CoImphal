import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:learn_app/shared_widgets/Card_Badge.dart';
import 'package:learn_app/shared_widgets/Functions.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.product['name'], style: TextStyle(
                  fontSize: 20,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Rs " + widget.product['price'].toString(), style: TextStyle(
                          fontSize: 20,
                        ),),
                        omitSring(widget.product['mrp']),
                      ],
                    ),
                    additional(widget.product['additional']),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(),
          Text(widget.product['description'], style: TextStyle(
            fontSize: 15,
            color: Colors.blueAccent,
          ),),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
              child: Text("Select quantity")),
          Slider(
            value: _value,
            min: widget.product['min'].toDouble(),
            max: widget.product['max'].toDouble(),
            divisions: widget.product['max']-widget.product['min'],
            activeColor: Colors.purple,
            onChanged: _onValueChanged,
            label: _value.floor().toString(),
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
          loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null ?
                loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        );
      },
      itemCount: product['images'].length,
      pagination: new SwiperPagination(),
      control: new SwiperControl(),
    );
  }
}

