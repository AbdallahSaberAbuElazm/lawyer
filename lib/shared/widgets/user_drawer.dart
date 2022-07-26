import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawyer/layouts/users/LegalTexts/legal_texts.dart';
import 'package:lawyer/layouts/users/frequently_question/frequently_asked_question_screen.dart';
import 'package:lawyer/layouts/users/home_layout.dart';
import 'package:lawyer/modules/login/login_screen.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/components/util.dart';
import 'package:lawyer/shared/network/local/cashe_helper.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/user_shared_preferences.dart';
import 'dart:io';
import 'package:path/path.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  final ImagePicker _picker = ImagePicker();

  final User? user = FirebaseAuth.instance.currentUser;

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
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/profileBackground.png'),
                      fit: BoxFit.cover)),
              accountEmail: Text('${UserSharedPreferences.getUseremail()} '),
              accountName: Text('${UserSharedPreferences.getUserName()} '),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: mainColor,
                  backgroundImage: NetworkImage((UserSharedPreferences
                              .getUserAvatarUrl() !=
                          null)
                      ? UserSharedPreferences.getUserAvatarUrl()!
                      : 'https://firebasestorage.googleapis.com/v0/b/printore-2364c.appspot.com/o/vz5KFq5YWxRT7HqZkSw1gm2LAu02%2Fprofile%2Fcamera.png?alt=media&token=88a3a37c-f351-4278-bcff-aaf95b54b8f2'),
                ),
                onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    final file = File(image.path);
                    try {
                      if (UserSharedPreferences.getUserAvatarUrl() != null) {
                        FirebaseStorage.instance
                            .ref(
                                '${user!.uid}/profile/${UserSharedPreferences.getUserAvatarName()}')
                            .delete();
                      }
                      var taskSnapshot = FirebaseStorage.instance
                          .ref('${user!.uid}/profile/${basename(image.path)}')
                          .putFile(file);
                      final url =
                          await (await taskSnapshot).ref.getDownloadURL();
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.uid)
                          .update({'avatarUrl': url});
                      setState(() {
                        UserSharedPreferences.setUserAvatar(
                            url: url, photoName: basename(image.path));
                      });
                    } on FirebaseException catch (e) {
                      return Utils.snackBar(context: context, msg: e.message);
                    }
                  }
                },
              ),
            ),
            InkWell(
                onTap: () {
                  navigateTo(context, const HomeLayout());
                },
                child: createDrawerBodyItem(
                  icon: EvaIcons.home,
                  text: 'الرئيسية',
                )),
            const Divider(),
            InkWell(
              onTap: () {
                navigateTo(context, LegalTextsScreen());
              },
              child: createDrawerBodyItem(
                  icon: EvaIcons.bookOpenOutline, text: 'مواد القانون'),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                navigateTo(context, const FrequentlyAskedQuestionScreen());
              },
              child: createDrawerBodyItem(
                  icon: Icons.question_mark_rounded, text: 'الاسئلة الشائعة'),
            ),
            const Divider(),
            InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    CasheHelper.removeData(key: 'laywerID');
                    CasheHelper.removeData(key: 'uID');

                    UserSharedPreferences.removeDataForLogout();

                    Get.off(() => LoginScreen());
                  });
                },
                child: createDrawerBodyItem(
                    icon: EvaIcons.logOut, text: 'تسجيل الخروج')),
          ],
        ),
      ),
    ));
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
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: Text(
                text.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ))
        ],
      ),
      onTap: onTap,
    );
  }
}
