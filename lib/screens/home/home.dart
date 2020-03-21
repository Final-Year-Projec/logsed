import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logsed/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth =AuthService();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
            }, 
            icon: Icon(Icons.person), 
            label: Text('Logout'),
          )
        ],
      ),
    );
  }
}