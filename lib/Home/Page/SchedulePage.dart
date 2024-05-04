import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  // List of weekdays
  final List<String> _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  void _showDateTimePicker(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }

    if (type == 'start') {
      final TimeOfDay? startTimePicked = await showTimePicker(
        context: context,
        initialTime: _startTime,
      );

      if (startTimePicked != null && startTimePicked != _startTime) {
        setState(() {
          _startTime = startTimePicked;
        });
      }
    } else {
      final TimeOfDay? endTimePicked = await showTimePicker(
        context: context,
        initialTime: _endTime,
      );

      if (endTimePicked != null && endTimePicked != _endTime) {
        setState(() {
          _endTime = endTimePicked;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng kí ca làm'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chọn ngày trong tuần:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            DropdownButton<String>(
              value: _weekdays[0], // Default to Monday
              onChanged: (String? newValue) {
                setState(() {
                  // Update selected date based on selected weekday
                  _selectedDate = DateTime.now().subtract(Duration(days: DateTime.now().weekday - _weekdays.indexOf(newValue!)));
                });
              },
              items: _weekdays.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Chọn giờ bắt đầu:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () => _showDateTimePicker(context, 'start'),
              child: Text(
                '${_startTime.hour}:${_startTime.minute}',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Chọn giờ kết thúc:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () => _showDateTimePicker(context, 'end'),
              child: Text(
                '${_endTime.hour}:${_endTime.minute}',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Thực hiện lưu thông tin ca làm
              },
              child: Text('Đăng kí'),
            ),
          ],
        ),
      ),
    );
  }
}
