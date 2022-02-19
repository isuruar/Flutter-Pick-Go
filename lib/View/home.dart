import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickandgo/View/pick_requests.dart';
import 'package:pickandgo/ui/confirm_order_screen.dart';
import 'package:pickandgo/ui/login_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  image: const DecorationImage(
                      image: AssetImage('images/menuimage.png'),
                      fit: BoxFit.cover)),
              child: null,
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
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
              leading: Icon(
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
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) {
              //         return PilateSchedule();
              //       },
              //     ),
              //   );
              //
              //   // Update the state of the app.
              //   // ...
              // },
            ),
            ListTile(
              leading: Icon(
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
                      return ConfirmOrder();
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
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade700,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              ); // do something
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          Image(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1607227063002-677dc5fdf96f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80')),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PickRequests();
                  },
                ),
              );
            },
            child: const Text('Pick Requests'),
          ),
          SizedBox(
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
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ConfirmOrder();
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
}
