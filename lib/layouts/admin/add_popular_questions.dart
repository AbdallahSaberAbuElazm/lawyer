import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer/controllers/freq_asked_question__controller.dart';
import 'package:lawyer/shared/components/util.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/admin_drawer.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class AddPopularQuestion extends StatefulWidget {
  const AddPopularQuestion({Key? key}) : super(key: key);

  @override
  State<AddPopularQuestion> createState() => _AddPopularQuestionState();
}

class _AddPopularQuestionState extends State<AddPopularQuestion> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final FrequentlyAskedQuestionController _frequentlyAskedQuestionController =
      Get.find();

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'الأسئلة الشائعة',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: mainColor,
          elevation: 0.0,
        ),
        drawer: AdminDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'أضف السؤال الي الاسئلة الشائعة',
                        style: TextStyle(color: mainColor, fontSize: 24),
                      ),
                    ),
                    addQuestion(
                        textController: _questionController, hint: 'السؤال'),
                    addQuestion(
                        textController: _answerController, hint: 'الإجابة'),
                    const SizedBox(
                      height: 10,
                    ),
                    _addButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addQuestion(
      {required TextEditingController textController, required String hint}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hint,
                style: TextStyle(color: mainColor, fontSize: 20),
              ),
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                color: Colors.white,
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.1),
                margin: const EdgeInsets.only(bottom: 9, top: 8),
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      fillColor: mainColor,
                      focusColor: mainColor,
                      hoverColor: mainColor,
                      iconColor: mainColor),
                  minLines: 5,
                  cursorColor: mainColor,
                  style: Theme.of(context).textTheme.bodyText1,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _addButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 21),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            _frequentlyAskedQuestionController.addPopularQUestion(
                question: _questionController.text,
                answer: _answerController.text);
            _questionController.text = '';
            _answerController.text = '';
            Utils.snackBar(context: context, msg: 'تم اضافة السؤال');
          },
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.only(right: 15, left: 10)),
              backgroundColor: MaterialStateProperty.all(mainColor),
              alignment: Alignment.center),
          child: Text(
            'أضف إلي الأسئلة الشائعة',
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
