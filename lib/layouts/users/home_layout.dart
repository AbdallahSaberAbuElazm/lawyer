import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyer/controllers/user_controller.dart';
import 'package:lawyer/layouts/users/chat/chat_screen.dart';
import 'package:lawyer/layouts/users/laywer_search/lawyer_search.dart';
import 'package:lawyer/layouts/users/user_problems/user_problem.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/components/constants.dart';
import 'package:lawyer/shared/network/local/cashe_helper.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';
import 'package:lawyer/shared/widgets/user_drawer.dart';
import 'LegalTexts/legal_texts.dart';
import 'package:lawyer/shared/components/util.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final UserController _userController = Get.find<UserController>();
  @override
  void initState() {
    _userController.getChatForLawyer();

    super.initState();
    userID = CasheHelper.getData(key: 'uID').toString();
  }

  Future<bool> _onWillPop() async {
    return (await Utils.showDialogOnWillPop(context: context)) ?? false;
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
    return Directionality(
        textDirection: TextDirection.rtl,
        child: WillPopScope(
            onWillPop: _onWillPop,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                drawer: UserDrawer(),
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Lawyer Online',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        navigateTo(context, const ChatScreen());
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
                  backgroundColor: mainColor,
                  elevation: 0.0,
                ),
                body: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultButton(
                            function: () {
                              navigateTo(context, const LawyerSearch());
                            },
                            background: mainColor,
                            text: 'ابدا استشارتك مع محامي الان',
                            textColor: Colors.white,
                            textFontSize: 20.sp,
                            width: 300.w,
                            height: 60.h),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultButton(
                            function: () {
                              navigateTo(context, LegalTextsScreen());
                            },
                            background: mainColor,
                            text: 'نصوص ومواد قانونية',
                            textColor: Colors.white,
                            textFontSize: 20.sp,
                            width: 300.w,
                            height: 60.h),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultButton(
                            function: () {
                              navigateTo(context, UserProblems());
                            },
                            background: mainColor,
                            text: 'اعرض مشكلتك الان',
                            textColor: Colors.white,
                            textFontSize: 20.sp,
                            width: 300.w,
                            height: 60.h),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
