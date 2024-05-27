import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  Map<String, dynamic> userData = Map();

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
    super.addListener(listener);
    _loadCurrentUser();
  }
  

  void SignIn({required String email, required String pass, required VoidCallback onSuccess,
  required VoidCallback onFailure}) {
    isLoading = true;
    notifyListeners();
    
    _auth.signInWithEmailAndPassword(email: email,
     password: pass).then((userCredential) async {      
      user = userCredential.user;

      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();

     }).catchError((e) {
      isLoading = false;
      onFailure();
      notifyListeners();
     });
  }

  void signOut() async {
   await _auth.signOut();

   userData = Map();
   user = null;
   
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

  void RecoveryPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return user != null;
  }

  Future _saveUserData(Map<String, dynamic> userData) async {
      this.userData = userData;
     await FirebaseFirestore.instance.collection('users').doc(user?.uid).set(userData);
    }

  Future _loadCurrentUser() async{
    user ??= _auth.currentUser;
    if(user != null) {
      if(userData['name'] == null) {
        DocumentSnapshot<Map<String, dynamic>> docUser = 
         await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
        userData = docUser.data()!;
      }
    }
    notifyListeners();
  }
}
