import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyer/controllers/user_controller.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/cubit/states.dart';
import 'package:lawyer/layouts/users/chat/chat_messages.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final UserController _userController = Get.find();
  @override
  void initState() {
    _userController.getUserChatsWithLawyer();
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
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('جميع المحامين'),
                centerTitle: true,
              ),
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Obx(
                    () => ListView.separated(
                      itemCount: _userController.user.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            navigateTo(
                                context,
                                ChatMessages(
                                    model: _userController.user[index]));
                          },
                          child: Row(
                            children: [
                              Obx(
                                () => CircleAvatar(
                                  radius: 25,
                                  backgroundColor: mainColor,
                                  backgroundImage: NetworkImage(_userController
                                      .user[index].photo
                                      .toString()),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Obx(
                                () => Text(
                                  _userController.user[index].username
                                      .toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: mainColor,
                      ),
                    ),
                  )),
            ));
      },
    );
  }
}
