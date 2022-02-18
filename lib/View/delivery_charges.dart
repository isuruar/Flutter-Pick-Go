import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pickandgo/View/pick_requests.dart';
import 'package:pickandgo/model/pick_requests_model.dart';
import 'home.dart';

class DeliveryCharges extends StatefulWidget {
  const DeliveryCharges({Key? key}) : super(key: key);

  @override
  _DeliveryChargesState createState() => _DeliveryChargesState();
}

class _DeliveryChargesState extends State<DeliveryCharges> {
  final _auth = FirebaseAuth.instance;
  //form key
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xffffffff)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PickRequests()),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              ); // do something
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: const <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text("Thank you for your request!",
                      style: TextStyle(
                          color: Color(0xffF5591F),
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text("Tracking code",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 15,
              ),
              // StreamBuilder(
              //     stream: FirebaseFirestore.instance
              //         .collection('orders')
              //         .snapshots(),
              //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //       return ListView(
              //         children: snapshot.data!.docs.map((order){
              //           return Center(
              //             child: ListTile(
              //               title: Text(order.id),
              //             ),
              //           );
              //         }).toList(),
              //       )
              //     }),
              SizedBox(
                height: 30,
              ),
              Text("Charges",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 15,
              ),
              TextField(
                // enabled: false,
                decoration: InputDecoration(
                  // contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Charges",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
