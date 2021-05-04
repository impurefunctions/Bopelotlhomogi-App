import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Donate {
  String did;
  String dname;
  String ditem;
  String phno;
  String msg;
  String imageurl;
  String daddress;
  String nid;

  Donate({
    this.did,
    this.dname,
    this.ditem,
    this.daddress,
    this.imageurl,
    this.msg,
    this.nid,
    this.phno,
  });
  Donate.fromJson(Map<String, dynamic> json) {
    did = json['did'];
    dname = json['dname'];
    ditem = json['ditem'];
    daddress = json['daddress'];
    imageurl = json['imageurl'];
    msg = json['msg'];
    nid = json['nid'];
    phno = json['phno'];
  }

  Donate.fromSnapShot(DocumentSnapshot documentSnapshot)
      : this.fromJson(documentSnapshot.data);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['did'] = this.did;
    data['dname'] = this.dname;
    data['ditem'] = this.ditem;
    data['daddress'] = this.daddress;
    data['imageurl'] = this.imageurl;
    data['msg'] = this.msg;
    data['nid'] = this.nid;
    data['phno'] = this.phno;

    return data;
  }
}
