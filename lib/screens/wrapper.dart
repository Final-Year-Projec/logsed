import 'package:logsed/models/user.dart';
import 'package:logsed/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    
    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    }
    else
    {
      return Home();
    }
  }
}