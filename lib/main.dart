import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pickandgo/ui/confirm_order_screen.dart';
import 'package:pickandgo/ui/image_upload_screen.dart';
import 'package:pickandgo/ui/login_screen.dart';
import 'package:pickandgo/ui/signup_screen.dart';

import 'View/delivery_charges.dart';
import 'View/home.dart';
import 'View/pick_requests.dart';
import 'View/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pick&GO',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        'login': (context) => LoginScreen(),
        'signup': (context) => SignUpScreen(),
        'home': (context) => Home(),
        'pickrequests': (context) => PickRequests(),
        'deliverycharges': (context) => DeliveryCharges(),
        'receiveditems': (context) => ConfirmOrder(),
        'imageupload': (context) => ImageUpload(),
      },
    );
  }
}
