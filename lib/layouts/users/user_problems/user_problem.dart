import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/cubit/states.dart';
import 'package:lawyer/layouts/users/chat/chat_screen.dart';
import 'package:lawyer/layouts/users/user_problems/my_problems.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/components/util.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class UserProblems extends StatefulWidget {
  const UserProblems({Key? key}) : super(key: key);

  @override
  State<UserProblems> createState() => _UserProblemsState();
}

class _UserProblemsState extends State<UserProblems> {
  String? dropDownValue;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    LawyerCubits.get(context).getMyProblems();
  }

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    ScreenUtil.init(context,
        designSize: Size(width, height),
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return BlocConsumer<LawyerCubits, LawyerStates>(
      listener: (context, state) {
        if (state is LawyerMakeProblemSuccessSatets) {
          titleController.text = '';
          descController.text = '';
          dropDownValue = null;
          SnackBar snackBar = const SnackBar(
            content: Text('تم نشر المشكلة بنجاح'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var cubit = LawyerCubits.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('اعرض مشكلتك'),
              actions: [
                InkWell(
                  onTap: () {
                    navigateTo(context, ChatScreen());
                  },
                  child: const Icon(
                    EvaIcons.messageCircleOutline,
                    size: 32,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultTextField(
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'من فضلك ادخل عنوان المشكلة';
                            }
                            return null;
                          },
                          controller: titleController,
                          borderColor: mainColor,
                          hintText: 'عنوان المشكلة'),
                      SizedBox(
                        height: 15.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'التخصص المطلوب',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: DropdownButton(
                                borderRadius: BorderRadius.circular(5),
                                hint: dropDownValue == null
                                    ? const Text('التخصص')
                                    : Text(
                                        dropDownValue.toString(),
                                        style: TextStyle(color: mainColor),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: mainColor),
                                items: Utils.categories.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      alignment: Alignment.topRight,
                                      value: val,
                                      child: Text(
                                        val,
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      dropDownValue = val.toString();
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      defaultTextField(
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'من فضلك ادخل تفاصيل المشكلة';
                            }
                            return null;
                          },
                          controller: descController,
                          maxLength: 8,
                          borderColor: mainColor,
                          hintText: 'تفاصيل المشكلة'),
                      SizedBox(
                        height: 30.h,
                      ),
                      if (state is LawyerMakeProblemLoadingStates)
                        LinearProgressIndicator(
                          color: mainColor,
                        ),
                      if (state is LawyerMakeProblemLoadingStates)
                        SizedBox(
                          height: 30.h,
                        ),
                      defaultButton(
                          background: mainColor,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.makeProblem(
                                  title: titleController.text.trim(),
                                  desc: descController.text.trim(),
                                  category: dropDownValue);
                            } else {
                              print('error');
                            }
                          },
                          height: 50.h,
                          text: 'نشر المشكلة',
                          textColor: Colors.white,
                          width: double.infinity),
                      SizedBox(
                        height: 20.h,
                      ),
                      defaultButton(
                          background: mainColor,
                          function: () {
                            navigateTo(context, MyProblems());
                          },
                          height: 50.h,
                          text: 'مشاكلي',
                          textColor: Colors.white,
                          width: double.infinity),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
