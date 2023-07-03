import 'package:e_commerce/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import '../services/auth.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {

    ValueNotifier _loginStatus = ValueNotifier('Not Logged In');
    var AUTH = auth();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _name = TextEditingController();


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 110, 84, 84),
      body: SafeArea(
        child: Center(
          child: Container(
             padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: SingleChildScrollView(
              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const SizedBox(height: 100),
                          Lottie.asset('assets/lotties/loads.json'),
                          TextField(
                            controller: _name,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                        ),
                        const SizedBox(height: 5,),

                          TextField(
                            controller: _email,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(),
                          labelText: 'E-mail ID',
                        ),
                        ),
                        const SizedBox(height: 5,),
                        TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        ),
                        const SizedBox(height: 15),
                           NeoPopButton(
                          color: const Color.fromARGB(255, 255, 255, 255),
                              onTapUp: () {
                          HapticFeedback.vibrate();},
                        onTapDown: () {
                          HapticFeedback.vibrate();
                         AUTH.createUserWithEmailAndPassword(_email.text, _password.text);
                          AUTH.addUser(_name.text, _email.text);
                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Home()),
                                        );
                          },
                          child: ValueListenableBuilder(
                              valueListenable: _loginStatus,
                              builder: (context, loading, child) {
              return _loginStatus.value == 'Loading'
                  ? const CircularProgressIndicator()
                  : const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text("Login"),
                      ],
                            ),
                        );
                              }),),
                        ]
                        ),
            ),
          ),
        ),
      ),
    );
  }
}