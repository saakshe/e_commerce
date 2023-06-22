import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/pages/categories/fav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../services/productcontroller.dart';
import 'cart.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    final ProductController productController = Get.put(ProductController());


    return Scaffold(
      appBar: AppBar(
        title: const Text('Jomo'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 110, 84, 84),
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
        // IconButton(
        //         icon: const Icon(Icons.account_circle_rounded),
        //         onPressed: () {
        //           Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const AccountDetails()),
        //       );
        //         },
        //       ),
              const SizedBox(width: 10,),
      ],
    ),
  ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 50,
            ), 
            itemCount: productController.productList.length,
          itemBuilder: (context, index) {
              return TileView(productController.productList[index]);
            },)
      ),
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 0),
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
              MaterialPageRoute(builder: (context) => const Home()),
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
              MaterialPageRoute(builder: (context) => const Fav()),
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
  return Container(
    height: 500,
    child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(product.imageLink, 
        height: 100,
        width: 100,),
        Text(product.name, 
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),),
        Row(
          children: [
            IconButton(onPressed: () {
  
            }, icon: Icon(Icons.favorite),
            iconSize: 8,), //FAV
            IconButton(onPressed: () {
  
            }, icon: Icon(Icons.shopping_cart),
            iconSize: 8,), //Cart
            // IconButton(onPressed: () {
  
            // }, icon: icon)// learn more
          ],
        )
      ],
      ),
    ),
  );
}