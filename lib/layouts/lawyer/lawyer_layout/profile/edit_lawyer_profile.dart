import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/cubit/states.dart';
import 'package:lawyer/layouts/lawyer/lawyer_layout/lawyer_layout.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class EditLawyerProfile extends StatefulWidget {
  const EditLawyerProfile({Key? key}) : super(key: key);

  @override
  State<EditLawyerProfile> createState() => _EditLawyerProfileState();
}

class _EditLawyerProfileState extends State<EditLawyerProfile> {
  TextEditingController yearsController = TextEditingController();

  TextEditingController datesController = TextEditingController();

  TextEditingController infoController = TextEditingController();
  List categories = [
    'الافلاس',
    'الملكيه الفكريه',
    'محامي العمل',
    'الاصابات الشخصيه',
    'التخطيط العماري',
    'الجنائي',
    'سوء الممارسة الطبية',
    'تعويض العمال',
    'الدعاوي المدنيه',
    'محامي عام'
  ];
  @override
  void initState() {
    super.initState();
    yearsController.text = LawyerCubits.get(context).model!.yearsExp!.isNotEmpty
        ? LawyerCubits.get(context).model!.yearsExp.toString()
        : '';
    datesController.text = LawyerCubits.get(context).model!.dates!.isNotEmpty
        ? LawyerCubits.get(context).model!.dates.toString()
        : '';
    infoController.text = LawyerCubits.get(context).model!.info!.isNotEmpty
        ? LawyerCubits.get(context).model!.info.toString()
        : '';

    category = LawyerCubits.get(context).model!.category.toString();
  }

  String? dropDownValue;
  String category = '';
  Future<bool> _onWillPopll() async {
    return (await Get.off(() => LawyerLayout()) ?? false);
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
        var cubit = LawyerCubits.get(context);

        return WillPopScope(
            onWillPop: _onWillPopll,
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                      appBar: AppBar(
                          centerTitle: true,
                          title: const Text('تعديل الملف الشخصي'),
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Get.off(() => LawyerLayout());
                            },
                          )),
                      body: Directionality(
                        textDirection: TextDirection.rtl,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundColor: mainColor,
                                      backgroundImage: cubit.fileProfileImage ==
                                              null
                                          ? NetworkImage(cubit.model!.photo!)
                                          : FileImage(cubit.fileProfileImage!)
                                              as ImageProvider,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cubit.getProfileImage();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[300],
                                        child: const Icon(
                                          Icons.image,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                // TextField(

                                //     controller: infoController,
                                //     decoration: const InputDecoration(
                                //       hintText: 'ابحث بالاسم',
                                //       contentPadding: EdgeInsets.all(10),
                                //     )),
                                defaultTextField(
                                    maxLength: 6,
                                    controller: infoController,
                                    borderColor: mainColor,
                                    labelText: const Text(
                                      'نبذة عنك',
                                      style: TextStyle(fontSize: 22),
                                    )),
                                SizedBox(
                                  height: 20.h,
                                ),
                                defaultTextField(
                                    controller: yearsController,
                                    borderColor: mainColor,
                                    labelText: const Text(
                                      'سنوات الخبرة',
                                      style: TextStyle(fontSize: 22),
                                    )),
                                SizedBox(
                                  height: 20.h,
                                ),
                                defaultTextField(
                                    controller: datesController,
                                    maxLength: 3,
                                    borderColor: mainColor,
                                    labelText: const Text(
                                      'مواعيد التفرغ',
                                      style: TextStyle(fontSize: 22),
                                    )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'التخصص',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: DropdownButton(
                                            hint: dropDownValue == null
                                                ? Text(
                                                    category.toString(),
                                                    style: TextStyle(
                                                        color: mainColor),
                                                  )
                                                : Text(
                                                    dropDownValue.toString(),
                                                    style: TextStyle(
                                                        color: mainColor),
                                                  ),
                                            isExpanded: true,
                                            iconSize: 30.0,
                                            style: TextStyle(color: mainColor),
                                            items: categories.map(
                                              (val) {
                                                return DropdownMenuItem<String>(
                                                  alignment: Alignment.topRight,
                                                  value: val,
                                                  child: Text(val),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (val) {
                                              setState(
                                                () {
                                                  dropDownValue =
                                                      val.toString();
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                if (state is LawyerUpdateProfileLoadingStates ||
                                    state is LawyerUpdateLoadingStates ||
                                    state
                                        is LawyerUpdateWithoutPhotoLoadingStates)
                                  LinearProgressIndicator(
                                    color: mainColor,
                                  ),
                                if (state is LawyerUpdateProfileLoadingStates ||
                                    state is LawyerUpdateLoadingStates ||
                                    state
                                        is LawyerUpdateWithoutPhotoLoadingStates)
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                defaultButton(
                                    function: () {
                                      if (cubit.fileProfileImage != null) {
                                        cubit.updateLawyerProfile(
                                            year: yearsController.text.trim(),
                                            dates: datesController.text.trim(),
                                            category: dropDownValue,
                                            info: infoController.text.trim());
                                      }
                                      if (cubit.fileProfileImage == null) {
                                        cubit.editLawyerDataWithoutProfile(
                                          year: yearsController.text.trim(),
                                          dates: datesController.text.trim(),
                                          category: dropDownValue,
                                          info: infoController.text.trim(),
                                        );
                                      }
                                    },
                                    background: mainColor,
                                    text: 'حفظ التعديلات',
                                    textColor: Colors.white,
                                    width: 160.w,
                                    height: 40.h),
                              ],
                            ),
                          ),
                        ),
                      )),
                )));
      },
    );
  }
}
