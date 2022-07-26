import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer/layouts/admin/add_popular_questions.dart';
import 'package:lawyer/layouts/admin/admin_home_page.dart';

import 'package:lawyer/modules/login/login_screen.dart';
import 'package:lawyer/shared/components/components.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromARGB(255, 22, 112, 150), Colors.teal])),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 120,
            ),
            InkWell(
                onTap: () {
                  navigateTo(context, AdminHomePage());
                },
                child: createDrawerBodyItem(
                    icon: EvaIcons.home, text: 'الرئيسية')),
            InkWell(
              onTap: () {
                navigateTo(context, const AddPopularQuestion());
              },
              child: createDrawerBodyItem(
                  icon: EvaIcons.messageCircleOutline, text: 'الأسئلة الشائعة'),
            ),
            const Divider(),
            InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    Get.off(() => LoginScreen());
                  });
                },
                child: createDrawerBodyItem(
                    icon: EvaIcons.logOut, text: 'تسجيل الخروج')),
          ],
        ),
      ),
    );
  }

  Widget createDrawerBodyItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text(
              text.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
