import 'package:cloud_firestore/cloud_firestore.dart';

class ConnectModel {
  String? lawyerID;
  String? userID;

  ConnectModel({this.lawyerID, this.userID});

  ConnectModel.fromJson(Map<String, dynamic> json) {
    lawyerID = json['senderID'];
    userID = json['recieverID'];
  }
  static ConnectModel formDocumentSnapshot(DocumentSnapshot snapshot) {
    return ConnectModel(
        lawyerID: snapshot['senderID'], userID: snapshot['recieverID']);
  }

  Map<String, dynamic> toMap() {
    return {
      'recieverID': lawyerID,
      'senderID': userID,
    };
  }
}
