import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer/controllers/user_controller.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/layouts/lawyer/lawyer_layout/problems/problems_screen.dart';
import 'package:lawyer/layouts/lawyer/lawyer_layout/profile/setting.dart';
// import 'package:lawyer/shared/components/constants.dart';
import 'package:lawyer/shared/components/util.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';
// import 'package:lawyer/shared/network/local/cashe_helper.dart';
import 'package:lawyer/shared/widgets/lawyer_drawer.dart';
import 'package:lawyer/shared/widgets/user_shared_preferences.dart';

class LawyerLayout extends StatefulWidget {
  @override
  State<LawyerLayout> createState() => _LawyerLayoutState();
}

class _LawyerLayoutState extends State<LawyerLayout> {
  final UserController userController = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
    userController.getChatForLawyer();
    LawyerCubits.get(context)
        .getUserData(userId: UserSharedPreferences.getUserId().toString());
    LawyerCubits.get(context).getLawyerData();
  }

  Future<bool> _onWillPop() async {
    return (await Utils.showDialogOnWillPop(context: context)) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: DefaultTabController(
                length: 2,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    drawer: const LawyerDrawer(),
                    appBar: AppBar(
                      centerTitle: true,
                      title: const Text('Lawyer Online'),
                      bottom: const TabBar(
                        indicatorColor: Colors.black,
                        tabs: [
                          Tab(icon: Icon(Icons.contacts), text: "المشاكل"),
                          Tab(icon: Icon(Icons.settings), text: "الاعدادات")
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        const ProblemScreen(),
                        ProfileScreen(),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
