import 'package:get/get.dart';
import 'package:lawyer/models/frequently_asked_questions.dart';
import 'package:lawyer/services/firestore_db.dart';

class FrequentlyAskedQuestionController extends GetxController {
  final frequentlyAskedQuestions = <FrequentlyAskedQuestions>[].obs;

  @override
  void onInit() {
    frequentlyAskedQuestions.bindStream(FirestoreDB().getFrequenltyQuestions());
    super.onInit();
  }

  addPopularQUestion({required String question, required String answer}) {
    FirestoreDB().addPopularQUestion(question: question, answer: answer);
  }
}
