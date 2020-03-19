import 'package:flutter/material.dart';
import 'package:logsed/services/auth.dart';

class Register extends StatefulWidget {

  // For swapping forms
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  // Text Field State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.vpn_key),
            label: Text('Sign In'),
            onPressed: () {
              // access it from constructor above
              widget.toggleView();
            }
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey, // Associating global key with the form key
          child: Column(
            children: <Widget>[
              // For email
              SizedBox(height: 20.0,), // Creates Space between
              TextFormField(
                // Validation
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              // For password
              SizedBox(height: 20.0,), // Creates Space between
              TextFormField(
                obscureText: true,
                // Validation
                validator: (val) => val.length < 6 ? 'Enter an password for 6 characters long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              // Sign in button
              SizedBox(height: 20.0,), // Creates Space between
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  // Validate the form by evaluating it
                  if (_formkey.currentState.validate()) {
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    // check if null
                    if (result == null) {
                      setState(() => error = 'Please recheck all your credentials');
                    }
                    // Automatically on success goes on home due to STREAM
                  }
                },
              ),
              SizedBox(height: 20.0,), // Creates Space between
              // ERROR MESSAGES when result is null
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0, 
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}