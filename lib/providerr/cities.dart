import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oldies/models/city.dart';

class Cities with ChangeNotifier {
  List<City> _citylist = [
    City(
      city: "Gaborone",
      color: Colors.amber,
    ),
    City(city: "Francistown", color: Colors.pink[100]),
    City(city: "Jwaneng", color: Colors.lime),
    City(city: "Gantsi", color: Colors.blue[200]),
    City(city: "Serowe", color: Colors.amberAccent),
    City(city: "Lobatse", color: Colors.amberAccent),
    City(city: "Palapye", color: Colors.green[400]),
    City(city: "Other", color: Colors.deepOrangeAccent)
  ];

  List<City> get citylist {
    return _citylist;
  }
}
