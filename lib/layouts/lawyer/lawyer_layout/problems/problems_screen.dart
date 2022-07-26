import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/cubit/states.dart';
import 'package:lawyer/layouts/lawyer/lawyer_layout/problems/offer_problem.dart';
import 'package:lawyer/models/problems_model.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/components/constants.dart';
import 'package:lawyer/shared/components/util.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class ProblemScreen extends StatefulWidget {
  const ProblemScreen({Key? key}) : super(key: key);

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    return BlocConsumer<LawyerCubits, LawyerStates>(
      listener: (context, state) {},
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
                    body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: DropdownButton(
                                borderRadius: BorderRadius.circular(5),
                                hint: dropDownValue == null
                                    ? const Text('التخصص')
                                    : Text(
                                        dropDownValue.toString(),
                                        style: TextStyle(color: mainColor),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: mainColor),
                                items: Utils.categories.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      alignment: Alignment.topRight,
                                      value: val,
                                      child: Text(
                                        val,
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  cubit.getProblemsByCat(cat: val.toString());
                                  setState(
                                    () {
                                      dropDownValue = val.toString();
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          cubit.allProblems.isNotEmpty
                              ? Expanded(
                                  child: ListView.separated(
                                    itemCount: cubit.allProblems.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 10.h,
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
                                            cubit.allProblems[index],
                                            cubit.allProblemsID[index]);
                                      }
                                    },
                                  ),
                                )
                              : const Center(
                                  child: Text('لا توجد مشكلات'),
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

  Widget buildProblemContent(ProblemsModel model, String probID) {
    // var cubit = LawyerCubits.get(context);

    return Column(
      children: [
        Container(
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
                          ),
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
        SizedBox(
          height: 10.h,
        ),
        InkWell(
          onTap: () {
            // print(probID);
            navigateTo(
                context,
                OfferScreen(
                  problemsModel: model,
                  probID: probID,
                ));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: mainColor),
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: const Text(
              'قدم عرضك',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
