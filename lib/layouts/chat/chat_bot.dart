import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/cubit/states.dart';
import 'package:lawyer/models/connect_model.dart';
import 'package:lawyer/models/message_model.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class ChatBot extends StatefulWidget {
  final ConnectModel? model;
  const ChatBot({Key? key, required this.model}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  TextEditingController messageController = TextEditingController();
  // UsersModel? model;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    LawyerCubits.get(context).getMessages(senderId: widget.model!.userID);
    super.initState();

    // print('message length ${LawyerCubits.get(context).messages.length}');
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context,
        // BoxConstraints(
        //   maxWidth: MediaQuery.of(context).size.width,
        //   maxHeight: MediaQuery.of(context).size.height,
        // ),
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
                    centerTitle: true,
                    title: Text(
                      'محادثة',
                      style: TextStyle(
                          fontSize: 24.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: mainColor,
                    elevation: 0.0,
                  ),
                  body: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        children: [
                          (LawyerCubits.get(context)
                                      .recieverMessages
                                      .isNotEmpty &&
                                  state
                                      is! LawyerGetMessageSuccessLoadingStates)
                              ? SingleChildScrollView(
                                  reverse: true,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding:
                                          const EdgeInsets.only(bottom: 70),
                                      itemBuilder: (context, index) {
                                        var message = LawyerCubits.get(context)
                                            .recieverMessages[index];
                                        if (
                                            // LawyerCubits.get(context)
                                            //       .model!
                                            //       .userID
                                            widget.model!.lawyerID ==
                                                message.recieveID) {
                                          return buildMyMessage(message);
                                        }
                                        return buildMessage(message);
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                      itemCount: LawyerCubits.get(context)
                                          .recieverMessages
                                          .length))
                              : const SizedBox.shrink(),
                          //  const Spacer(),
                          Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: TextFormField(
                                        controller: messageController,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'اكتب الان'),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (messageController.text.isNotEmpty) {
                                      LawyerCubits.get(context)
                                          .sendMessageLawyer(
                                              recieverID: widget.model!.userID,
                                              dateTime:
                                                  DateTime.now().toString(),
                                              message: messageController.text
                                                  .trim());
                                      messageController.text = '';
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: mainColor,
                                    child: const Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )));
        });
  }

  Widget buildMessage(
    MessageModel messageModel,
  ) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        child: Text('${messageModel.message}'),
      ),
    );
  }

  Widget buildMyMessage(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        child: Text('${messageModel.message}',
            style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
