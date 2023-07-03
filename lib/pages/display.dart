import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/product.dart';
import 'home.dart';

class Display extends StatefulWidget {
   Display({super.key, required this.product});
  final Product product;

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(widget.product.imageLink), //image
            Text(widget.product.name), //name
            Text(widget.product.description), //desc
            Text(widget.product.price), //price 
            Row(
              children: [
                IconButton( // shooping cart
                onPressed: () { 
                    FirebaseAuth.instance
              .authStateChanges()
              .listen((User? user) {
                if (user != null) {
                  print(user);
                  String? uid = user.email;
                  print(uid);
                  int id= widget.product.id;
                  user_collection
                  .doc(user.email)
                  .collection('Cart')
                  .doc(id.toString())
                  .set({
                    'Price':widget.product.price,
                    'Name': widget.product.name,
                    'Image': widget.product.imageLink,   
                    'Desc' : widget.product.description,     
                    });
                }
              });
              Fluttertoast.showToast(
          msg: "Added to Cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(255, 240, 194, 190),
          textColor: Colors.white,
          fontSize: 16.0
      );
              }, 
              icon: const Icon(Icons.shopping_cart),
              iconSize: 20,
              alignment: Alignment.bottomLeft,),

              IconButton(
          onPressed: () {
            FirebaseAuth.instance
              .authStateChanges()
              .listen((User? user) {
                if (user != null) {
                  print(user);
                  String? uid = user.email;
                  print(uid);
                  int id= widget.product.id;
                  user_collection
                  .doc(user.email)
                  .collection('Fav')
                  .doc(id.toString())
                  .set({
                    'Price':widget.product.price,
                    'Name': widget.product.name,
                    'Image': widget.product.imageLink,   
                    'Desc' : widget.product.description,      
                    });
                }
              });
              Fluttertoast.showToast(
          msg: "Added to Fav",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(255, 240, 194, 190),
          textColor: Colors.white,
          fontSize: 16.0
      );
          },
        icon: const Icon(Icons.favorite),
        iconSize: 15),
              ],
            ),

          ],
        )),
    );
  }
}