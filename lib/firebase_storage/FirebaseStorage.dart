import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FStorage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _StorageState createState() => _StorageState();
}

class _StorageState extends State<FStorage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var formKey = GlobalKey<FormState>();
  bool validate = false;
  String mail;
  PickedFile _pickedFile;
  final imagePicker = ImagePicker();
  var url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage"),
        backgroundColor: Colors.red.shade200,
      ),
      body: bodyPage(),
    );
  }

  bodyPage() {
    return Form(
      // ignore: deprecated_member_use
      autovalidate: validate,
      key: formKey,
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: InputDecoration(
                  labelText: "email",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple.shade200)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple.shade200)),
                  hoverColor: Colors.purple.shade200,
                ),
                // ignore: deprecated_member_use
                validator: (value) {
                  if (value.length < 3) {
                    return "value size cannat be less 3";
                  }
                },
                onSaved: (value) {
                  mail = value;
                })),
        RaisedButton(
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              saveData();
            }
          },
          color: Colors.purple.shade200,
          child: Text("save"),
        ),
        RaisedButton(
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              getData();
            }
          },
          color: Colors.greenAccent.shade200,
          child: Text("getData"),
        ),
        RaisedButton(
          onPressed: () {
            deleteData();
          },
          color: Colors.red.shade300,
          child: Text("delete"),
        ),
        RaisedButton(
          onPressed: () {
            gallery();
          },
          color: Colors.pinkAccent.shade100,
          child: Text("take photo from gallery"),
        ),
        RaisedButton(
          onPressed: () {
            camera();
          },
          color: Colors.blue.shade200,
          child: Text("camera"),
        ),
        Expanded(
          child: Center(
            child: Container(
              child: _pickedFile == null
                  ? Text("")
                  : Image.file(File(_pickedFile.path)),
            ),
          ),
        )
      ]),
    );
  }

  void saveData() {

    firebaseFirestore.collection("users").doc("getID").set({'image':url});





    String getID = firebaseFirestore.collection("users").doc().id;
    firebaseFirestore.doc("/users/$getID").set({"data": mail, "UId:": getID});
    firebaseFirestore
        .doc("/users/getID")
        .update({'like': FieldValue.increment(1), 'para': 500});

    DocumentReference getRef = firebaseFirestore.doc("/users/getID");

    firebaseFirestore.runTransaction((transaction) async {
      DocumentSnapshot getData = await getRef.get();
      if (getData.exists) {
        if (getData.data()['para'] > 200) {
          transaction.update(getRef, {'para': getData.data()['para'] - 200});
        }
      } else {
        debugPrint("data cant take");
      }
    });
  }

  void deleteData() {
    firebaseFirestore.doc("/users/getID").update({'name': FieldValue.delete()});
  }

  void getData() async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.doc("/users/getID").get();
    if (snapshot.exists) {
      String gettingData = snapshot.data()['$mail'];
    } else {
      debugPrint("dont take data");
    }
    DocumentReference documentReference = firebaseFirestore.doc("/users/getID");
    documentReference.snapshots().listen((event) {});

    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection("users")
        .where("name", isEqualTo: "Beth hormon")
        .get();
    for (var docs in querySnapshot.docs) {
      debugPrint(docs.data().toString());
    }
  }

  void gallery() async {
    var photo = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _pickedFile = photo;
    });
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("Name")
        .child("user")
        .child("tu.png");
    StorageUploadTask storageUploadTask =
        await ref.putFile(File(_pickedFile.path));
     url = await (await storageUploadTask.onComplete).ref.getDownloadURL();
    debugPrint(url);
  }

  void camera() async {
    var photo = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _pickedFile = photo;
    });
  }
}
