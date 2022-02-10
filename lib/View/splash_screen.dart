import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var status = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
    Future.delayed(Duration(seconds: 5), () {
      if (status) {
        Navigator.pushNamed(context, 'home');
      } else {
        Navigator.pushNamed(context, 'login');
      }
    });
  }

  checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('uid');
    if (uid != null) {
      status = true;
    } else {
      status = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade700,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: AssetImage(
                'images/logo.png',
              ),
              height: 500,
              width: 400,
            ),
          ],
        ),
      ),
    );
  }
}
