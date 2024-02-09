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
    print('thacong');
  }
}

Future<void> createUser() async {
    final response = await http.post(
    Uri.parse("https://chanlepro.online/api/v1/secure/5555"),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('dell thành công');
  }
}


Future<List<Map<String, dynamic>>> fetHistory() async {
  final response = await http.get(
    Uri.parse("https://chanlepro.online/api/v1/history"),
    headers: {"Accept": "application/json; charset=utf-8"},
  );

  if (response.statusCode == 200) {
    List<Map<String, dynamic>> historyData = [];
    List<dynamic> responseData = jsonDecode(response.body)['data'];

    for (var item in responseData) {
      String dateTimeString = item['time'].toString();
      String date = dateTimeString.split('T')[0];
      String time = dateTimeString.split('T')[1].substring(0, 8);
      Map<String, dynamic> data = {
        'day': date,
        'user': item['user']['username'],
        'time': time,
      };
      historyData.add(data);
    }

    print(historyData);

    return historyData;
  } else {
    throw Exception('Failed to load data');
  }
}
