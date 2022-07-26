import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/modules/register/cubit/registerCubit.dart';
import 'package:lawyer/modules/register/cubit/registerStates.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class UserRegister extends StatelessWidget {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // bool val = false;
    ScreenUtil.init(context,
        // BoxConstraints(
        //   maxWidth: MediaQuery.of(context).size.width,
        //   maxHeight: MediaQuery.of(context).size.height,
        // ),
        designSize: Size(width, height),
        minTextAdapt: true,
        orientation: Orientation.portrait);

    return BlocProvider(
      create: (context) => RegisterCubits(),
      child: BlocConsumer<RegisterCubits, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterUserSuccessStates) {
            emailController.text = '';
            usernameController.text = '';
            passwordController.text = '';
            confirmController.text = '';
            phoneController.text = '';

            scaffoldKey.currentState!
                .showSnackBar(SnackBar(content: Text('عملية تسجيل ناجحة')));
          } else if (state is RegisterUserErrorStates) {
            scaffoldKey.currentState!
                .showSnackBar(SnackBar(content: Text('${state.errMsg}')));
          }
        },
        builder: (context, state) {
          var registerCubit = RegisterCubits.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                'Lawyer Online',
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: mainColor,
              elevation: 0.0,
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'انشاء حساب لمستخدم',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              defaultTextField(
                                  controller: usernameController,
                                  iconColor: mainColor,
                                  borderColor: mainColor,
                                  hintText: 'اسم المستخدم',
                                  suffixIcon: Icons.person,
                                  validate: (value) {
                                    if (value.toString().isEmpty) {
                                      return 'برجاء ادخال اسم المستخدم';
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height: 15.w,
                              ),
                              defaultTextField(
                                  controller: emailController,
                                  iconColor: mainColor,
                                  borderColor: mainColor,
                                  hintText: 'البريد الالكتروني',
                                  suffixIcon: Icons.email,
                                  validate: (value) {
                                    if (value.toString().isEmpty) {
                                      return 'برجاء ادخال البريد الالكتروني';
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height: 15.w,
                              ),
                              defaultTextField(
                                  controller: phoneController,
                                  iconColor: mainColor,
                                  borderColor: mainColor,
                                  hintText: 'رقم الهاتف',
                                  suffixIcon: Icons.phone,
                                  validate: (value) {
                                    if (value.toString().isEmpty) {
                                      return 'برجاء ادخال رقم الهاتف';
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height: 15.w,
                              ),
                              defaultTextField(
                                  controller: passwordController,
                                  iconColor: mainColor,
                                  borderColor: mainColor,
                                  hintText: 'كلمة السر',
                                  suffixIcon: Icons.lock,
                                  validate: (value) {
                                    if (value.toString().isEmpty) {
                                      return 'برجاء ادخال كلمة السر';
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height: 15.w,
                              ),
                              defaultTextField(
                                  controller: confirmController,
                                  iconColor: mainColor,
                                  borderColor: mainColor,
                                  hintText: 'تأكيد كلمة السر ',
                                  suffixIcon: Icons.lock,
                                  validate: (value) {
                                    if (value.toString().isEmpty) {
                                      return 'برجاء تأكيد كلمة السر';
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height: 15.w,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    checkColor: mainColor,
                                    activeColor: Colors.red,
                                    value: registerCubit.accept,
                                    onChanged: (value) {
                                      registerCubit.changeAcceptance(value);
                                    },
                                  ),
                                  Text(
                                    'اوافق علي الشروط والاحكام',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.sp),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'الشروط والاحكام',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.w,
                              ),
                              state is! RegisterUserLoadingStates
                                  ? defaultButton(
                                      background: mainColor,
                                      function: () {
                                        registerCubit.checkConfirmPass(
                                            passwordController.text.trim(),
                                            confirmController.text.trim());

                                        if (formKey.currentState!.validate() &&
                                            registerCubit.accept == true) {
                                          if (registerCubit.confrim == true) {
                                            registerCubit.registerUser(
                                                username: usernameController
                                                    .text
                                                    .trim(),
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim(),
                                                phone:
                                                    phoneController.text.trim(),
                                                lawyer: false,
                                                category: '');
                                          } else if (registerCubit.confrim ==
                                              false) {
                                            scaffoldKey.currentState!
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'كلمة السر غير متطابقة')));
                                          }
                                        }
                                      },
                                      text: 'انشاء حساب جديد',
                                      textFontSize: 22.sp,
                                      textColor: Colors.white,
                                      width: 200.w,
                                      height: 50.h)
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: mainColor,
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
            ),
            // bottomNavigationBar: const Footer(),
          );
        },
      ),
    );
  }
}
