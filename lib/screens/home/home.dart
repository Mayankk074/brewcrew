import 'package:brewcrew/models/brews.dart';
import 'package:brewcrew/screens/home/settings_form.dart';
import 'package:brewcrew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth=AuthService();

  Home({super.key});

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }


    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[500],
          title: Text('Brew Crew'),
          elevation: 0.0,
          actions: [
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.yellow,
              ),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text(
                  'log Out',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton.icon(
              icon: Icon(
                Icons.settings,
                color: Colors.yellow,
              ),
              label: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
