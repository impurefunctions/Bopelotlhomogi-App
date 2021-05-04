import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Volunteer {
  String nid;
  String time;
  String purpose;
  String location;
  String id;
  String desc;
  String date;
  String pno;

  Volunteer({
    this.id,
    this.nid,
    this.purpose,
    this.location,
    this.time,
    this.desc,
    this.date,
    this.pno,
  });

  Volunteer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nid = json['nid'];
    purpose = json['purpose'];
    location = json['location'];
    time = json['time'];
    desc = json['desc'];
    date = json['date'];
    pno = json['pno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['nid'] = this.nid;
    data['purpose'] = this.purpose;
    data['location'] = this.location;
    data['time'] = this.time;
    data['desc'] = this.desc;
    data['date'] = this.date;
    data['pno'] = this.pno;

    return data;
  }

  Volunteer.fromSnapShot(DocumentSnapshot documentSnapshot)
      : this.fromJson(documentSnapshot.data);
}
