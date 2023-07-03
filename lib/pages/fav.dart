import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Fav extends StatefulWidget {
  // String emailAddress;
   Fav({super.key});

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> documentStream = FirebaseFirestore.instance.collection('users').doc('emailAddress').collection('Fav').snapshots();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Jomo: Favourites'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 110, 84, 84),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
      stream: documentStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        print('success');
        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          print(data['Name']);
            return ListTile(
          title: Text(data['Name']),
          subtitle: Text(data['Price']),
            );
          }).toList(),
        ); 
        } )
        ],)
    );
  }

}


