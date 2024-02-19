import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../shared/constants.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  Register({super.key, this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email='';
  String password='';
  String error='';
  //switch to loading screen
  bool loading=false;

  final _formKey= GlobalKey<FormState>();

  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Sign Up in Brew Crew'),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            onPressed: (){
              widget.toggleView!();
            },
            label: Text('Sign In'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter your Email': null,
                onChanged: (val){
                  setState(() => email=val);
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Password should be 6+ letters': null,
                onChanged: (val){
                  setState(()=> password=val);
                },
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() => loading=true);
                    dynamic result=await _auth.registerWithEmailAndPassword(email,password);
                    if(result==null){
                      setState(() {
                        error= 'There is some error';
                        loading = false;
                      });
                    }
                  }
                },
                child: Text('Register'),
              ),
              SizedBox(height: 20.0,),
              Text(
                error,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
