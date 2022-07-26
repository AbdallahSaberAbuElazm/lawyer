import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/layouts/users/home_layout.dart';
import 'package:lawyer/layouts/lawyer/lawyer_layout/lawyer_layout.dart';
import 'package:lawyer/models/user_model.dart';
import 'package:lawyer/modules/login/loginCubit/login_cubit.dart';
import 'package:lawyer/modules/login/loginCubit/login_states.dart';
import 'package:lawyer/modules/register/forgot_password_page.dart';
import 'package:lawyer/modules/toggleRegister/toggle_screen.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/network/local/cashe_helper.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';
import '../../shared/components/constants.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> loginKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    UsersModel? checkModel;

    ScreenUtil.init(context,
        // BoxConstraints(
        //   maxWidth: MediaQuery.of(context).size.width,
        //   maxHeight: MediaQuery.of(context).size.height,
        // ),
        designSize: Size(width, height),
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return BlocProvider(
      create: (context) => LoginCubits(),
      child: BlocConsumer<LoginCubits, LoginStates>(
        listener: (context, state) {
          if (state is LoginUserSuccessStates) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(state.uID)
                .snapshots()
                .listen((event) async {
              checkModel = UsersModel.fromJson(event.data()!);
              CasheHelper.removeData(key: 'uID');
              CasheHelper.removeData(key: 'laywerID');

              // await UserSharedPreferences.setUserInfo(
              //   email: event['email'],
              //   username: event['username'],
              // );

              if (checkModel!.lawyer == true) {
                CasheHelper.saveData(key: 'laywerID', value: checkModel!.userID)
                    .then((value) {
                  setState(() {
                    lawyerID = CasheHelper.getData(key: 'laywerID');
                  });
                  CasheHelper.removeData(key: 'uID').then((value) {
                    // navigateAndFinish(context, LawyerLayout());
                  });
                });
              } else {
                CasheHelper.saveData(key: 'uID', value: state.uID)
                    .then((value) {
                  setState(() {
                    userID = CasheHelper.getData(key: 'uID');
                  });
                  CasheHelper.removeData(key: 'laywerID').then((value) {
                    // navigateAndFinish(context, const HomeLayout());
                  });
                });
              }
            });
          } else if (state is LoginUserErrorStates) {
            loginKey.currentState!
                .showSnackBar(SnackBar(content: Text('${state.errMsg}')));
          }
        },
        builder: (context, state) {
          var loginCubit = LoginCubits.get(context);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Directionality(
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
                    body: SingleChildScrollView(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Image.asset(
                                    'assets/images/start.jpg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    defaultTextField(
                                      controller: emailController,
                                      prefixIcon: Icons.person,
                                      borderColor: mainColor,
                                      hintText: 'البريد الالكترونى ',
                                    ),
                                    SizedBox(height: ScreenUtil().setWidth(20)),
                                    defaultTextField(
                                      controller: passwordController,
                                      borderColor: mainColor,
                                      prefixIcon: Icons.lock,
                                      hintText: 'كلمة السر',
                                    ),
                                    SizedBox(height: ScreenUtil().setWidth(20)),
                                    InkWell(
                                      onTap: () {
                                        navigateTo(context,
                                            const ForgotPasswordPage());
                                      },
                                      child: Text(
                                        'نسيت كلمة السر؟',
                                        style: TextStyle(
                                            fontSize: 20.sp, color: mainColor),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // state is! LoginUserLoadingStates
                              // ?
                              defaultButton(
                                  background: mainColor,
                                  textColor: Colors.white,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      loginCubit.loginUser(
                                          context: context,
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim());
                                    }
                                  },
                                  text: 'تسجيل الدخول',
                                  textFontSize: 20.sp,
                                  width: 150.w,
                                  height: 40.h),
                              // :
                              //  Center(
                              //     child: CircularProgressIndicator(
                              //       color: mainColor,
                              //     ),
                              //   ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      ' لست مشترك؟',
                                      style: TextStyle(fontSize: 18.sp),
                                    ),
                                    const SizedBox(width: 5),
                                    InkWell(
                                      onTap: () {
                                        navigateTo(
                                            context, const ToggleScreen());
                                      },
                                      child: Text(
                                        'اشترك الان',
                                        style: TextStyle(
                                            fontSize: 20.sp, color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // bottomNavigationBar: Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
                    //   child: Row(
                    //     children: [
                    //       const Icon(
                    //         Icons.arrow_back_ios,
                    //         size: 32,
                    //       ),
                    //       defaultButton(
                    //           background: mainColor,
                    //           textColor: Colors.white,
                    //           function: () {},
                    //           text: 'الرجوع',
                    //           textFontSize: 20.sp,
                    //           width: 140.w,
                    //           height: 40.h)
                    //     ],
                    //   ),
                    // ),
                  )));
        },
      ),
    );
  }
}
