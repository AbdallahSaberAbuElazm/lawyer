import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/cubit/states.dart';
import 'package:lawyer/layouts/users/chat/chat_messages.dart';
import 'package:lawyer/layouts/users/chat/chat_screen.dart';
import 'package:lawyer/models/user_model.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

import '../../../shared/components/components.dart';

class LawyerDetails extends StatelessWidget {
  final UsersModel model;
  const LawyerDetails({Key? key, required this.model}) : super(key: key);

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
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(model.username.toString()),
                  actions: [
                    InkWell(
                      onTap: () {
                        navigateTo(context, const ChatScreen());
                      },
                      child: const Icon(
                        EvaIcons.messageCircleOutline,
                        size: 32,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: mainColor,
                                backgroundImage:
                                    NetworkImage(model.photo.toString()),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'التقيم',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  RatingBar(
                                      itemSize: 18,
                                      initialRating: model.rate!.toDouble(),
                                      minRating: 1,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 5),
                                      ratingWidget: RatingWidget(
                                          full: const Icon(
                                            EvaIcons.star,
                                            color: Colors.amber,
                                          ),
                                          half: const Icon(
                                            Icons.star_half,
                                            color: Colors.amber,
                                          ),
                                          empty: const Icon(
                                            EvaIcons.starOutline,
                                            color: Colors.grey,
                                          )),
                                      onRatingUpdate: (rating) {
                                        //print(rating);
                                      })
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  navigateTo(
                                      context,
                                      ChatMessages(
                                        model: model,
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      EvaIcons.messageCircleOutline,
                                      size: 32,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'تواصل معنا',
                                      style: TextStyle(fontSize: 22),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'سنوات الخبرة',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              width: double.infinity,
                              height: height * 0.1,
                              decoration: BoxDecoration(
                                  border: Border.all(color: mainColor),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200]),
                              child: model.yearsExp!.isNotEmpty
                                  ? Text(
                                      '${model.yearsExp} من سنوات الخبرة',
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'نبذه عني',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(color: mainColor),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200]),
                              child: Text(
                                '${model.info}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
