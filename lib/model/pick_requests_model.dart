class PickRequestsModel {
  String? orderID;
  String? firstNameSender;
  String? lastNameSender;
  String? addressSender;
  String? availability;
  String? contactNoSender;
  String? itemDescription;
  String? itemType;
  String? weight;
  String? size;
  String? distance;
  String? firstNameReceiver;
  String? lastNameReceiver;
  String? addressReceiver;
  String? contactNoReceiver;
  String? status;

  PickRequestsModel(
      {this.orderID,
      this.firstNameSender,
      this.lastNameSender,
      this.addressSender,
      this.availability,
      this.contactNoSender,
      this.itemDescription,
      this.itemType,
      this.weight,
      this.size,
      this.distance,
      this.firstNameReceiver,
      this.lastNameReceiver,
      this.addressReceiver,
      this.contactNoReceiver,
      this.status});

  // data from server
  factory PickRequestsModel.fromMap(map) {
    return PickRequestsModel(
        orderID: map['orderID'],
        firstNameSender: map['firstNameSender'],
        lastNameSender: map['lastNameSender'],
        addressSender: map['addressSender'],
        availability: map['availability'],
        contactNoSender: map['contactNoSender'],
        itemDescription: map['itemDescription'],
        itemType: map['itemType'],
        weight: map['weight'],
        size: map['size'],
        distance: map['distance'],
        firstNameReceiver: map['firstNameReceiver'],
        lastNameReceiver: map['lastNameReceiver'],
        addressReceiver: map['addressReceiver'],
        contactNoReceiver: map['contactNoReceiver'],
        status: map['status']);
  }

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'orderID': orderID,
      'firstNameSender': firstNameSender,
      'lastNameSender': lastNameSender,
      'addressSender': addressSender,
      'availability': availability,
      'contactNoSender': contactNoSender,
      'itemDescription': itemDescription,
      'itemType': itemType,
      'weight': weight,
      'size': size,
      'distance': distance,
      'firstNameReceiver': firstNameReceiver,
      'lastNameReceiver': lastNameReceiver,
      'addressReceiver': addressReceiver,
      'contactNoReceiver': contactNoReceiver,
      'status': status,
    };
  }
}
