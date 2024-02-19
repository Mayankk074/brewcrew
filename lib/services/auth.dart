import 'package:firebase_auth/firebase_auth.dart';

import '../models/userUid.dart';
import 'database.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;

  //Creating User instance based on FirebaseUser
  UserUid? _userUidFromUser(User? user){
    return user != null ? UserUid(uid: user.uid):null;
  }

  //Auth change user stream
  Stream<UserUid?> get user{
    return _auth.authStateChanges()
        .map(_userUidFromUser);
  }

  // SignIn anon
  Future signInAnon() async {
    try{
      UserCredential result=await _auth.signInAnonymously();
      User? user=result.user;
      return _userUidFromUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  //SignIn with Email and Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      return _userUidFromUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Register
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      //create new doc for user with uid
      await DatabaseService(uid: user?.uid).updateUserData('0', 'new crew member', 100);
      return _userUidFromUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //SignOut
  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }
}