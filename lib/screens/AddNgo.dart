import 'dart:io';

//import 'package:image_picker/image_picker.dart';
import "package:firebase_storage/firebase_storage.dart";
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oldies/models/ngo.dart';
import 'package:oldies/providerr/ngos.dart';
import 'package:oldies/widgets/image_input.dart';
import 'package:oldies/widgets/map_location.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  static const routname = "/addngo";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _gkey = GlobalKey<FormState>();
  File _userImage;
  double lat = 0;
  double lon = 0;

  final _focus = FocusNode();

  final _about = FocusNode();

  final _num = FocusNode();
  // final _city = FocusNode();
  var _loading = false;
  var _editedRequest = NGO(
      id: DateTime.now().toString(),
      name: "",
      city: "",
      number: "",
      location: "",
      aboutus: "",
      imageurl: "",
      latitude: 0,
      longitude: 0);
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final citi = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
        title: Text("Register the Institution",
            style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                _saveform();
              })
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _gkey,
                child: ListView(
                  children: <Widget>[
                    FlatButton.icon(
                      icon: Icon(Icons.my_location),
                      label: Text(
                        "Press here to get coordinates ",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        // Scaffold.of(context).hideCurrentSnackBar();
                        getcurrentLocation();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Latitude : " + lat.toString()),
                        Text("Longitude : " + lon.toString()),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Note : The above button should be used when are inside the app in order to fetch your current location And this will be helpful to other users",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      softWrap: true,
                    ),

                    // Container(
                    //     decoration: BoxDecoration(
                    //       border: Border.all(width: 1, color: Colors.grey),
                    //     ),
                    //     height: 230,
                    //     width: double.infinity,
                    //     child: (lat == 0 && lon == 0)
                    //         ? Center(
                    //             child: Text(
                    //             "Please click on the locator for previewing MAP",
                    //             style: TextStyle(fontSize: 15),
                    //           ))
                    //         : Locator(lat, lon)),
                    Divider(),

                    ImageInput(_pickedImage),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Name OF Institution",
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field cannot be left empty';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _editedRequest = NGO(
                          name: val,
                          id: _editedRequest.id,
                          aboutus: _editedRequest.aboutus,
                          city: citi,
                          number: _editedRequest.number,
                          imageurl: _editedRequest.imageurl,
                          latitude: _editedRequest.latitude,
                          longitude: _editedRequest.longitude,
                          location: _editedRequest.location,
                        );
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     labelText: "City",
                    //   ),
                    //   focusNode: _focus,
                    //   textInputAction: TextInputAction.next,
                    //   onFieldSubmitted: (_) {
                    //     FocusScope.of(context).requestFocus(_city);
                    //   },
                    //   onSaved: (val) {
                    //     _editedRequest = NGO(
                    //       name: _editedRequest.name,
                    //       id: _editedRequest.id,
                    //       aboutus: _editedRequest.aboutus,
                    //       city: val,
                    //       number: _editedRequest.number,
                    //       imageurl: _editedRequest.imageurl,
                    //       latitude: _editedRequest.latitude,
                    //       longitude: _editedRequest.longitude,
                    //       location: _editedRequest.location,
                    //     );
                    //   },
                    // ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Location",
                      ),
                      focusNode: _focus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_num);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field cannot be left empty';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _editedRequest = NGO(
                          location: val,
                          id: _editedRequest.id,
                          aboutus: _editedRequest.aboutus,
                          city: citi,
                          number: _editedRequest.number,
                          imageurl: _editedRequest.imageurl,
                          latitude: _editedRequest.latitude,
                          longitude: _editedRequest.longitude,
                          name: _editedRequest.name,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Contact No.",
                      ),
                      focusNode: _num,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_about);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field cannot be left empty';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _editedRequest = NGO(
                          location: _editedRequest.location,
                          id: _editedRequest.id,
                          aboutus: _editedRequest.aboutus,
                          city: citi,
                          number: val,
                          imageurl: _editedRequest.imageurl,
                          latitude: _editedRequest.latitude,
                          longitude: _editedRequest.longitude,
                          name: _editedRequest.name,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "About the Institution",
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      focusNode: _about,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field cannot be left empty';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _editedRequest = NGO(
                          aboutus: val,
                          id: _editedRequest.id,
                          name: _editedRequest.name,
                          city: citi,
                          number: _editedRequest.number,
                          imageurl: _editedRequest.imageurl,
                          latitude: _editedRequest.latitude,
                          longitude: _editedRequest.longitude,
                          location: _editedRequest.location,
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _focus.dispose();

    _about.dispose();
    _num.dispose();
    super.dispose();
  }

  void getcurrentLocation() async {
    final pos = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

//function for getting image and saving into firebase;

    setState(() {
      lat = pos.latitude;
      lon = pos.longitude;
      _editedRequest.latitude = lat;
      _editedRequest.longitude = lon;
    });
  }

  void _pickedImage(File image) async {
    setState(() {
      _userImage = image; //for getting the image form the widgets
    });
    final ref = FirebaseStorage.instance
        .ref()
        .child("ngo_image")
        .child(DateTime.now().toString() + ".jpg");

    await ref.putFile(_userImage).onComplete;
    final url = await ref.getDownloadURL();

    setState(() {
      _editedRequest.imageurl = url;
    });
  }

  Future<void> _saveform() async {
    setState(() {
      _loading = true;
    });
    _gkey.currentState.save();
    try {
      await Provider.of<NGOs>(context, listen: false)
          .addrequest(_editedRequest);
    } catch (error) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("!!Error"),
          content: Text("An error ocuured due to somme issue "),
          actions: <Widget>[
            FlatButton(
              child: Text('okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      _loading = false;
    });
    Navigator.of(context).pop();
  }
}
