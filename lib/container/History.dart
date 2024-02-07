import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nhung/api/mqtt_services.dart';

class HistoryWidget extends StatefulWidget {
  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  String? selectedDate;

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
                  borderRadius:
                      BorderRadius.circular(8.0), // Đặt giá trị theo ý muốn
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
                              selectedDate =
                                  pickedDate.toString().split(' ')[0];
                            });
                          }
                        },
                        child: Text('Chọn ngày'),
                      ),
                    ),
                  ),

                  // Thêm các mục khác nếu cần
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

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      String date = data[index]['day'];
                      List<Map<String, dynamic>> dayData = data[index]['users'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.only(bottom: 0, left: 5),
                            title: Text(
                              'Ngày: $date',
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
                                  Text(item['username']),
                                ],
                              ),
                              subtitle: Text(item['time']),
                            );
                          }).toList(),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
