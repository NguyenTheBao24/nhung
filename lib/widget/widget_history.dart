import 'package:flutter/material.dart';

class DayListWidget extends StatelessWidget {
  final String day;
  final List<Map<String, dynamic>> dayData;

  DayListWidget({required this.day, required this.dayData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(bottom: 0, left: 5),
          title: Text(
            'Ngày: $day',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...dayData.map((item) {
          return ListTile(
            contentPadding: EdgeInsets.only(left: 16, top: 0),
            title: Row(
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.circle,
                    size: 5,
                  ),
                  radius: 5,
                ),
                SizedBox(width: 5),
                Text(item['user']),
              ],
            ),
            subtitle: Text(item['time']),
          );
        }).toList(),
      ],
    );
  }
}
