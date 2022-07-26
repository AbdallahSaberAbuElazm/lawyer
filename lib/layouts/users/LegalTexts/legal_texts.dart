import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyer/layouts/users/LegalTexts/pdf_render.dart';
import 'package:lawyer/shared/components/components.dart';
import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';
import 'package:lawyer/shared/widgets/user_drawer.dart';

class LegalTextsScreen extends StatelessWidget {
  List<QueryDocumentSnapshot<Object?>> list = [];
  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool val = false;
    ScreenUtil.init(context,
        // BoxConstraints(
        //   maxWidth: MediaQuery.of(context).size.width,
        //   maxHeight: MediaQuery.of(context).size.height,
        // ),
        designSize: Size(width, height),
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Lawyer Online',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: mainColor,
            elevation: 0.0,
          ),
          drawer: UserDrawer(),
          body: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25.w),
                  child: Center(
                    child: Text(
                      'النصوص القانونية المصرية',
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('legalTexts')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox.shrink();
                      }

                      if (snapshot.data!.docs.isNotEmpty) {
                        list = snapshot.data!.docs;

                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 1 / 0.6,
                              crossAxisCount: 2,
                            ),
                            itemCount: list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 248, 245, 245),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 8,
                                        blurRadius: 6,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]),
                                margin: const EdgeInsets.all(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: InkWell(
                                    onTap: () => navigateTo(
                                        context,
                                        PdfRender(
                                          fileName: list[index]['legalName'],
                                          url: list[index]['legalUrl'],
                                        )),
                                    child: Center(
                                      child: Text(
                                        list[index]['legalName'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 18.3.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
