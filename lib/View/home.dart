import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pickandgo/View/pick_requests.dart';
import 'package:pickandgo/ui/confirm_order_screen.dart';
import 'package:pickandgo/ui/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickandgo/ui/track_order_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 20,
    ),
    fixedSize: const Size(250, 80),
    primary: Colors.orange.shade700,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('images/menuimage.png'),
                      fit: BoxFit.cover)),
              child: null,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.article,
                color: Colors.deepOrange,
              ),
              title: const Text(
                'Pick Requests',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.deepOrange),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PickRequests()),
                ); //
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.add_location_alt,
                color: Colors.deepOrange,
              ),
              title: const Text(
                'Track',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.deepOrange),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const TrackOrder();
                    },
                  ),
                );

                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.markunread_mailbox_rounded,
                color: Colors.deepOrange,
              ),
              title: const Text(
                'Received Items',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.deepOrange),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ConfirmOrder();
                    },
                  ),
                );

                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade700,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              logOut();
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Image(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1607227063002-677dc5fdf96f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80')),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const PickRequests();
                  },
                ),
              );
            },
            child: const Text('Pick Requests'),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return BodyStretchingSchedule1();
              //     },
              //   ),
              // );
            },
            child: const Text('Track'),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ConfirmOrder();
                  },
                ),
              );
            },
            child: const Text('Received Items'),
          ),
        ],
      ),
    );
  }

  //logout function
  Future logOut() async {
    return await _auth
        .signOut()
        .then((uid) => {
              Fluttertoast.showToast(msg: "Logout Successful"),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen())),
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);

      // return null;
    });
  }
}
