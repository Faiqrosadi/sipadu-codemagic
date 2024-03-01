import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class JadwalScreen extends StatefulWidget {
  @override
  _JadwalScreenState createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  late List<Appointment> _appointments = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    _fetchEventData();
  }

  Future<void> _fetchEventData() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final url = Uri.https('api.sipadu.dev', '/jadwal/mahasiswa', {
      'interval': 'monthly',
      'moveBy': '0',
    },
    );

      final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Appointment> appointments = [];
      for (var data in jsonData) {
        String subject = '(${data['matkul']['displayName']}) ${data['matkul']['namaMatkul']}';
        appointments.add(Appointment(
          startTime: DateTime.parse(data['startDate']),
          endTime: DateTime.parse(data['endDate']),
          subject: subject,
          color: Colors.blue,
        ));
      }
      setState(() {
        _appointments = appointments;
      });
    } else {
      throw Exception('Failed to load events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal'),
      ),
      body: _appointments != null
          ? SfCalendar(
              timeZone: 'Asia/Jakarta',
              view: CalendarView.workWeek,
              showDatePickerButton: true,
              showTodayButton: true,
              allowViewNavigation: true,
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
              allowedViews: const [
                CalendarView.day,
                CalendarView.workWeek,
                CalendarView.month,
              ],
              timeSlotViewSettings: const TimeSlotViewSettings(
                startHour: 7,
                endHour: 19,
                timeFormat: 'HH.mm',
                timeIntervalHeight: -1,
              ),
              dataSource: _DataSource(_appointments),
              todayHighlightColor: Colors.blue,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
