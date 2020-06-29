import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget omitSring(int mrp) {
  return mrp==null?Text(""):Text(mrp.toString(),
    style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 20,color: Colors.grey),);
}
Widget additional(String addi) {
  return addi==null?Text(""):Text('('+addi+')',
    style: TextStyle(fontSize: 20),);
}