import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer/layouts/admin/add_popular_questions.dart';
import 'package:lawyer/layouts/admin/admin_home_page.dart';
import 'package:lawyer/layouts/lawyer/lawyer_layout/lawyer_layout.dart';
import 'package:lawyer/layouts/users/home_layout.dart';
import 'package:lawyer/modules/login/login_screen.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';
import 'package:lawyer/shared/widgets/user_shared_preferences.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String? finalEmail;
  getValidationData() async {
    setState(() {
      finalEmail = UserSharedPreferences.getUseremail();
    });
  }

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(
          const Duration(seconds: 2),
          () => Get.off(() => finalEmail == null
              ? LoginScreen()
              : (UserSharedPreferences.getLawyer() == false)
                  ? (UserSharedPreferences.getIsAdmin() == false)
                      ? const HomeLayout()
                      : AdminHomePage()
                  : LawyerLayout()));
    });

    super.initState();
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
          // appBar: AppBar(
          //   title: Text(
          //     'Lawyer Online',
          //     style: TextStyle(
          //         fontSize: 20.sp,
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold),
          //   ),
          //   backgroundColor: Colors.transparent,
          //   elevation: 0.0,
          // ),
          body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/start.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              ),
            ],
          ),
        ));
  }
}
