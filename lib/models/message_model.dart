class MessageModel {
  String? dateTime;
  String? recieveID;
  String? senderID;
  String? message;

  MessageModel({this.dateTime, this.recieveID, this.senderID, this.message});

  MessageModel.fromJson(Map<String, dynamic> json) {
    recieveID = json['recieveID'];
    senderID = json['senderID'];
    message = json['message'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'recieveID': recieveID,
      'senderID': senderID,
      'message': message,
      'dateTime': dateTime,
    };
  }
}
