import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pickandgo/View/home.dart';
import 'package:pickandgo/model/confirm_order_model.dart';
import 'package:pickandgo/ui/image_upload_screen.dart';

import 'home_screen.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({Key? key}) : super(key: key);

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  final _auth = FirebaseAuth.instance;
  //form key
  final _fromKey = GlobalKey<FormState>();
  //editing controller
  final orderIDEditingController = TextEditingController();

  var Fluttertoast;

  @override
  Widget build(BuildContext context) {
    // orderID filed
    final orderIDField = TextFormField(
      autofocus: false,
      controller: orderIDEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regex = RegExp(r'^.{5,}$');
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
          prefixIcon: const Icon(
            Icons.confirmation_number,
            color: Color(0xffF5591F),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Order ID",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //confirm button
    final confirmButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xffF5591F),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          postDetailsToFirestore();
        },
        child: const Text(
          "Confirm",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xffffffff)),
          onPressed: () {
            Navigator.of(context).pop();
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
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _fromKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 100,
                      child: Text(
                        "Confirm Order Here",
                        style: TextStyle(
                            color: Color(0xffF5591F),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 45),
                    orderIDField,
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageUpload()));
                        },
                        child: const Text("Upload")),
                    const SizedBox(height: 20),
                    confirmButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //confirm order function
  //void confirm() async {
  //if (_fromKey.currentState!.validate()) {
  //await _auth
  //.createUserWithEmailAndPassword(email: email, password: password)
  //.then((value) => {postDetailsToFirestore()})
  //.catchError((e) {
  //Fluttertoast.showToast(msg: e.message);
  //});
  //}
  //}

  //post details function
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    ConfirmOrderModel confirmOrderModel = ConfirmOrderModel();

    confirmOrderModel.orderID = orderIDEditingController.text;
    confirmOrderModel.status = "Delivered";
    confirmOrderModel.time = DateTime.now();

    await firebaseFirestore
        .collection("confirmed_orders")
        .doc(user!.uid)
        .set(confirmOrderModel.toMap());
    Fluttertoast.showToast(msg: "Order confirmation successful");

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}
