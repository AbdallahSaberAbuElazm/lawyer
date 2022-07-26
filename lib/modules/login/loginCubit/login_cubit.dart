import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/layouts/admin/admin_home_page.dart';
import 'package:lawyer/layouts/lawyer/lawyer_layout/lawyer_layout.dart';
import 'package:lawyer/layouts/users/home_layout.dart';
import 'package:lawyer/models/user_model.dart';
import 'package:lawyer/modules/login/loginCubit/login_states.dart';
import 'package:lawyer/shared/components/util.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/user_shared_preferences.dart';
import 'package:path/path.dart';
import 'package:lawyer/layouts/admin/add_popular_questions.dart';
import 'package:flutter/material.dart';

class LoginCubits extends Cubit<LoginStates> {
  LoginCubits() : super(LoginInitialStates());

  static LoginCubits get(context) => BlocProvider.of(context);
/**
 * redaali01551833421 | redahehmat7  / pass : reda2000
 */
  String errorMessage = '';
  UsersModel? checkModel;
  bool isLawyer = false;
  void loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(LoginUserLoadingStates());
    User? user;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            Center(child: CircularProgressIndicator(color: mainColor)));
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;

      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      emit(LoginUserSuccessStates(user.uid));
      if (user != null) {
        await UserSharedPreferences.setUserInfo(
          userId: result['userID'],
          email: email,
          username: result['username'],
          isLawyer: result['lawyer'],
          avatarUrl: (result['photo'] != null) ? result['photo'] : '',
          avatarName:
              (result['photo'] != null) ? basename(result['photo']) : '',
          info: result['info'],
          dates: result['dates'],
          yearsExp: result['yearsExp'],
          // rates: result['rate'],
          category: result['category'],
          isAdmin: result['admin'],
        );
        if (result['lawyer'] == false) {
          if (result['admin'] == true) {
            Get.off(() => AdminHomePage());
          } else {
            Get.off(() => const HomeLayout());
          }
        } else {
          Get.off(() => LawyerLayout());
        }
        LawyerCubits.get(context)
            .getUserData(userId: UserSharedPreferences.getUserId().toString());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.pop(context);
        Utils.snackBar(msg: 'لا يوجد مستخدم لهذا الحساب', context: context);
      } else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        Utils.snackBar(
            msg: 'الرقم السري الذي ادخلته غير صحيح', context: context);
      }
    } //  emit(LoginUserErrorStates(errorMessage));
  }
}
