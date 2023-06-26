import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class Fav extends StatefulWidget {
  // String emailAddress;
   Fav({super.key});

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jomo: Favourites'),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}