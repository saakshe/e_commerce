import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/pages/fav.dart';
import 'package:e_commerce/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../services/productcontroller.dart';
import 'cart.dart';


CollectionReference user_collection = FirebaseFirestore.instance.collection('Users');
 
class Home extends StatelessWidget {
   Home({super.key});

  @override
  Widget build(BuildContext context) {

    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jomo'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 110, 84, 84),
        actions: <Widget>[
    Row(
      children: [
        IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cart()),
              );
                },
              ),
              const SizedBox(width: 10,),
      ],
    ),
  ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child:
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (1 / 1.5),
            ), 
            itemCount: productController.productList.length,
          itemBuilder: (context, index) {
              return TileView(productController.productList[index]);
            },), 
            
      ),
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 110, 84, 84),
        ),
        child: Text('Menu',
        style: TextStyle(color: Colors.white),
        ),
      ),
      ListTile(
        title: const Text('Home'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Home()),
          );
        },
      ),
      ListTile(
        title: const Text('Cart'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Cart()),
            );
        },
      ),
      ListTile(
        title: const Text('Favourites'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Fav()),
            );
        },
      ),
      ListTile(
        title: const Text('Logout'),
        onTap: () {
           FirebaseAuth.instance.signOut();
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
        },
      ),
    ]
  ),
    ),
    );
  }
}

Widget TileView(Product product) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
        onPressed: () {

        },
      icon: const Icon(Icons.favorite),
      iconSize: 15),
      Center(
        child: Image.network(product.imageLink, 
        height: 90,
        width: 90,
        alignment: Alignment.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(product.name, 
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),),
      ),
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(product.price,
            style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(width: 10,),
            IconButton( // shooping cart
              onPressed: () { 
                
            }, 
            icon: const Icon(Icons.shopping_cart),
            iconSize: 20,
            alignment: Alignment.bottomLeft,),
          ],
        ),
      )
    ],
    ),
  );
}