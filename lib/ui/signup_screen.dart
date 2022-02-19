import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pickandgo/model/user_model.dart';
import 'package:pickandgo/ui/confirm_order_screen.dart';
import 'package:pickandgo/ui/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  //form key
  final _fromKey = GlobalKey<FormState>();
  //editing controller
  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final contactNoEditingController = new TextEditingController();
  final addressEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    //first name Field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{5,}$');
        if (value!.isEmpty) {
          return ("Please enter your first name");
        }
        if (!regex.hasMatch(value)) {
          return ("Name need minimum 5 characters");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Color(0xffF5591F),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //last name Field
    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your last name");
        }
        return null;
      },
      onSaved: (value) {
        lastNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Color(0xffF5591F),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //contact num  Field
    final contactNoField = TextFormField(
      autofocus: false,
      controller: contactNoEditingController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{10,}$');
        if (value!.isEmpty) {
          return ("Please enter your contact number");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter a valid number");
        }
      },
      onSaved: (value) {
        contactNoEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.phone,
            color: Color(0xffF5591F),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contact No",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //address Field
    final addressField = TextFormField(
      autofocus: false,
      controller: addressEditingController,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your address");
        }
        return null;
      },
      onSaved: (value) {
        addressEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.home,
            color: Color(0xffF5591F),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //email Field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        //reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
            color: Color(0xffF5591F),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //password Field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter your password");
        }
        if (!regex.hasMatch(value)) {
          return ("Password need minimum 6 characters");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Color(0xffF5591F),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //confirm password Field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return ("Password don't match");
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: Color(0xffF5591F),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xffF5591F),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xffF5591F)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
                    SizedBox(
                      height: 100,
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                            color: Color(0xffF5591F),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 45),
                    firstNameField,
                    SizedBox(height: 20),
                    lastNameField,
                    SizedBox(height: 20),
                    contactNoField,
                    SizedBox(height: 20),
                    addressField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 20),
                    signUpButton,
                    SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //signup function
  void signUp(String email, String password) async {
    if (_fromKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
    }
  }

  //post details function
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.uid = user!.uid;
    userModel.email = user.email;
    userModel.firstName = firstNameEditingController.text;
    userModel.lastName = lastNameEditingController.text;
    userModel.contactNo = contactNoEditingController.text;
    userModel.address = addressEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Succesfully registered");

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}
