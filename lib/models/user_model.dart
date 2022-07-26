import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String? userID;
  String? username;
  String? email;
  String? phone;
  bool? lawyer;
  String? category;
  String? yearsExp;
  String? dates;
  int? rate;
  String? photo;
  String? info;
  bool? admin;

  UsersModel(
      {required this.userID,
      required this.email,
      required this.username,
      required this.phone,
      required this.lawyer,
      required this.category,
      required this.yearsExp,
      required this.dates,
      required this.rate,
      required this.photo,
      required this.info,
      required this.admin});

  UsersModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    userID = json['userID'];
    phone = json['phone'];
    lawyer = json['lawyer'];
    category = json['category'];
    yearsExp = json['yearsExp'];
    dates = json['dates'];
    rate = json['rate'];
    photo = json['photo'];
    info = json['info'];
    admin = json['admin'];
  }

  static UsersModel fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UsersModel(
        userID: snapshot['userID'],
        email: snapshot['email'],
        username: snapshot['username'],
        phone: snapshot['phone'],
        lawyer: snapshot['lawyer'],
        category: snapshot['category'],
        yearsExp: snapshot['yearsExp'],
        dates: snapshot['dates'],
        rate: snapshot['rate'],
        photo: snapshot['photo'],
        info: snapshot['info'],
        admin: snapshot['admin']);
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'userID': userID,
      'phone': phone,
      'lawyer': lawyer,
      'category': category,
      'yearsExp': yearsExp,
      'dates': dates,
      'rate': rate,
      'photo': photo,
      'info': info,
      'admin': false
    };
  }
}
