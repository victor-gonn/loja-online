import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  Map<String, dynamic> userData = Map();

  void SignIn() {
    isLoading = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 3));
    isLoading = false;
    notifyListeners();
  }

  void signOut() async {
   await _auth.signOut();

   userData = Map();
   
   notifyListeners();
  }

  void SignUp({required Map<String, dynamic> userData, required String pass,
     required VoidCallback onSuccess, required VoidCallback onFailure}) {
    
    
    notifyListeners();

    

    _auth.createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((userCredential) async {
      user = userCredential.user;
      
     

      await _saveUserData(userData);
       onSuccess();
      isLoading = false;
      
      notifyListeners();
    }).catchError((e) {
      onFailure();
      isLoading = false;
      notifyListeners();
    });
  }

  void RecoveryPass()  {
    
  }

  bool isLoggedIn() {
    return user != null;
  }

  Future _saveUserData(Map<String, dynamic> userData, ) async {
      this.userData = userData;
     await FirebaseFirestore.instance.collection('users').doc(user?.uid).set(userData);
    }
}
