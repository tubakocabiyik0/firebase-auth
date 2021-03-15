import 'package:regexpattern/regexpattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      ]),
    );
  }

  void saveData() {
    String getID = firebaseFirestore.collection("users").doc().id;
    firebaseFirestore.doc("/users/$getID").set({"data": mail,"UId:": getID});
    firebaseFirestore.doc("/users/getID").update({'name':"tubişş",'like':FieldValue.increment(1),'para': 500});

    DocumentReference getRef = firebaseFirestore.doc("/users/getID");
    
    firebaseFirestore.runTransaction((transaction) async {
      DocumentSnapshot getData = await getRef.get();
    if(getData.exists){
      if(getData.data()['para']>200){
        transaction.update(getRef, {'para':getData.data()['para']-200 });
      }


    }else{
      debugPrint("data cant take");
    }

    });


  }
}
