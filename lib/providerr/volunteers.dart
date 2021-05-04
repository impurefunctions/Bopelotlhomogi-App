import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:oldies/models/volunteer.dart';

class Volunteers with ChangeNotifier {
  List<Volunteer> _items = [];

  static const COLLECTION = 'volunteers';

  List<Volunteer> get vitems {
    return _items;
  }

  final String authToken;
  final String usermail;
  Volunteers(this.authToken, this._items, this.usermail);

  Future<void> addwork(Volunteer item) async {
    Firestore.instance
        .collection(COLLECTION)
        .add(item.toJson())
        .whenComplete(() => print("Volunteer added"));
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    Firestore.instance.collection(COLLECTION).getDocuments().then((value) {
      for (var item in value.documents) {
        final obj = Volunteer.fromSnapShot(item);
        _items.removeWhere((element) => obj.id == element.id);
        _items.add(obj);
      }
      notifyListeners();
    });

  }

  Future<void> deleteProds(String idd) async {
    await Firestore.instance.collection(COLLECTION).document(idd).delete();
    notifyListeners();
  }
}
