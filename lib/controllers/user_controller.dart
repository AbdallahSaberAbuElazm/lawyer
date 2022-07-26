import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lawyer/models/connect_model.dart';
import 'package:lawyer/models/user_model.dart';
import 'package:lawyer/services/firestore_db.dart';

class UserController extends GetxController {
  var user = <UsersModel>[].obs;
  var lawyers = <UsersModel>[].obs;
  var connectList = <ConnectModel>[].obs;
  var allUsers = <UsersModel>[].obs;
  var numOfLawyers = 0.obs;
  var numOfAdmins = 0.obs;

  @override
  onInit() {
    allUsers.bindStream(FirestoreDB().getAllUsers());
    print('all users is ${allUsers.length}');
    super.onInit();
  }

  getUserData({required String senderId}) async {
    user[0] = await FirestoreDB().getSenderChatUsingId(senderId: senderId);
    update();
  }

  getChatForLawyer() async {
    connectList.bindStream(FirestoreDB().getChatForLawyer());
  }

  getUserChatsWithLawyer() async {
    user.value = [];
    for (int i = 0; i < connectList.length; i++) {
      user.add(await FirestoreDB()
          .getSenderChatUsingId(senderId: connectList[i].userID.toString()));
    }
    update();
  }

  getAllLawyer() {
    lawyers.bindStream(FirestoreDB().getAllLawyers());
  }
}
