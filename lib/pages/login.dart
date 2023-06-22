import 'package:e_commerce/pages/home.dart';
import 'package:e_commerce/services/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/services/auth.dart';

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
    TextEditingController _name = TextEditingController();


    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        // print('User is signed in!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Card(
          child: Column(
            children: [
              TextField(
                controller: _email,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'E-mail ID',
            ),
            ),
            SizedBox(height: 5,),
            TextField(
            controller: _password,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            ),
            SizedBox(height: 5),
              TextButton(
                child: ValueListenableBuilder(
                    valueListenable: _loginStatus,
                    builder: (context, loading, child) {
                      return _loginStatus.value == 'Loading'
                          ? const CircularProgressIndicator()
                          : const Text('Sign IN');
                    }),
                onPressed: () {
                  _loginStatus.value = 'Loading';
                  _loginStatus.value =
                      AUTH.signInWithEmailAndPassword(_email.text, _password.text);
                },
              ),
              SizedBox(height: 10,),
              TextButton(child: ValueListenableBuilder(
                    valueListenable: _loginStatus,
                    builder: (context, loading, child) {
                      return _loginStatus.value == 'Loading'
                          ? const CircularProgressIndicator()
                          : const Text('SIGN UP');
                    }),
                onPressed: () {
                  Card(
                    child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextField(
                                  controller: _name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                              ),
                              ),
                                TextField(
                                  controller: _email,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'E-mail ID',
                              ),
                              ),
                              SizedBox(height: 5,),
                              TextField(
                              controller: _password,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                              ),
                              SizedBox(height: 5),
                                TextButton(
                                  child: ValueListenableBuilder(
                      valueListenable: _loginStatus,
                      builder: (context, loading, child) {
                        return _loginStatus.value == 'Loading'
                            ? const CircularProgressIndicator()
                            : const Text('Sign IN');
                      }),
                                  onPressed: () {
                   _loginStatus.value = 'Loading';
                  _loginStatus.value =
                      AUTH.createUserWithEmailAndPassword(_email.text, _password.text);
                      AddUser(_name.text, _email.text, []);
                                  })]),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}