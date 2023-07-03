import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jomo: Cart'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 110, 84, 84),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              children: [
                
                Display(),
                                ],
                              ),
                            ),
                          ],
      ),
    );
  }
  Widget Display() {
    return Card(
      child: Text('hiiiiiiiiiiiii'),
    );
  }
}