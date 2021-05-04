import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:oldies/models/job.dart';

class Jobs with ChangeNotifier {
  static const COLLECTION = 'jobs';
  List<Job> _items = [];

  List<Job> get jitem {
    return _items;
  }

  final String authToken;
  final String usermail;
  Jobs(this.authToken, this._items, this.usermail);

  Future<void> addjob(Job item) async {
    Firestore.instance
        .collection(COLLECTION)
        .add(item.toJson())
        .whenComplete(() => print("Job added"));
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    Firestore.instance.collection(COLLECTION).getDocuments().then((value) {
      for (var item in value.documents) {
        final obj = Job.fromSnapShot(item);
        _items.removeWhere((element) => obj.name == element.name);
        _items.add(obj);
      }
      notifyListeners();
    });


  }

  Future<void> deleteProds(String idd) async {
    final url =
        'https://bopelotlhomogiv3-default-rdb.firebaseio.com/donate/$idd.json?auth=$authToken';
    _items.removeWhere((prod) => prod.jid == idd);

    await Firestore.instance.collection(COLLECTION).document(idd).delete();
    notifyListeners();
  }
}
