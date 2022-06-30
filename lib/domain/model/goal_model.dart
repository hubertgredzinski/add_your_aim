import 'package:intl/intl.dart';

class GoalModel {
  GoalModel(
      {
      required this.id,
      required this.title,
      required this.imageURL,
      required this.goal,
      required this.unit,
      required this.endDate});

  final String id;
  final String title;
  final String imageURL;
  final String goal;
  final String unit;
  final DateTime endDate;

  String daysLeft() {
    return endDate.difference(DateTime.now()).inDays.toString();
  }

  String endDateFormatted() {
    return DateFormat.yMMMMEEEEd().format(endDate);
  }
}
