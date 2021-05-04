import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:oldies/models/donate.dart';


class Donator with ChangeNotifier {
  static const DONORS = 'donors';

  List<Donate> _dlist = [];

  List<Donate> get dlist {
    return _dlist;
  }

  final String authToken;
  final String usermail;
  Donator(this.authToken, this._dlist, this.usermail);
  Future<void> addrequest(Donate donor) async {
    Firestore.instance
        .collection(DONORS)
        .add(donor.toJson())
        .whenComplete(() => print("Donor added"));

    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    Firestore.instance.collection(DONORS).getDocuments().then((value) {
      for (var item in value.documents) {
        final ngo = Donate.fromSnapShot(item);

        _dlist.removeWhere((element) => ngo.dname == element.dname);
        _dlist.add(ngo);
      }
      notifyListeners();
    });

  }

  Future<void> deleteProds(String idd) async {
    _dlist.removeWhere((prod) => prod.did == idd);

    await Firestore.instance.collection(DONORS).document(idd).delete();
    notifyListeners();
  }
}
