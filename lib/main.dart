import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lawyer/controllers/freq_asked_question__controller.dart';
import 'package:lawyer/controllers/user_controller.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/layouts/users/home_layout.dart';
import 'package:lawyer/modules/start/start_screen.dart';
import 'package:lawyer/shared/network/bloc_observer.dart';
import 'package:lawyer/shared/network/local/cashe_helper.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:get/get.dart';
import 'package:lawyer/shared/widgets/user_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSharedPreferences.init();
  await CasheHelper.init();

  // Widget widget = HomeLayout();

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
          // widget
          ));
    },
    blocObserver: MyBlocObserver(),
  );
  await getControllers();
}

getControllers() {
  Get.put(FrequentlyAskedQuestionController());
  Get.put(UserController());
}

class MyApp extends StatelessWidget {
  // final Widget startWidget;
  // ignore: use_key_in_widget_constructors
  MyApp(
      // this.startWidget
      );

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    final theme = ThemeData();

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => LawyerCubits()
                ..getUserData(
                    userId: UserSharedPreferences.getUserId().toString())
                ..getAllUsersMessage())
        ],
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Lawyer Online',
              theme: theme.copyWith(
                colorScheme: theme.colorScheme.copyWith(
                  primary: mainColor,
                ),
              ),
              home: const StartScreen(),
            )));
  }
}
/** 
 * chat user (Category) (ok)
 * lawyer search by name (ok)
 * admin dashboard to add frequently question (ok)
 * notification for chats
 * login => when password or email is wrong (ok)
 * profile lawyer (ok)
 * null in lawyer offer (ok)
*/
