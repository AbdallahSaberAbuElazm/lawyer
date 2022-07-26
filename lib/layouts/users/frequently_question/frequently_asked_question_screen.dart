import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyer/controllers/freq_asked_question__controller.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';
import 'package:lawyer/shared/widgets/user_drawer.dart';

class FrequentlyAskedQuestionScreen extends StatefulWidget {
  const FrequentlyAskedQuestionScreen({Key? key}) : super(key: key);

  @override
  State<FrequentlyAskedQuestionScreen> createState() =>
      _FrequentlyAskedQuestionScreenState();
}

class _FrequentlyAskedQuestionScreenState
    extends State<FrequentlyAskedQuestionScreen> {
  late List filteredLocation;
  late List list;
  final _searchController = TextEditingController();

  @override
  void initState() {
    list =
        Get.find<FrequentlyAskedQuestionController>().frequentlyAskedQuestions;
    setState(() {
      filteredLocation = list;
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  //filter location
  void _filterLocation(value) {
    setState(() {
      filteredLocation = list
          .where((question) => question.questionName.contains(value))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    ScreenUtil.init(context,
        // BoxConstraints(
        //   maxWidth: MediaQuery.of(context).size.width,
        //   maxHeight: MediaQuery.of(context).size.height,
        // ),
        designSize: Size(width, height),
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'الاسئلة الشائعة',
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            drawer: UserDrawer(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 9),
                    child: Container(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      width: double.infinity,
                      height: 55,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          _filterLocation(value);
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.black)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.black)),
                          fillColor: Colors.black,
                          focusColor: Colors.black,
                          hoverColor: Colors.black,
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      filteredLocation = list;
                                      _searchController.text = '';
                                    });
                                  },
                                )
                              : null,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: ' إبحث هنا ',
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: ListView.builder(
                          itemCount: filteredLocation.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 6, top: 6),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                color: Colors.white70.withOpacity(0.5),
                              ),
                              child: ExpansionTile(
                                iconColor: Colors.black,
                                title: Text(
                                    filteredLocation[index].questionName,
                                    style: TextStyle(fontSize: 18.sp)),
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      right: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white70.withOpacity(0.5),
                                    ),
                                    child: Text(
                                        filteredLocation[index].questionAnswer,
                                        style: TextStyle(fontSize: 17.sp)),
                                  ),
                                ],
                              ),
                            );
                          })),
                ],
              ),
            )));
  }
}
