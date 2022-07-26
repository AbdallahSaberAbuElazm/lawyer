import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/modules/register/cubit/registerCubit.dart';
import 'package:lawyer/modules/register/cubit/registerStates.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';
import 'package:path/path.dart';

class LawyerRegister extends StatefulWidget {
  const LawyerRegister({Key? key}) : super(key: key);

  @override
  State<LawyerRegister> createState() => _LawyerRegisterState();
}

class _LawyerRegisterState extends State<LawyerRegister> {
  File? file;
  UploadTask? task;
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? dropDownValue;

  bool isUpload = false;

  List categories = [
    'الافلاس',
    'الملكيه الفكريه',
    'محامي العمل',
    'الاصابات الشخصيه',
    'التخطيط العماري',
    'الجنائي',
    'سوء الممارسة الطبية',
    'تعويض العمال',
    'الدعاوي المدنيه',
    'محامي عام'
  ];

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final fileName = file != null ? basename(file!.path) : 'قم باختيار ملف';

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
          if (state is RegisterLawyerSuccessStates) {
            emailController.text = '';
            usernameController.text = '';
            passwordController.text = '';
            confirmController.text = '';
            phoneController.text = '';

            scaffoldKey.currentState!.showSnackBar(
                const SnackBar(content: Text('عملية تسجيل ناجحة')));
          } else if (state is RegisterUserErrorStates) {
            scaffoldKey.currentState!
                .showSnackBar(SnackBar(content: Text('${state.errMsg}')));
          }
        },
        builder: (context, state) {
          var lawyerCubit = RegisterCubits.get(context);
          // final fileName =
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  title: Text(
                    'Lawyer Online',
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  backgroundColor: mainColor,
                  elevation: 0.0,
                ),
                body: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Text(
                              'انشاء حساب كمحامى',
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: DropdownButton(
                                        hint: dropDownValue == null
                                            ? Text(
                                                'التخصص',
                                                style:
                                                    TextStyle(color: mainColor),
                                              )
                                            : Text(
                                                dropDownValue.toString(),
                                                style:
                                                    TextStyle(color: mainColor),
                                              ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        style: TextStyle(color: mainColor),
                                        items: categories.map(
                                          (val) {
                                            return DropdownMenuItem<String>(
                                              alignment: Alignment.topRight,
                                              value: val,
                                              child: Text(val),
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

                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //       color: Colors.transparent),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 10.0, vertical: 5),
                                  //     child: DropdownButton(
                                  //       hint: dropDownValue == null
                                  //           ? Text('التخصص')
                                  //           : Text(
                                  //               dropDownValue.toString(),
                                  //               style: TextStyle(color: mainColor),
                                  //             ),
                                  //       isExpanded: true,
                                  //       iconSize: 30.0,
                                  //       style: TextStyle(color: mainColor),
                                  //       items: categories.map(
                                  //         (val) {
                                  //           return DropdownMenuItem<String>(
                                  //             alignment: Alignment.topRight,
                                  //             value: val,
                                  //             child: Text(val),
                                  //           );
                                  //         },
                                  //       ).toList(),
                                  //       onChanged: (val) {
                                  //         setState(
                                  //           () {
                                  //             dropDownValue = val.toString();
                                  //           },
                                  //         );
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 15.w,
                                  ),
                                  Container(
                                    width: 230.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey[300],
                                        border: Border.all(color: mainColor)),
                                    child: MaterialButton(
                                      onPressed: () {
                                        selectFile();
                                      },
                                      child: Row(
                                        children: [
                                          Text('رفع ملف ال cv',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22.sp),
                                              textAlign: TextAlign.center),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          const Icon(
                                              Icons.file_upload_outlined),
                                        ],
                                      ),
                                    ),
                                  ),
                                  task != null
                                      ? buildUploadStatus(task!)
                                      : Container(),
                                  (fileName.isEmpty)
                                      ? const SizedBox.shrink()
                                      : Center(
                                          child: Text(
                                            fileName,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 56, 59, 212),
                                                fontSize: 10),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 15.w,
                                  ),
                                  state is! RegisterLawyerLoadingStates
                                      ? defaultButton(
                                          background: mainColor,
                                          function: () {
                                            // uploadFile().then((value) {
                                            lawyerCubit.checkConfirmPass(
                                                passwordController.text.trim(),
                                                confirmController.text.trim());

                                            if (formKey.currentState!
                                                .validate()) {
                                              if (lawyerCubit.confrim == true &&
                                                  fileName.isNotEmpty) {
                                                uploadFile();
                                                lawyerCubit.registerLawyer(
                                                  username: usernameController
                                                      .text
                                                      .trim(),
                                                  email: emailController.text
                                                      .trim(),
                                                  password: passwordController
                                                      .text
                                                      .trim(),
                                                  phone: phoneController.text
                                                      .trim(),
                                                  category: dropDownValue,
                                                );
                                              } else if (lawyerCubit.confrim ==
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
              ));
        },
      ),
    );
  }

  Future selectFile() async {
    setState(() {
      isUpload = true;
    });
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;
    setState(() {
      isUpload = true;
    });
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = upload(destination, file!);

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL().then((value) {});

    print('Download-Link: $urlDownload');
  }

  static UploadTask? upload(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
