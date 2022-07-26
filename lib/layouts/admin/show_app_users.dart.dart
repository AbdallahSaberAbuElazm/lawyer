import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lawyer/shared/styles/colors.dart';
import 'package:lawyer/shared/widgets/check_internet_connection.dart';

class ShowAppUsers extends StatefulWidget {
  final String hint;
  final List users;
  const ShowAppUsers({Key? key, required this.hint, required this.users})
      : super(key: key);

  @override
  State<ShowAppUsers> createState() => _ShowAppUsersState();
}

class _ShowAppUsersState extends State<ShowAppUsers> {
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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.hint),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: mainColor,
                        backgroundImage: widget.users[index].photo
                                .toString()
                                .isNotEmpty
                            ? NetworkImage(widget.users[index].photo.toString())
                            : const NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCvPW4n2sq5EZhgjLF3U0iEZAMfkAE-J0nOA&usqp=CAU')
                                as ImageProvider,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          widget.users[index].username.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      color: mainColor,
                    ),
                itemCount: widget.users.length),
          )),
    );
  }
}
