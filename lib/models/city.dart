import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class City {
  String city;
  Color color;
  City({this.city, this.color});

  City.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['city'] = this.city;
    data['color'] = this.color;

    return data;
  }

  City.fromSnapShot(DocumentSnapshot documentSnapshot)
      : this.fromJson(documentSnapshot.data);
}
