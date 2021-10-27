import 'package:auth/listing.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' show json;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: App(),
  ));
}

class Listing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('New Screen')),
        body: Center(
          child: Text(
            'This is a new screen',
            style: TextStyle(fontSize: 24.0),
          ),
        )
    );
  }
}


class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AppState();
  }
}

class _AppState extends State<App> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GoogleSignInAccount? _currentUser;

  void dialog(msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Alert Dialog Box"),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("okay"),
          ),
        ],
      ),
    );
  }

  void auth() async {
    if (nameController.text.isEmpty) {
      dialog("Please enter username");
    } else if (passwordController.text.isEmpty) {
      dialog("Please enter password");
    } else if (passwordController.text.length < 4) {
      dialog("Password is not proper");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: nameController.text, password: passwordController.text);
        if (userCredential.additionalUserInfo!.isNewUser) {
          dialog("Sucessfully login");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          dialog('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          dialog("The account already exists for that email.");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if(userCredential.additionalUserInfo!.profile!.keys.first.length > 0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> listing()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    // TODO: implement initState
    FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('failed');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print("init");
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text("Hello", textDirection: TextDirection.ltr);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sample App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Text("First Demo App", style: TextStyle(fontSize: 30)),
                      Text("Sign in",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold))
                    ])),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ))),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: TextButton(
                            child: Text('Sign in'),
                            onPressed: auth,
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: TextButton(
                            child: Text('Google Signin'),
                            onPressed: signInWithGoogle,
                          ))
                    ],
                  ),
                )
              ],
            )));
  }
}
