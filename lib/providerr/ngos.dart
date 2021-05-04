import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oldies/models/ngo.dart';
import 'package:http/http.dart' as http;

class NGOs with ChangeNotifier {
  List<NGO> _items = [];

  static const NGO_COLLECTION = 'ngos';

  List<NGO> get items {
    return _items;
  }

  final String authToken;
  final String usermail;
  NGOs(this.authToken, this._items, this.usermail);

  Future<void> addrequest(NGO ngo) async {
    Firestore.instance
        .collection(NGO_COLLECTION)
        .add(ngo.toJson())
        .whenComplete(() {
      notifyListeners();
          print("NGO added");
        });


  }

  Future<void> fetchAndSetData() async {
    Firestore.instance.collection(NGO_COLLECTION).getDocuments().then((value) {
      for (var item in value.documents) {
        final ngo = NGO.fromSnapshot(item);

        _items.removeWhere((element) => ngo.name == element.name);
        _items.add(ngo);
      }
      notifyListeners();
    });

  }

  Future<void> deleteProds(String idd) async {
    final url =
        'https://bopelotlhomogiv3-default-rdb.firebaseio.com/donate/$idd.json?auth=$authToken';
    _items.removeWhere((prod) => prod.id == idd);

    await Firestore.instance.collection(NGO_COLLECTION).document(idd).delete();
    notifyListeners();
  }
}
