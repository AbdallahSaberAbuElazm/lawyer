import 'package:flutter/material.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckInternetConnection.checkUserConnection(context: context);
    return const Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(
            child: Text('ReservationScreen'),
          ),
        ));
  }
}
