import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
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
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
return result;
  }




  CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser(String fullName, String emailAddress, List cartItems, List prevOrders) {
      // Call the user's CollectionReference to add a new user
      return users
      .doc(emailAddress)
          .set({
            'fullName': fullName, 
            'email': emailAddress, 
            'cartItems' : cartItems,
            'prevOrders': prevOrders,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
}