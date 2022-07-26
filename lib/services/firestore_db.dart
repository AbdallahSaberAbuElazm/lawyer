import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lawyer/models/connect_model.dart';
import 'package:lawyer/models/frequently_asked_questions.dart';
import 'package:lawyer/models/user_model.dart';
import 'package:lawyer/shared/widgets/user_shared_preferences.dart';

class FirestoreDB {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //get frequently question
  Stream<List<FrequentlyAskedQuestions>> getFrequenltyQuestions() {
    return _firebaseFirestore
        .collection('frequentlyAskedQuestions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FrequentlyAskedQuestions.fromSnapShot(doc))
            .toList());
  }

  Future<UsersModel> getSenderChatUsingId({required String senderId}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .get()
        .then((doc) => UsersModel.fromDocumentSnapshot(doc));
  }

  Stream<List<ConnectModel>> getChatForLawyer() {
    return _firebaseFirestore
        .collection('chat')
        .doc(
            UserSharedPreferences.getUserId().toString().trimLeft().trimRight())
        .collection('chatRoom')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ConnectModel.formDocumentSnapshot(doc))
            .toList());
  }

  Stream<List<UsersModel>> getAllLawyers() {
    return _firebaseFirestore
        .collection('users')
        .where('lawyer', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UsersModel.fromDocumentSnapshot(doc))
            .toList());
  }

  addPopularQUestion({required String question, required String answer}) async {
    FrequentlyAskedQuestions frequentlyAskedQuestions =
        FrequentlyAskedQuestions(
            questionName: question, questionAnswer: answer);
    await _firebaseFirestore
        .collection('frequentlyAskedQuestions')
        .doc()
        .set(frequentlyAskedQuestions.toMap());
  }

  Stream<List<UsersModel>> getAllUsers() {
    return _firebaseFirestore.collection('users').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => UsersModel.fromDocumentSnapshot(doc))
            .toList());
  }
}
