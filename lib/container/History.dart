import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nhung/api/mqtt_services.dart';
import 'package:nhung/widget/widget_history.dart';

class HistoryWidget extends StatefulWidget {
  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  String? selectedDate;
  String? selectedDay; 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppBar(
            title: Text('History'),
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            toolbarHeight: 70,
            actions: [
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2025),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              selectedDay = pickedDate.toString().split(' ')[0];
                            });
                          }
                        },
                        child: Text('Chọn ngày'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetHistory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<Map<String, dynamic>> data = snapshot.data!;
                  Map<String, List<Map<String, dynamic>>> groupedData = {};

                  data.forEach((item) {
                    String day = item['day'];
                    if (!groupedData.containsKey(day)) {
                      groupedData[day] = [];
                    }
                    groupedData[day]!.add(item);
                  });

                  if (selectedDay == null) {
                    return ListView.builder(
                      itemCount: groupedData.length,
                      itemBuilder: (context, index) {
                        String day = groupedData.keys.toList()[index];
                        List<Map<String, dynamic>> dayData = groupedData[day]!;
                        return DayListWidget(day: day, dayData: dayData);
                      },
                    );
                  } else {
                    if (groupedData.containsKey(selectedDay!)) {
                      List<Map<String, dynamic>> dayData =
                          groupedData[selectedDay!]!;
                      return DayListWidget(day: selectedDay!, dayData: dayData);
                    } else {
                      return Center(
                        child: Text('Không có dữ liệu cho ngày này.'),
                      );
                    }
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
