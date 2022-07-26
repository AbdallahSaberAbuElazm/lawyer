import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/modules/register/lawyer_register.dart';
import 'package:lawyer/modules/register/user_register.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({Key? key}) : super(key: key);

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
            title: Text(
              'Lawyer Online',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: mainColor,
            elevation: 0.0,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'انشاء حساب',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  defaultButton(
                      background: mainColor,
                      function: () {
                        navigateTo(context, const LawyerRegister());
                      },
                      text: 'محامى',
                      textFontSize: 22.sp,
                      textColor: Colors.white,
                      width: 150.w,
                      height: 50.h),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  defaultButton(
                      background: mainColor,
                      function: () {
                        navigateTo(context, UserRegister());
                      },
                      text: 'مستخدم',
                      textFontSize: 22.sp,
                      textColor: Colors.white,
                      width: 150.w,
                      height: 50.h),
                ],
              ),
            ),
          ),
          // bottomNavigationBar: const Footer(),
        ));
  }
}
