import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  final String token;
  final String username;

  const ProfilePage({Key? key, required this.token, required this.username}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Employee> _futureEmployee;

  @override
  void initState() {
    super.initState();
    _futureEmployee = fetchEmployee(widget.username);
  }

  Future<Employee> fetchEmployee(String username) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/api/employees/account?account=$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      return Employee.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load employee');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin nhân viên'),
      ),
      body: Center(
        child: FutureBuilder<Employee>(
          future: _futureEmployee,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue[400],
                            child: Text(
                              snapshot.data!.name[0], // Lấy chữ cái đầu của tên
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildProfileInfo('Họ và tên', snapshot.data!.name),
                            _buildProfileInfo('CCCD', snapshot.data!.cccd),
                            _buildProfileInfo('Số điện thoại', snapshot.data!.phoneNumber),
                            _buildProfileInfo('Chức vụ', snapshot.data!.position),
                            _buildProfileInfo('Ngày sinh', _formatDate(snapshot.data!.dob)),
                          ],
                        ),
                      ),
                      // Khoảng trống dưới cùng
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }


  Widget _buildProfileInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(date);
  }
}

class Employee {
  final String name;
  final String cccd;
  final String phoneNumber;
  final String position;
  final String dob;

  Employee({
    required this.name,
    required this.cccd,
    required this.phoneNumber,
    required this.position,
    required this.dob,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['fullName'],
      cccd: json['cccd'],
      phoneNumber: json['phoneNumber'],
      position: json['position'],
      dob: json['dob'],
    );
  }
}
