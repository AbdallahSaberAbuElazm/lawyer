import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyer/controllers/user_controller.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/cubit/states.dart';
import 'package:lawyer/layouts/chat/chat_bot.dart';

import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class LawyerChatScreen extends StatefulWidget {
  const LawyerChatScreen({Key? key}) : super(key: key);

  @override
  State<LawyerChatScreen> createState() => _LawyerChatScreenState();
}

class _LawyerChatScreenState extends State<LawyerChatScreen> {
  final UserController userController = Get.find<UserController>();
  @override
  void initState() {
    userController.getUserChatsWithLawyer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context,
        designSize: Size(width, height),
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return BlocConsumer<LawyerCubits, LawyerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var cubit = LawyerCubits.get(context);

        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('رسائل الزبائن'),
                centerTitle: true,
              ),
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Obx(
                    () => ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              navigateTo(
                                  context,
                                  ChatBot(
                                      model:
                                          userController.connectList[index]));
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: mainColor,
                                  backgroundImage: userController
                                          .user[index].photo
                                          .toString()
                                          .isNotEmpty
                                      ? NetworkImage(userController
                                          .user[index].photo
                                          .toString())
                                      : const NetworkImage(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCvPW4n2sq5EZhgjLF3U0iEZAMfkAE-J0nOA&usqp=CAU')
                                          as ImageProvider,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Obx(
                                    () => Text(
                                      userController.user[index].username
                                          .toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                              color: mainColor,
                            ),
                        itemCount: userController.user.length),
                  )),
            ));
      },
    );
  }
}
