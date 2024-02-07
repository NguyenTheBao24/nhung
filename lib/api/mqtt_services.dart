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
    List<Map<String, dynamic>> historyData = [];
    List<dynamic> responseData = jsonDecode(response.body)['data'];

    for (var item in responseData) {
      Map<String, dynamic> data = {
        'user': {'username': item['user']['username']},
        'time': item['time'],
      };
      historyData.add(data);
    }

    print(historyData);

    return historyData;
  } else {
    throw Exception('Failed to load data');
  }
}
