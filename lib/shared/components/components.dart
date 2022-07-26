import 'package:flutter/material.dart';
import 'package:lawyer/shared/styles/colors.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);

Widget defaultButton({
  final Function()? function,
  Color? background,
  String? text,
  Color? textColor,
  double textFontSize = 22.0,
  double width = double.infinity,
  double height = 0.0,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: background,
    ),
    child: MaterialButton(
      onPressed: function,
      child: Text(text!,
          style: TextStyle(color: textColor, fontSize: textFontSize),
          textAlign: TextAlign.center),
    ),
  );
}

Widget defaultTextField({
  TextEditingController? controller,
  IconData? suffixIcon,
  String? hintText,
  Widget? labelText,
  IconData? prefixIcon,
  Color? iconColor,
  required Color borderColor,
  FormFieldValidator? validate,
  TextInputType? type,
  int? maxLength,
  bool isPassword = false,
  bool read = false,
  void onChange(String value)?,
  void onSubmit(String value)?,
  Function()? suffixPressed,
}) {
  return TextFormField(
    cursorColor: mainColor,
    keyboardType: type,
    obscureText: isPassword,
    readOnly: read,
    onChanged: onChange,
    onFieldSubmitted: onSubmit,
    validator: validate,
    controller: controller,
    //maxLines: maxLength,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(10),
      fillColor: Colors.grey[200],
      filled: true,
      label: labelText,
      hintText: hintText,
      hintTextDirection: TextDirection.rtl,
      suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffixIcon,
            color: iconColor,
          )),
      prefixIcon: Icon(
        prefixIcon,
        color: iconColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(
          width: 1.0,
          color: borderColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(
          color: borderColor,
          width: 1.0,
        ),
      ),
    ),
  );
}
