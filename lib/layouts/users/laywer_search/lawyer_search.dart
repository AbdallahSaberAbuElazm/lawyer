import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyer/controllers/user_controller.dart';
import 'package:lawyer/cubit/cubit.dart';
import 'package:lawyer/cubit/states.dart';
import 'package:lawyer/layouts/users/chat/chat_screen.dart';
import 'package:lawyer/layouts/users/laywer_search/lawyer_details.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/components/util.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class LawyerSearch extends StatefulWidget {
  const LawyerSearch({Key? key}) : super(key: key);

  @override
  State<LawyerSearch> createState() => _LawyerSearchState();
}

class _LawyerSearchState extends State<LawyerSearch> {
  late List list;
  late List filterLawyers = [];
  final _searchController = TextEditingController();
  final UserController _userController = Get.find();
  String? dropDownValue;

  @override
  void initState() {
    _userController.getAllLawyer();
    list = _userController.lawyers;
    setState(() {
      filterLawyers = list;
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  //filter location
  void _filterLawyerByName(value) {
    setState(() {
      filterLawyers =
          list.where((lawyer) => lawyer.username.contains(value)).toList();
    });
  }

  void _filterLawyerByCategory({required String categoryLawyer}) {
    setState(() {
      filterLawyers = list
          .where((lawyer) => lawyer.category.contains(categoryLawyer))
          .toList();
    });
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
        var cubit = LawyerCubits.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            centerTitle: true,
            leading: InkWell(
                onTap: () {
                  LawyerCubits.get(context).searchList = [];
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            title: Text(
              'Lawyer Online',
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              InkWell(
                onTap: () {
                  navigateTo(context, ChatScreen());
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
            backgroundColor: mainColor,
            elevation: 0.0,
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                      child: Text(
                    'ابدا استشارتك مع محامي الان',
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              _filterLawyerByName(value);
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.list),
                              hintText: 'ابحث بالاسم',
                              contentPadding: EdgeInsets.all(10),
                            )),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Flexible(
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(5),
                          hint: dropDownValue == null
                              ? const Text(
                                  'التخصص',
                                  style: TextStyle(fontSize: 18),
                                )
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
                            _filterLawyerByCategory(
                                categoryLawyer: val.toString());
                            setState(
                              () {
                                dropDownValue = val.toString();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  filterLawyers.length > 0
                      ? Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 1,
                                crossAxisSpacing: 2,
                                childAspectRatio: 1 / 0.8,
                                crossAxisCount: 2,
                              ),
                              itemCount: filterLawyers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        LawyerDetails(
                                          model: _userController.lawyers[index],
                                        ));
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.all(8),
                                    elevation: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  filterLawyers[index]
                                                              .username !=
                                                          null
                                                      ? filterLawyers[index]
                                                          .username
                                                      : '',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  filterLawyers[index]
                                                              .category !=
                                                          null
                                                      ? filterLawyers[index]
                                                          .category
                                                      : '',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                size: 60,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              RatingBar(
                                                  itemSize: 8,
                                                  initialRating: 3,
                                                  minRating: 1,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(horizontal: 2),
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
                                    ),
                                  ),
                                );
                              }),
                        )
                      : const Center(
                          child: Text('لا توجد نتائج'),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
