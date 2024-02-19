import 'package:brewcrew/screens/authenticate/authenticate.dart';
import 'package:brewcrew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/userUid.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //getting the stream data from the provider
    final user=Provider.of<UserUid?>(context);

    print(user);
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
