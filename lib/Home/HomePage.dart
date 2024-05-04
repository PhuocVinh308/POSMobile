import 'package:employeeapp/Home/Page/SchedulePage.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'Page/ProfilePage.dart';
import 'Page/GiaiTrinhPage.dart';

class HomePage extends StatefulWidget {
  final String token;
  final String username; // Thêm trường username

  const HomePage({Key? key, required this.token, required this.username}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getPage(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Đăng kí ca làm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Lịch làm việc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Thông tin',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildSchedulePage();
      case 2:
        return _buildTasksPage();
      case 3:
        return _buildProfilePage(context);
      default:
        return Container();
    }
  }

  Widget _buildHomePage() {
    return Center(child: Text('Home Page'));
  }

  Widget _buildTasksPage() {
    return Center(child: Text('Tasks Page'));
  }

  Widget _buildSchedulePage() {
    return SchedulePage();
  }

  Widget _buildProfilePage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0), // Padding chung cho GridView
      child: GridView.count(
        crossAxisCount: 2, // Số lượng cột trong lưới
        crossAxisSpacing: 5.0, // Khoảng cách giữa các cột
        mainAxisSpacing: 5.0, // Khoảng cách giữa các hàng
        children: [
          _buildFunctionItem(context, 'Thông tin nhân viên', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(token: widget.token, username: widget.username), // Sử dụng widget.token và widget.username
              ),
            );
          }, Icons.person),
          _buildFunctionItem(context, 'Giải trình', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GiaiTrinhPage(),
              ),
            );
          }, Icons.mail),
          _buildFunctionItem(context, 'Đăng xuất', () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          }, Icons.logout),
        ],
      ),
    );
  }

  Widget _buildFunctionItem(BuildContext context, String title, VoidCallback onPressed, IconData icon) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: Colors.blue,
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
