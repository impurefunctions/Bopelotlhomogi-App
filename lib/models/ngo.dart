import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NGO {
  String id;
  String city;
  String name;
  String number;
  String aboutus;
  String location;
  String imageurl;
  double latitude;
  double longitude;

  NGO({
    this.id,
    this.name,
    this.city,
    this.number,
    this.location,
    this.aboutus,
    this.imageurl,
    this.latitude,
    this.longitude,
  });
  NGO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    number = json['number'];
    location = json['location'];
    aboutus = json['aboutus'];
    imageurl = json['imageurl'];
    latitude = json['latitude'] as double;
    longitude = json['longitude'] as double;
  }

  NGO.fromSnapshot(DocumentSnapshot snapshot) : this.fromJson(snapshot.data);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    data['number'] = this.number;
    data['location'] = this.location;
    data['aboutus'] = this.aboutus;
    data['imageurl'] = this.imageurl;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['title'] = this.name;

    return data;
  }
}
