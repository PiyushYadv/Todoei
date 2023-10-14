import 'package:flutter/material.dart';
import 'package:todoei/utils/date_time.dart';

class Date extends StatelessWidget {
  Date({super.key});

  final String month = EnhancedDateTime(dateTime).monthName;
  final String weekDay = EnhancedDateTime(dateTime).weekDayName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 75,
        left: 30,
      ),
      child: Row(
        children: [
          Text(
            '$weekDay,',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            ' ${DateTime.now().day} $month',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
    );
  }
}
