import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/pages/fav.dart';
import 'package:e_commerce/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../services/productcontroller.dart';
import 'cart.dart';
import 'display.dart';


CollectionReference user_collection = FirebaseFirestore.instance.collection('users');
 
class Home extends StatelessWidget {
   Home({super.key});
@override
  Widget build(BuildContext context) {

    final ProductController productController = Get.put(ProductController());
    // NavigationService service = NavigationService();

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
                  MaterialPageRoute(builder: (context) =>  Cart()),
              );
                },
              ),
              const SizedBox(width: 10,),
      ],
    ),
  ],
      ),
      body: FutureBuilder(
       future: RemoteServices.fetchProducts(),
       builder: ((context, snapshot) {
         if(snapshot.hasData) {
           return GridView.builder(
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2,
               childAspectRatio: (1 / 1.4),
               ), 
               itemCount: productController.productList.length,
             itemBuilder: (context, index) {
                 return TileView(productController.productList[index], context);
               },);
         } else {
           return Center(
             child: Lottie.asset('assets/lotties/loading.json'),);
         }
         
       })
       
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
              MaterialPageRoute(builder: (context) =>  Cart()),
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

 Widget TileView(Product product, BuildContext context) {
  // NavigationService service = NavigationService();

  return Card(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Image.network(product.imageLink, 
          height: 90,
          width: 90,
          alignment: Alignment.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(product.name, 
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),),
        ),
        Center(
          child: Text("Rs "+ product.price,
              style: const TextStyle(fontWeight: FontWeight.bold,
              fontSize: 10),),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
            // add button for display
            // await Get.to(Display(product: product));
            // Get.off(Display(product: product));
            //  service.routeTo('/screen2', arguments: 'just a test');

            await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  Display(product: product)),
                                        );

            }, child: const Text('More details',
            style: TextStyle(fontSize: 10,
            color: Colors.black))),
            IconButton(
          onPressed: () {
            FirebaseAuth.instance
              .authStateChanges()
              .listen((User? user) {
                if (user != null) {
                  print(user);
                  String? uid = user.email;
                  print(uid);
                  int id= product.id;
                  user_collection
                  .doc(user.email)
                  .collection('Fav')
                  .doc(id.toString())
                  .set({
                    'Price':product.price,
                    'Name': product.name,
                    'Image': product.imageLink,   
                    'Desc' : product.description,
                    'ID': product.id.toString(),     
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
        icon: const Icon(Icons.favorite),
        iconSize: 15),
            IconButton( // shopping cart
              onPressed: () { 
                  FirebaseAuth.instance
            .authStateChanges()
            .listen((User? user) {
              if (user != null) {
                print(user);
                String? uid = user.email;
                print(uid);
                int id= product.id;
                user_collection
                .doc(user.email)
                .collection('Cart')
                .doc(id.toString())
                .set({
                  'Price':product.price,
                  'Name': product.name,
                  'Image': product.imageLink,   
                  'Desc' : product.description, 
                  'ID': product.id.toString(),    
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
            icon: const Icon(Icons.shopping_cart),
            iconSize: 15,
            ),
          ],
        )
      ],
      ),
    );
}