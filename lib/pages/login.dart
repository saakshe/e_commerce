import 'package:e_commerce/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {

    ValueNotifier _loginStatus = ValueNotifier('Not Logged In');
    var AUTH = auth();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();

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
                  Lottie.asset('assets/lotties/login.json'),
                  TextField(
                    controller: _email,
                decoration: InputDecoration(
                  filled: true,
                          fillColor: Colors.white70,
                  border: OutlineInputBorder(
                  
                    borderRadius: BorderRadius.circular(10.0),
                    
                  ),
                  labelText: 'E-mail ID',
                ),
                ),
                const SizedBox(height: 5,),
                TextField(
                controller: _password,
                obscureText: true,
                decoration:  InputDecoration(
                  filled: true,
                          fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Password',
                ),
                ),
                const SizedBox(height: 5),

                  NeoPopButton(
                    color: const Color.fromARGB(255, 255, 255, 255),
                        onTapUp: () {
                    HapticFeedback.vibrate();},
                  onTapDown: () {
                    HapticFeedback.vibrate();
                   _loginStatus.value =  AUTH.signInWithEmailAndPassword(_email.text, _password.text);
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


                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a memeber?', 
                      style: TextStyle(
                        color: Colors.white70,
                      ),),
                      const SizedBox(width: 5,),
                      TextButton(
                    child: const Text('Join now'),
                    onPressed: () {
                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const SignIn()),
                                        );
                    },
                  ),
                    ],
                  )
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}