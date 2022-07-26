import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer/controllers/user_controller.dart';
import 'package:lawyer/layouts/admin/show_app_users.dart.dart';
import 'package:lawyer/models/user_model.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/admin_drawer.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final UserController _userController = Get.find<UserController>();
  int users = 0;
  int lawyers = 0;
  int admins = 0;
  List<UsersModel> usersData = [];
  List<UsersModel> lawyersData = [];
  List<UsersModel> adminsData = [];

  @override
  void initState() {
    print('all users ${_userController.allUsers.length}');
    usersData = [];
    lawyersData = [];
    adminsData = [];
    getNumOfUsers();
    super.initState();
  }

  getNumOfUsers() {
    for (int i = 0; i < _userController.allUsers.length; i++) {
      if (_userController.allUsers[i].lawyer == false) {
        if (_userController.allUsers[i].admin == false) {
          users++;
          usersData.add(_userController.allUsers[i]);
        } else {
          admins++;
          adminsData.add(_userController.allUsers[i]);
        }
      } else {
        lawyers++;

        lawyersData.add(_userController.allUsers[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'الصفحة الرئيسية',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: mainColor,
              elevation: 0.0,
            ),
            drawer: AdminDrawer(),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 70, bottom: 40),
                    child: SingleChildScrollView(
                        child: Container(
                            height: MediaQuery.of(context).size.height - 50,
                            child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () => Get.to(() => ShowAppUsers(
                                            hint: 'مستخدمين',
                                            users: usersData)),
                                        child: circleData(
                                            number: users, hint: 'مستخدمين'),
                                      ),
                                      InkWell(
                                          onTap: () => Get.to(() =>
                                              ShowAppUsers(
                                                  hint: 'محاميين',
                                                  users: lawyersData)),
                                          child: circleData(
                                              number: lawyers,
                                              hint: 'محاميين')),
                                    ],
                                  ),
                                  InkWell(
                                      onTap: () => Get.to(() => ShowAppUsers(
                                          hint: 'ادمن', users: adminsData)),
                                      child: circleData(
                                          number: admins, hint: 'ادمن')),
                                ])))))));
  }

  Widget circleData({
    required int number,
    required String hint,
  }) {
    return Column(children: [
      Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: 130,
          decoration: BoxDecoration(
              color: const Color(0xfff4f5f6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 4),
                ),
              ],
              shape: BoxShape.circle),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  number.toString(),
                  style: TextStyle(color: mainColor, fontSize: 24),
                ),
                Text(
                  hint,
                  style: TextStyle(color: mainColor, fontSize: 22),
                ),
              ],
            ),
          ))
    ]);
  }
}
