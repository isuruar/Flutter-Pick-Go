import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  final _auth = FirebaseAuth.instance;
  //form key
  final _fromKey = GlobalKey<FormState>();
  //editing controller
  final orderIDEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // orderID filed
    final orderIDField = TextFormField(
      autofocus: false,
      controller: orderIDEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{5,}$');
        if (value!.isEmpty) {
          return ("Please check order ID");
        }
        if (!regex.hasMatch(value)) {
          return (" ");
        }
        return null;
      },
      onSaved: (value) {
        orderIDEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.confirmation_number,
            color: Color(0xffF5591F),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter your tracking code",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    return Container();
  }

  loadOrderStatus() async {}
}
