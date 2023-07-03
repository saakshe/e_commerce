import 'package:e_commerce/pages/welcome.dart';
import 'package:e_commerce/routes/navigation_service.dart';
import 'package:e_commerce/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // debugShowCheckedModeBanner: true,
      // onGenerateRoute: RouteGenerator.generateRoutes,
      // initialRoute: '/',
      // navigatorKey: NavigationService().navigatorKey,
      home: Welcome()
    );
  }
}