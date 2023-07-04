import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class auth {

  Future signInWithEmailAndPassword(String emailAddress, String password) async {
    String result = 'Not Logged In';
    try {
  final credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  print('success');
  result = 'success';
}
 on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
    Fluttertoast.showToast(
        msg: "User not found",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Color.fromARGB(255, 240, 194, 190),
        textColor: Colors.white,
        fontSize: 16.0
    );
  } else if (e.code == 'wrong-password') {
print('Wrong password provided for that user.');
Fluttertoast.showToast(
        msg: "Wrong password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Color.fromARGB(255, 240, 194, 190),
        textColor: Colors.white,
        fontSize: 16.0
    );

  } 
  
}  
return result;
    }


  Future createUserWithEmailAndPassword(String emailAddress, String password) async{
    String result = 'Not logged In';
    try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  print("success");
  result = 'success';
  print(result);
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    Fluttertoast.showToast(
        msg: "Password is too weak",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Color.fromARGB(255, 240, 194, 190),
        textColor: Colors.white,
        fontSize: 16.0
    );
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    Fluttertoast.showToast(
        msg: "Account already exists",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Color.fromARGB(255, 240, 194, 190),
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
} catch (e) {
  print(e);

}
return result;
  }




  CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser(String fullName, String emailAddress) {
      // Call the user's CollectionReference to add a new user
      return users
      .doc(emailAddress)
          .set({
            'fullName': fullName, 
            'email': emailAddress, 
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
}
    