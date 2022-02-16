class ConfirmOrderModel {
  String? orderID;
  String? status;
  DateTime? time;

  ConfirmOrderModel({this.orderID, this.status, this.time});

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'orderID': orderID,
      'status': status,
      'time': time,
    };
  }
}
