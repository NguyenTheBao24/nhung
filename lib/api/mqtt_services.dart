import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:logger/logger.dart';

var logger = Logger();

Future Open(String endpoint) async {
  final response = await http.post(
    Uri.parse("https://chanlepro.online/sendMessage/$endpoint"),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('thanhwwcong');
  }
}

Future<List<Map<String, dynamic>>> fetHistory() async {
  final response = await http.get(
    Uri.parse("https://chanlepro.online/api/v1/history"),
    headers: {"Accept": "application/json; charset=utf-8"},
  );

  if (response.statusCode == 200) {
    List<Map<String, dynamic>> historyList = []; // Danh sách dữ liệu cuối cùng
    List<dynamic> responseData = jsonDecode(response.body);

    Map<String, Map<String, dynamic>> historyData = {};

    for (var item in responseData) {
      String itemDate = item['time'].toString().split('T')[0];

      if (!historyData.containsKey(itemDate)) {
        historyData[itemDate] = {
          'day': itemDate,
          'users': <Map<String, String>>[],
        };
      }

      historyData[itemDate]!['users'].add({
        'username': item['user']['username'],
        'time': item['time'],
      });
    }



    for (var entry in historyData.entries) {
      historyList.add(entry.value);
    }
    return historyList;
  } else {
    throw Exception('Failed to load dataxxxxx');
  }
}
