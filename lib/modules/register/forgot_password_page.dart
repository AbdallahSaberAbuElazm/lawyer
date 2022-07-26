import 'package:flutter/material.dart';
import 'package:lawyer/modules/login/login_screen.dart';
import 'package:lawyer/modules/register/cubit/firebase_auth.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Form(
          key: _formKey,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/start.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      Text(
                        'هل نسيت كلمة المرور؟',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: mainColor, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('ادخل بريدك الإلكتروني',
                          style: TextStyle(color: mainColor, fontSize: 19),
                          textAlign: TextAlign.right),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                        controller: _emailController,
                        prefixIcon: Icons.person,
                        borderColor: mainColor,
                        hintText: 'البريد الالكترونى ',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FireAuth.resetPassword(
                                context: context,
                                email: _emailController.text.trim());
                          }
                        },
                        icon: const Icon(
                          Icons.email_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'إرسال',
                          style: TextStyle(color: Colors.white, fontSize: 21),
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: mainColor,
                          minimumSize: const Size.fromHeight(50),
                        ),
                      ),
                      TextButton(
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen())),
                          child: Text('إلغاء',
                              style: TextStyle(color: mainColor, fontSize: 25),
                              textAlign: TextAlign.left)),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
