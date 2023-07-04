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
      appBar: AppBar(
        title: const Text('Jomo'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 110, 84, 84),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(12),
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.product.imageLink),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
                // Image.asset(widget.product.imageLink), //image
                Text(widget.product.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),), //name
                const SizedBox(height: 7,),
                Text(widget.product.description,
                style: const TextStyle(
                  fontSize: 16
                ),), //desc
                SizedBox(height: 30,),
                Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: Colors.white70,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(20))
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Price: Rs " + widget.product.price,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14
                                      ),),
                      ),
                    ),//price 
                BottomAppBar(
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
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
              backgroundColor: const Color.fromARGB(255, 240, 194, 190),
              textColor: Colors.white,
              fontSize: 16.0
            );
                    },
                    child: const Text('Add to Cart',
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  ),
                  TextButton(onPressed: (){
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
              backgroundColor: const Color.fromARGB(255, 240, 194, 190),
              textColor: Colors.white,
              fontSize: 16.0
            );
                  }, 
                  child: const Text('Add to Fav',
                  style: TextStyle(
                    color: Colors.black
                  ),))
                  ]
                  ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}