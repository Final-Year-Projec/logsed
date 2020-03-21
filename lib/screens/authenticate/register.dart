import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logsed/services/auth.dart';
import 'package:logsed/shared/loading.dart';

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

  // Spinner
  bool loading = false;

  // Text Field State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
        padding: EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    textInputAction: TextInputAction.none,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        // hintText: 'Enter your product title',
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: 'Email Address'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                   setState(() => email = val);
               },
                  ),
                  ),
                  SizedBox(
                  height: 25,
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      // hintText: 'Enter your product description',
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Password'),
                  // Validation
                 validator: (val) => val.length < 6 ? 'Enter an password for 6 characters long' : null,
                 onChanged: (val) {
                   setState(() => password = val);
                 },
                ),
                // GestureDetector(
                //   onTap: () {
                    
                //   },
                //   child: Container(
                //     alignment: Alignment.centerRight,
                //     margin: EdgeInsets.only(top: 25, right: 5),
                //     child: Text(
                //       'Forgot Password ?',
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // ),

                // SwitchListTile(
                //   title: Text('I accept the Terms & Conditions'),
                //   value: _acceptTerms,
                //   onChanged: (bool value) {
                //     setState(() {
                //       _acceptTerms = value;
                //     });
                //   },
                // ),
                SizedBox(
                  height: 25,
                ),
                FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(color: Colors.black)),
                  padding: EdgeInsets.only(left: 50, right: 50),
                  // color: Theme.of(context).buttonColor,
                  textColor: Colors.black,
                  child: Text('Login'),
                  onPressed: () async {
                  // Validate the form by evaluating it
                  if (_formkey.currentState.validate()) {
                    // Spinner to appear
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    // check if null
                    if (result == null) {
                      setState(() {
                         error = 'Please recheck all your credentials';
                        loading = false; // spinner to not appear
                      });
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
              ),
              
              Text('OR'),
              SizedBox(
                height: 20,
              ),
              Container(
                child: OutlineButton(
                  splashColor: Colors.grey,
                  onPressed: () {
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  highlightElevation: 0,
                  borderSide: BorderSide(color: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.0,),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RichText(
                      text: new TextSpan(
                        children: [
                          new TextSpan(
                            text: "Already have an account?",
                            style: TextStyle(color: Colors.grey[300]),
                          ),
                          new TextSpan(
                            text: "Click Here!",
                            style: TextStyle(color: Colors.black87),
                            recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              widget.toggleView();
                            }
                          )
                        ]
                      ) 
                    ),
                  ],
                ),
              )
                ],
              ),
            ),
          ),
        ),
        // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        // child: Form(
        //   key: _formkey, // Associating global key with the form key
        //   child: Column(
        //     children: <Widget>[
        //       // For email
        //       SizedBox(height: 20.0,), // Creates Space between
        //       TextFormField(
        //         // Validation
        //         validator: (val) => val.isEmpty ? 'Enter an email' : null,
        //         onChanged: (val) {
        //           setState(() => email = val);
        //         },
        //       ),
        //       // For password
        //       SizedBox(height: 20.0,), // Creates Space between
        //       TextFormField(
        //         obscureText: true,
        //         // Validation
        //         validator: (val) => val.length < 6 ? 'Enter an password for 6 characters long' : null,
        //         onChanged: (val) {
        //           setState(() => password = val);
        //         },
        //       ),
        //       // Sign in button
        //       SizedBox(height: 20.0,), // Creates Space between
        //       RaisedButton(
        //         color: Colors.pink[400],
        //         child: Text(
        //           'Sign Up',
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //         onPressed: () async {
        //           // Validate the form by evaluating it
        //           if (_formkey.currentState.validate()) {
        //             dynamic result = await _auth.registerWithEmailAndPassword(email, password);
        //             // check if null
        //             if (result == null) {
        //               setState(() => error = 'Please recheck all your credentials');
        //             }
        //             // Automatically on success goes on home due to STREAM
        //           }
        //         },
        //       ),
        //       SizedBox(height: 20.0,), // Creates Space between
        //       // ERROR MESSAGES when result is null
        //       Text(
        //         error,
        //         style: TextStyle(
        //           color: Colors.red,
        //           fontSize: 14.0, 
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}