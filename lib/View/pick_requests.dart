import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pickandgo/model/pick_requests_model.dart';
import 'package:pickandgo/model/user_model.dart';

import 'delivery_charges.dart';
import 'home.dart';

class PickRequests extends StatefulWidget {
  const PickRequests({Key? key}) : super(key: key);

  @override
  _PickRequestsState createState() => _PickRequestsState();
}

class _PickRequestsState extends State<PickRequests> {
  // late String _selectedValue;
  final items = [
    'Clothing',
    'Electronic Items',
    'Documents',
    'Dry Food',
    'Metal Items',
    'Other'
  ];

  String dropdownvalue = 'Documents';

  final weight = [
    '1-5kg',
    '5-10kg',
    'More than 10kg',
  ];

  String dropdownvalueweight = '1-5kg';

  final size = [
    '<10inches',
    '<20inches',
    '>20inches',
  ];

  String dropdownvaluesize = '<10inches';

  final distance = [
    '<5km',
    '<15km',
    '>15km',
  ];

  String dropdownvaluedistance = '<5km';

  DateTime? dateTime;

  String? get orderID => null;

  String? get id => null;

  String getText() {
    if (dateTime == null) {
      return 'Select Availability';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime!);
    }
  }

  final _auth = FirebaseAuth.instance;

  //form key
  final _fromKey = GlobalKey<FormState>();

  //sender details
  final firstNameSenderEditingController = TextEditingController();
  final lastNameSenderEditingController = TextEditingController();
  final addressSenderEditingController = TextEditingController();
  final availabilityEditingController = TextEditingController();

  final contactNoSenderEditingController = TextEditingController();

  //item details
  final itemDescriptionEditingController = TextEditingController();

  //receiver details
  final firstNameReceiverEditingController = TextEditingController();
  final lastNameReceiverEditingController = TextEditingController();
  final addressReceiverEditingController = TextEditingController();
  final contactNoReceiverEditingController = TextEditingController();

  final statusEditingController = TextEditingController();

  // void validateForm() {
  //   final form = _fromKey.currentState;
  //   if (form.validate()) {
  //     print("Form is valid");
  //   } else {
  //     print("Form is invalid");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //sender first name field
    final firstNameSenderField = TextFormField(
      autofocus: false,
      controller: firstNameSenderEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter sender's first name");
        }
        return null;
      },
      onSaved: (value) {
        firstNameSenderEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person,
            color: Color(0xffF5591F),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First name of sender",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //sender last name field
    final lastNameSenderField = TextFormField(
      autofocus: false,
      controller: lastNameSenderEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter sender's last name");
        }
        return null;
      },
      onSaved: (value) {
        lastNameSenderEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person,
            color: Color(0xffF5591F),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last name of sender",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //sender address field
    final addressSenderField = TextFormField(
      autofocus: false,
      controller: addressSenderEditingController,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter sender's address");
        }
        return null;
      },
      onSaved: (value) {
        addressSenderEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.home,
            color: Color(0xffF5591F),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Address of sender",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //availability
    final availabilityField = OutlinedButton.icon(
      onPressed: () {
        pickDateTime(context);
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: Colors.grey,
        minimumSize: const Size.fromHeight(50),
        side: const BorderSide(
          width: 1.0,
          color: Colors.grey,
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      icon: const Icon(
        Icons.calendar_today,
        color: Color(0xffF5591F),
      ),
      label: Text(
        getText(),
      ),
    );

    //sender contact no field
    final contactNoField = TextFormField(
      autofocus: false,
      controller: contactNoSenderEditingController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{10,10}$');
        if (value!.isEmpty) {
          return ("Please enter sender's contact no");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter a number with 10 characters!");
        }
      },
      onSaved: (value) {
        contactNoSenderEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.phone,
            color: Color(0xffF5591F),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contact No",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //item description field
    final itemDescriptionField = TextFormField(
      autofocus: false,
      controller: itemDescriptionEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter item description");
        }
        return null;
      },
      onSaved: (value) {
        itemDescriptionEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.article,
            color: Color(0xffF5591F),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Item Description",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //item type
    final itemTypeField = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
              labelText: 'Select Item Type',
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          isExpanded: true,

          // Initial Value
          value: dropdownvalue,
          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),

          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
          },
        ),
      ),
    );

    //weight
    final itemWeightField = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
              labelText: 'Select Item Weight',
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          isExpanded: true,
          // Initial Value
          value: dropdownvalueweight,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items: weight.map((String weight) {
            return DropdownMenuItem(
              value: weight,
              child: Text(weight),
            );
          }).toList(),

          onChanged: (String? newValue) {
            setState(() {
              dropdownvalueweight = newValue!;
            });
          },
        ),
      ),
    );

    //size
    final itemSizeField = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
              labelText: 'Select Item Size',
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          isExpanded: true,
          // Initial Value
          value: dropdownvaluesize,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items: size.map((String size) {
            return DropdownMenuItem(
              value: size,
              child: Text(size),
            );
          }).toList(),

          onChanged: (String? newValue) {
            setState(() {
              dropdownvaluesize = newValue!;
            });
          },
        ),
      ),
    );

    final itemDistanceField = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
              labelText: 'Select Distance from Colombo',
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          isExpanded: true,
          // Initial Value
          value: dropdownvaluedistance,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items: distance.map((String distance) {
            return DropdownMenuItem(
              value: distance,
              child: Text(distance),
            );
          }).toList(),

          onChanged: (String? newValue) {
            setState(() {
              dropdownvaluedistance = newValue!;
            });
          },
        ),
      ),
    );

    //receiver first name field
    final firstNameReceiverField = TextFormField(
      autofocus: false,
      controller: firstNameReceiverEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter receiver's first name");
        }
        return null;
      },
      onSaved: (value) {
        firstNameReceiverEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person,
            color: Color(0xffF5591F),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First name of receiver",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //receiver first name field
    final lastNameReceiverField = TextFormField(
      autofocus: false,
      controller: lastNameReceiverEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter receiver's last name");
        }
        return null;
      },
      onSaved: (value) {
        lastNameReceiverEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person,
            color: Color(0xffF5591F),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last name of receiver",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //receiver address field
    final addressReceiverField = TextFormField(
      autofocus: false,
      controller: addressReceiverEditingController,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter receiver's address");
        }
        return null;
      },
      onSaved: (value) {
        addressReceiverEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.home,
            color: Color(0xffF5591F),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Address of receiver",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //contact no receiver field
    final contactNoReceiverField = TextFormField(
      autofocus: false,
      controller: contactNoReceiverEditingController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter receiver's contact no");
        }
        return null;
      },
      onSaved: (value) {
        contactNoReceiverEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.phone,
            color: Color(0xffF5591F),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contact No",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //submit button
    final submitButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(12.0),
          ),
          primary: const Color(0xffF5591F),
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
          textStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      onPressed: () {
        if (_fromKey.currentState!.validate()) {
          try {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
            postDetailsToFirestore();
          } catch (e) {
            print("Error: $e");
          }
        }
      },
      child: const Text('Submit'),
    );

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
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _fromKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                      child: Text(
                        "Pick Requests",
                        style: TextStyle(
                            color: Color(0xffF5591F),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Sender Details",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    firstNameSenderField,
                    const SizedBox(height: 20),
                    lastNameSenderField,
                    const SizedBox(height: 20),
                    addressSenderField,
                    const SizedBox(height: 20),
                    //availability
                    availabilityField,
                    const SizedBox(height: 20),
                    contactNoField,
                    const SizedBox(height: 20),
                    const Text(
                      "Item Details",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    itemDescriptionField,
                    const SizedBox(height: 20),
                    itemTypeField,
                    const SizedBox(height: 20),
                    //Weight
                    itemWeightField,
                    const SizedBox(height: 20),
                    //size
                    itemSizeField,
                    const SizedBox(height: 20),
                    //distance
                    itemDistanceField,
                    const SizedBox(height: 20),
                    const Text(
                      "Receiver Details",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    firstNameReceiverField,
                    const SizedBox(height: 20),
                    lastNameReceiverField,
                    const SizedBox(height: 20),
                    addressReceiverField,
                    const SizedBox(height: 20),
                    contactNoReceiverField,
                    const SizedBox(height: 30),
                    submitButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime!.hour, minute: dateTime!.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }

  // //post details function
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    PickRequestsModel pickRequestsModel = PickRequestsModel();

    pickRequestsModel.orderID = orderID;
    pickRequestsModel.firstNameSender = firstNameSenderEditingController.text;
    pickRequestsModel.lastNameSender = lastNameSenderEditingController.text;
    pickRequestsModel.addressSender = addressSenderEditingController.text;
    pickRequestsModel.availability =
        '${dateTime?.day}/${dateTime?.month}/${dateTime?.year}-${dateTime?.hour}:${dateTime?.minute}';
    pickRequestsModel.contactNoSender = contactNoSenderEditingController.text;
    pickRequestsModel.itemDescription = itemDescriptionEditingController.text;
    pickRequestsModel.itemType = dropdownvalue;
    pickRequestsModel.weight = dropdownvalueweight;
    pickRequestsModel.size = dropdownvaluesize;
    pickRequestsModel.distance = dropdownvaluedistance;
    pickRequestsModel.firstNameReceiver =
        firstNameReceiverEditingController.text;
    pickRequestsModel.lastNameReceiver = lastNameReceiverEditingController.text;
    pickRequestsModel.addressReceiver = addressReceiverEditingController.text;
    pickRequestsModel.contactNoReceiver =
        contactNoReceiverEditingController.text;
    pickRequestsModel.status = 'processing';

    await firebaseFirestore
        .collection("orders")
        .doc()
        .set(pickRequestsModel.toMap());

    Fluttertoast.showToast(msg: "Successfully placed pick request");

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DeliveryCharges()),
        (route) => false);
  }
}
