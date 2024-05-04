import 'package:flutter/material.dart';

class GiaiTrinhPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giải trình cho sếp'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lý do cần giải trình:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Ghi rõ lý do hoặc vấn đề cần giải trình cho sếp.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Chi tiết giải trình:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Nhập chi tiết giải trình...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Thực hiện hành động khi nhấn nút gửi
                // Ví dụ: gửi dữ liệu đi
              },
              child: Text('Gửi'),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
