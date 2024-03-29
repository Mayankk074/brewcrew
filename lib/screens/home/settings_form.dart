import 'package:brewcrew/models/userUid.dart';
import 'package:brewcrew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:provider/provider.dart';

import '../../shared/loading.dart';


class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey=GlobalKey<FormState>();

  final List<String> sugars=['0','1','2','3','4'];

  //form Values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserUid?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user?.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData? userData=snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Update your brew settings',style: TextStyle(fontSize: 18.0),),
                TextFormField(
                  initialValue: userData?.name,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Enter a name' : null,
                  onChanged: (val) => setState(() => _currentName=val ) ,
                ),
                const SizedBox(height: 20.0,),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData?.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugar(s)'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars=val),
                ),
                //slider
                Slider(
                  value: (_currentStrength ?? userData?.strength)!.toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData!.strength!],
                  inactiveColor: Colors.brown[_currentStrength ?? userData!.strength!],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentStrength=val.round()),
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      await DatabaseService(uid: user?.uid).updateUserData(
                        _currentSugars ?? userData!.sugars!,
                        _currentName ?? userData!.name!,
                        _currentStrength ?? userData!.strength!
                      );
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          );
        }else{
          return const Loading();
        }
      }
    );
  }
}
