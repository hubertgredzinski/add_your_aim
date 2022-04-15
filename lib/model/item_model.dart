import 'package:intl/intl.dart';

class ItemModel {
  ItemModel(
      {required this.id,
      required this.title,
      required this.imageURL,
      required this.aim,
      required this.endDate});
  final String id;
  final String title;
  final String imageURL;
  final String aim;
  final DateTime endDate;

  String daysLeft() {
    return endDate.difference(DateTime.now()).inDays.toString();
  }

  String endDateFormatted() {
    return DateFormat.yMMMMEEEEd().format(endDate);
  }
}
