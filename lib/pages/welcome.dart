import 'package:e_commerce/pages/authstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 400,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(16),
              child: Lottie.asset('assets/lotties/welcome.json'),
            ),
            const Text('Jomo',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(height: 5,),
            const Text('Your personal stylist', 
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),),
            const SizedBox(height: 10),
            const Text('Discover the latest fashion trends, \nstyles, and products all in one place.',
            style: TextStyle(
              fontSize: 12,
            ),),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),

                child: NeoPopButton(
                  
                  color: Colors.black,
                  onTapUp: () {
                    HapticFeedback.vibrate();
                     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthState()),
                );
                    },
                  onTapDown: () {
                    HapticFeedback.vibrate();
                    },
                     
                  
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text("Explore",
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                ],
                      ),
                  ),
                ), )    
          ],
        ),
      )
    );
  }
}