import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer/modules/login/login_screen.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/styles/colors.dart';

class FireAuth {
  static Future resetPassword(
      {@required BuildContext? context, @required String? email}) async {
    showDialog(
        context: context!,
        barrierDismissible: false,
        builder: (context) =>
            Center(child: CircularProgressIndicator(color: mainColor)));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      showDialog(
          context: context,
          builder: (context) {
            return Padding(
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 0.7,
                    height: 228,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 135, 221, 202),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'تم إرسال ربط تغيير كلمة المرور الي بريدك الإلكتروني',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.grey.shade200,
                                    minimumSize: const Size.fromHeight(50),
                                    primary: Colors.grey.shade200,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                  ),
                                  onPressed: () => Get.off(() => LoginScreen()),
                                  child: Text(
                                    'نعم',
                                    style: TextStyle(
                                        color: mainColor, fontSize: 21),
                                  )),
                            ],
                          )),
                    ),
                  ),
                ));
          });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.message!,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        backgroundColor: Colors.white,
      ));
      Navigator.of(context).pop();
    }
  }
}
