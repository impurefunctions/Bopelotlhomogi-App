import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Job {
  String jid;
  String name;
  String service;
  String imageurl;
  String nid;

  Job({
    this.jid,
    this.name,
    this.service,
    this.imageurl,
    this.nid,
  });
  Job.fromJson(Map<String, dynamic> json) {
    jid = json['jid'];
    name = json['name'];
    service = json['service'];
    imageurl = json[' image_url'];
    nid = json['nid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jid'] = this.jid;
    data['name'] = this.name;
    data['service'] = this.service;
    data['imageurl'] = this.imageurl;
    data['nid'] = this.nid;

    return data;
  }

  Job.fromSnapShot(DocumentSnapshot documentSnapshot)
      : this.fromJson(documentSnapshot.data);
}
