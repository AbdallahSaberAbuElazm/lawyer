import 'package:flutter/material.dart';
import 'package:lawyer/shared/styles/colors.dart';

class Utils {
  static snackBar({required BuildContext context, required String? msg}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg!,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      backgroundColor: Colors.white,
    ));
  }

  static showDialogOnWillPop({required BuildContext context}) async {
    return showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(
            'هل انت متأكد ؟',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          content: Text('هل تريد الخروج من التطبيق ؟',
              style: Theme.of(context).textTheme.headline6),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('لا',
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('نعم',
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }

  static List categories = [
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
}
