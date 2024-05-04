import 'package:flutter/material.dart';
import './Page/ProfilePage.dart';
import 'LoginPage.dart';

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
        return _buildTasksPage();
      case 2:
        return _buildSchedulePage();
      case 3:
        return _buildProfilePage(); // Không cần truyền context
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
    return Center(child: Text('Schedule Page'));
  }

  Widget _buildProfilePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(token: widget.token, username: widget.username),
                ),
              );
            },
            child: Text('Thông tin nhân viên'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }
}
