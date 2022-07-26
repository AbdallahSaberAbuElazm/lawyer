import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/cubit/states.dart';
import 'package:lawyer/layouts/users/chat/chat_screen.dart';
import 'package:lawyer/layouts/users/user_problems/edit_problems.dart';
import 'package:lawyer/layouts/users/user_problems/my_offers.dart';
import 'package:lawyer/models/problems_model.dart';
import 'package:lawyer/shared/components/constants.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class MyProblems extends StatelessWidget {
  const MyProblems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    return BlocConsumer<LawyerCubits, LawyerStates>(
      listener: (context, state) {
        if (state is LawyerDeleteMyProblemsSuccessSatets) {
          SnackBar snackBar = const SnackBar(
            content: Text('تم حذف المشكلة بنجاح'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;

        ScreenUtil.init(context,
            designSize: Size(width, height),
            minTextAdapt: true,
            orientation: Orientation.portrait);
        return BlocConsumer<LawyerCubits, LawyerStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = LawyerCubits.get(context);
            return Directionality(
                textDirection: TextDirection.rtl,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        'مشاكلي',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      centerTitle: true,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemCount: cubit.myProblems.length,
                              separatorBuilder: (context, index) => Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  const Divider(
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                              itemBuilder: (context, index) {
                                if (state
                                    is LawyerGetProblemsByCatLoadingStates) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: mainColor,
                                    ),
                                  );
                                } else {
                                  return buildProblemContent(
                                      context,
                                      cubit.myProblems[index],
                                      cubit.myProblemsID[index]);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }

  Widget buildProblemContent(context, ProblemsModel model, String probID) {
    var cubit = LawyerCubits.get(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: mainColor),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200]),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.title.toString(),
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                          model.isSolved == false
                              ? const Text(
                                  'لم تحل بعد',
                                  style: TextStyle(color: Colors.red),
                                )
                              : const Text(
                                  'تم الحل',
                                  style: TextStyle(color: Colors.green),
                                )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        model.desc.toString(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              model.username.toString(),
                              style: TextStyle(color: Colors.blue[900]),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            parseDate(model.date.toString()),
                            style: const TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        EditMyProblems(
                          myProblems: model,
                          probID: probID,
                        ));
                  },
                  child: Row(
                    children: const [
                      Text('تعديل'),
                      Icon(Icons.edit),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    cubit.deleteProblem(probID: probID);
                  },
                  child: Row(
                    children: const [
                      Text('حذف'),
                      Icon(
                          // FlutterIcons.trash_evi
                          Icons.delete),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        InkWell(
          onTap: () {
            // print(probID);
            // navigateTo(
            //     context,
            //     OfferScreen(
            //       problemsModel: model,
            //       probID: probID,
            //     ));
          },
          child: InkWell(
            onTap: () {
              navigateTo(context,
                  UserOffersScreen(problemsModel: model, probID: probID));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              decoration: BoxDecoration(
                  border: Border.all(color: mainColor),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5)),
              child: const Text(
                'رؤية العروض',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
