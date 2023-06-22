import 'package:e_commerce/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 110, 84, 84),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 110, 84, 84),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 400,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(16),
              child: Card(
                child: Image.asset('assets/Image.png'),
              ),
            ),
            Text('Jomo',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 5,),
            Text('Your personal stylist', 
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),),
            SizedBox(height: 10),
            Text('Discover the latest fashion trends, \nstyles, and products all in one place.',
            style: TextStyle(
              fontSize: 12,
            ),),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: NeoPopButton(
                
                color: Colors.white,
                onTapUp: () {
                  HapticFeedback.vibrate();
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
                  },
                onTapDown: () => HapticFeedback.vibrate(),
                
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Text("Explore"),
              ],
                    ),
                ),
            ),
            ),
          ],
        ),
      )
    );
  }
}