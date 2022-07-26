// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lawyer/shared/components/components.dart';
// import 'package:lawyer/shared/styles/colors.dart';

// class Footer extends StatelessWidget {
//   const Footer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     ScreenUtil.init(context,
//         // BoxConstraints(
//         //   maxWidth: MediaQuery.of(context).size.width,
//         //   maxHeight: MediaQuery.of(context).size.height,
//         // ),
//         designSize: Size(width, height),
//         minTextAdapt: true,
//         orientation: Orientation.portrait);
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.arrow_back_ios,
//             size: 32,
//           ),
//           defaultButton(
//               background: mainColor,
//               textColor: Colors.white,
//               function: () {},
//               text: 'الرجوع',
//               textFontSize: 20.sp,
//               width: 140.w,
//               height: 40.h)
//         ],
//       ),
//     );
//   }
// }
