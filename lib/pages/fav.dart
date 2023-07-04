import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'home.dart';



class Fav extends StatefulWidget {
  // String emailAddress;
   Fav({super.key});

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {

  @override
  Widget build(BuildContext context) {

    var emailAddress = FirebaseAuth.instance.currentUser?.email;
    Stream<QuerySnapshot> documentStream = FirebaseFirestore.instance.collection('users').doc(emailAddress).collection('Fav').snapshots();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Jomo: Favourites'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 110, 84, 84),
      ),
      body: StreamBuilder<QuerySnapshot>(
      stream: documentStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
      return const Text('Something went wrong');
        }
      
        if (snapshot.connectionState == ConnectionState.waiting) {
      return Lottie.asset('assets/lotties/loading.json');
        }
        print('success');
        return SingleChildScrollView(
          child: ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
          print(snapshot.data);
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                // print(data['Name']);
          return DisplayFav(data['Name'], data['Price'], data['Image'], data['Desc']);
                }).toList(),
          ),
        ); 
        } )
    );
  }

  Widget DisplayFav(String name, String price, String imageLink, String description) {
    print('success twice');
    return Container(
      height: 120,
      width: 100,
      child: Card(
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(12),
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageLink),
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 40,),
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(name, 
                softWrap: true,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),),
              ),
                              const SizedBox(height: 10,),
            
              Text("Rs "+ price,
                  style: const TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 10),),
                  Center(
                    child: Row(children: [
                              IconButton( // shopping cart
                                onPressed: () { 
                    // print(ID);
                    //               FirebaseAuth.instance
                    //         .authStateChanges()
                    //         .listen((User? user) {
                    //           if (user != null) {
                    //             print(user);
                    //             String? uid = user.email;
                    //             print(uid);
                    //             int id= int.parse(ID);
                    //             user_collection
                    //             .doc(user.email)
                    //             .collection('Cart')
                    //             .doc(id.toString())
                    //             .set({
                    //               'Price':price,
                    //               'Name': name,
                    //               'Image': imageLink,   
                    //               'Desc' : description,     
                    //               'ID': id,
                    //               });
                    //           }
                    //         });
                    //         Fluttertoast.showToast(
                    //     msg: "Added to Cart",
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.BOTTOM,
                    //     timeInSecForIosWeb: 2,
                    //     backgroundColor: const Color.fromARGB(255, 240, 194, 190),
                    //     textColor: Colors.white,
                    //     fontSize: 16.0
                    //   );
                              }, 
                              icon: const Icon(Icons.shopping_cart),
                              iconSize: 15,
                              ),
                              IconButton(
                                onPressed: (){
                                // var emailAddress = FirebaseAuth.instance.currentUser?.email;
                                // final collection = FirebaseFirestore.instance.collection('users');
                                // int id= int.parse(ID);
                                //     collection 
                                //         .doc(emailAddress)
                                //         .collection('Fav')
                                //         .doc(id.toString()) // <-- Doc ID to be deleted. 
                                //         .delete() // <-- Delete
                                //         .then((_) => print('Deleted'))
                                //         .catchError((error) => print('Delete failed: $error'));
                              }, 
                               icon: const Icon(Icons.delete),
        iconSize: 15),
                              ]),
                  ), ]),
            )
          )
        ],
        ),
      ),
    );
  }

}


