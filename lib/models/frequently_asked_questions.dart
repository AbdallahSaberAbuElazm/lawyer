import 'package:cloud_firestore/cloud_firestore.dart';

class FrequentlyAskedQuestions {
  String? questionName;
  String? questionAnswer;

  FrequentlyAskedQuestions(
      {required this.questionName, required this.questionAnswer});

  factory FrequentlyAskedQuestions.fromSnapShot(DocumentSnapshot snapshot) {
    return FrequentlyAskedQuestions(
        questionName: snapshot.data().toString().contains('questionName')
            ? snapshot.get('questionName')
            : '',
        questionAnswer: snapshot.data().toString().contains('questionName')
            ? snapshot.get('questionAnswer')
            : '');
  }

  Map<String, dynamic> toMap() {
    return {
      'questionName': questionName,
      'questionAnswer': questionAnswer,
    };
  }
}
