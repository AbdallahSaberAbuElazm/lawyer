import 'package:intl/intl.dart';

String userID = '';
String lawyerID = '';
String adminID = '';

String categoryID = '';

String parseDate(String? date) {
  return DateFormat.yMMMEd().format(DateTime.parse(date.toString()));
}
