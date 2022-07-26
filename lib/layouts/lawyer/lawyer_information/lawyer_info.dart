import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/cubit/states.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';
import 'package:lawyer/shared/widgets/user_shared_preferences.dart';

class LawyerInformation extends StatefulWidget {
  final int index;
  const LawyerInformation({Key? key, required this.index}) : super(key: key);

  @override
  State<LawyerInformation> createState() => _LawyerInformationState(index);
}

class _LawyerInformationState extends State<LawyerInformation> {
  int index;
  double? rate;
  _LawyerInformationState(this.index);
  @override
  void initState() {
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
                centerTitle: true,
                title: Text(
                  'Lawyer Online',
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: mainColor,
                elevation: 0.0,
              ),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: buildLawyerInfo(),
                  ),
                ),
              ),
            ));
      },
    );
  }

  Widget buildLawyerInfo() {
    var cubit = LawyerCubits.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${UserSharedPreferences.getUserName().toString()}',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${UserSharedPreferences.getUserInfo().toString()}',
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 22, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'سنوات الخبرة',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${UserSharedPreferences.getUserYearsExp().toString()}',
                    style: const TextStyle(fontSize: 22, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'التخصص',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${UserSharedPreferences.getUserCategory().toString()}',
                    style: const TextStyle(fontSize: 22, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'مواعيد التفرغ',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${UserSharedPreferences.getUserDates().toString()}',
                    style: const TextStyle(fontSize: 22, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  //Use Background Image Instead of Child
                  //Example -->  // backgroundImage: NetworkImage(''),
                  radius: 50,
                  child: const Icon(
                    Icons.person,
                    size: 48,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RatingBar(
                    itemSize: 16,
                    initialRating: double.parse(
                        cubit.searchList[widget.index].rate.toString()),
                    minRating: 1,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2),
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
                      print(rating);
                    })
              ],
            ),
          ],
        ),
        SizedBox(
          height: 50.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: mainColor)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: const [
                    Text(
                      '15 دقيقة',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '50 ج.م',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: mainColor)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: const [
                    Text(
                      '30 دقيقة',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '75 ج.م',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: mainColor)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: const [
                    Text(
                      '60 دقيقة',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '100 ج.م',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 40.w,
        ),
        Row(
          children: [
            defaultButton(
                function: () {
                  showRating(
                      context, cubit.searchList[index].userID.toString());
                },
                background: mainColor,
                text: 'قم بتقيم المحامى',
                textColor: Colors.white,
                textFontSize: 20.sp,
                width: 180.w,
                height: 60.h),
            SizedBox(
              width: 20.w,
            ),
            defaultButton(
                function: () {},
                background: mainColor,
                text: 'احجز الان',
                textColor: Colors.white,
                textFontSize: 20.sp,
                width: 110.w,
                height: 60.h),
          ],
        ),
      ],
    );
  }

  void showRating(context, String id) {
    var cubit = LawyerCubits.get(context);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                'قيم هذا المحامى',
                textAlign: TextAlign.center,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingBar.builder(
                      minRating: 0,
                      itemSize: 38,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                      itemCount: 5,
                      itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                      onRatingUpdate: (rating) => setState(() {
                            rate = rating;
                          }))
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      cubit.rateLawyer(rate!.toInt(), id);
                      if (cubit.rateSuccess == true) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('تقيم')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('الغاء')),
              ],
            ));
  }
}
