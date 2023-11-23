import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_schedules/models/schedule.dart';

import '../configs/configs.dart';

class ScheduleApiService {
  static Future<List<ScheduleModel>?> fetchSchedules() async {
    final res = await http.get(Uri.parse('$baseurl/list_schedule.php'));

    if (res.statusCode == 200) {
      final _response = jsonDecode(res.body);
      if (_response is Map) {
        return [];
      }
      final List items = jsonDecode(res.body);

      return items.map((e) => ScheduleModel.fromJson(e)).toList();
    }
    return null;
  }

  static Future<Map?> createSchedule(String date, String time, String doc_name,
      bool isOnline, String email) async {
    final res = await http.post(Uri.parse('$baseurl/create_schedule.php'),
        body: jsonEncode({
          'date': date,
          'time': time,
          'doc_name': doc_name,
          'online_meeting': isOnline ? 1 : 0,
          'email_cc': email,
        }));
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json;
    }
  }

  static Future<Map?> deleteSchedule(String id) async {
    final res = await http.post(
      Uri.parse('$baseurl/delete_schedule.php?id=$id'),
    );
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json;
    }
  }

  static Future<Map?> updateSchedule(String date, String time, String doc_name,
      bool isOnline, String email, String id) async {
    print({
      'date': date,
      'time': time,
      'doc_name': doc_name,
      'online_meeting': isOnline ? 1 : 0,
      'email_cc': email,
      'id': id
    });
    final res = await http.post(Uri.parse('$baseurl/update_schedule.php.php'),
        body: jsonEncode({
          'date': date,
          'time': time,
          'doc_name': doc_name,
          'online_meeting': isOnline ? 1 : 0,
          'email_cc': email,
          'id': id
        }));
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return json;
    }
  }
}
