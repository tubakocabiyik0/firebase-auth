import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:regexpattern/regexpattern.dart';

class LoginP extends StatefulWidget {
  // This widget is the root of your application.
  @override
  StateLogin createState() => StateLogin();
}

class StateLogin extends State<LoginP> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool validate = false;
  TextEditingController textEditingController, textEditingController2;
  String mail;
  String pass;
  String updatedMail;
  String mailU;
  String passU;
  var formKey = GlobalKey<FormState>();
  var formKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseAuth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Login "),
        backgroundColor: Colors.lightBlue.shade200,
      ),
      body: body(),
    );
  }

  body() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              // ignore: deprecated_member_use
              autovalidate: validate,
              key: formKey,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "email",
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple.shade200)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple.shade200)),
                            hoverColor: Colors.purple.shade200,
                          ),
                          // ignore: deprecated_member_use
                          validator: (value) {
                            if (!value.isEmail()) {
                              return "please write email";
                            }
                          },
                          onSaved: (value) {
                            mail = value;
                          })),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorColor: Colors.purple.shade200,
                      // ignore: deprecated_member_use
                      validator: (value) {
                        if (!value.isPasswordEasy()) {
                          return "error ";
                        }
                      },
                      onSaved: (value) {
                        pass = value;
                      },
                      decoration: InputDecoration(
                        labelText: "password",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple.shade200)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple.shade200)),
                        hoverColor: Colors.purple.shade200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                createUser();
              },
              color: Colors.purple.shade200,
              child: Text("SignUp"),
            ),
            RaisedButton(
              onPressed: () {
                signIn();
              },
              color: Colors.purple.shade200,
              child: Text("Sign in"),
            ),
            RaisedButton(
              onPressed: () {
                signOut();
              },
              color: Colors.purple.shade200,
              child: Text("Sign out"),
            ),
            RaisedButton(
              onPressed: () {
                resetPass();
              },
              color: Colors.purple.shade200,
              child: Text("Forgat password"),
            ),
            RaisedButton(
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (context) => SimpleDialog(
                          title: Text("update email"),
                          children: [
                            Form(
                              key: formKey1,
                              // ignore: deprecated_member_use
                              autovalidate: validate,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextFormField(
                                    cursorColor: Colors.purple.shade200,
                                    // ignore: deprecated_member_use
                                    validator: (value) {
                                      if (!value.isPasswordEasy()) {
                                        return "error ";
                                      }
                                    },
                                    onSaved: (value) {
                                      mailU = value;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Mail",
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.purple.shade200)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.purple.shade200)),
                                    ),
                                  ),
                                  TextFormField(
                                    cursorColor: Colors.purple.shade200,
                                    // ignore: deprecated_member_use
                                    validator: (value) {
                                      if (!value.isPasswordEasy()) {
                                        return "error ";
                                      }
                                    },
                                    onSaved: (value) {
                                      passU = value;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "pass",
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.purple.shade200)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.purple.shade200)),
                                    ),
                                  ),
                                  TextFormField(
                                    cursorColor: Colors.purple.shade200,
                                    // ignore: deprecated_member_use
                                    validator: (value) {
                                      if (!value.isEmail()) {
                                        return "error ";
                                      }
                                    },
                                    onSaved: (value) {
                                      updatedMail = value;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "new Mail",
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.purple.shade200)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.purple.shade200)),
                                    ),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      updateMail();
                                    },
                                    color: Colors.purple.shade200,
                                    child: Text("Update"),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      back();
                                    },
                                    color: Colors.purple.shade200,
                                    child: Text("Done"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
              },
              color: Colors.purple.shade200,
              child: Text("update mail address"),
            )
          ],
        ),
      ),
    );
  }

  void createUser() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        UserCredential userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: mail, password: pass);
        User _user = userCredential.user;
        await _user.sendEmailVerification();
        if (_firebaseAuth.currentUser != null) {
          await _firebaseAuth.signOut();
        }
      } catch (e) {
        debugPrint(e);
      }
    }
  }

  void signOut() async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.signOut();
    }
  }

  void signIn() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (_firebaseAuth.currentUser == null) {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: mail, password: pass);
        if (_firebaseAuth.currentUser.emailVerified) {
          debugPrint("user verified mail");
        } else {
          _firebaseAuth.signOut();
        }
      } else {
        _firebaseAuth.signOut();
      }
    }
  }

  void resetPass() async {
    formKey.currentState.save();
    await _firebaseAuth.sendPasswordResetEmail(email: mail);
  }

  void updateMail() async {
    if (_firebaseAuth.currentUser != null) {
      if (formKey1.currentState.validate()) {
        formKey1.currentState.save();
        //hesapda açık olan mail ve pass
        EmailAuthCredential emailAuthCredential =
            EmailAuthProvider.credential(email: mailU, password: passU);
        await FirebaseAuth.instance.currentUser
            .reauthenticateWithCredential(emailAuthCredential);
        await _firebaseAuth.currentUser.updateEmail(updatedMail);
        await _firebaseAuth.currentUser.sendEmailVerification();
        if (_firebaseAuth.currentUser.emailVerified) {
          debugPrint("user verified mail");
          Navigator.pop(context);
        } else {
          debugPrint("You have to verified your new mail");
          await _firebaseAuth.signOut();
        }
      }
    }
  }

  void back() async {
    Navigator.pop(context);
  }
}
