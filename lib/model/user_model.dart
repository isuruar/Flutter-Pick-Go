class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? contactNo;
  String? address;
  String? email;

  UserModel(
      {this.uid,
      this.firstName,
      this.lastName,
      this.contactNo,
      this.address,
      this.email});

  // data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        contactNo: map['contactNo'],
        address: map['address']);
  }

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'contactNo': contactNo,
      'address': address
    };
  }
}
