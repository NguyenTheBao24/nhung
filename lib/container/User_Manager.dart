import 'package:flutter/material.dart';
import 'package:nhung/api/mqtt_services.dart';
import 'package:nhung/widget/add.dart';

class UserWidget extends StatefulWidget {
  @override
  _LockWidgetState createState() => _LockWidgetState();
}

class _LockWidgetState extends State<UserWidget> {
  bool _showTemporaryUsers = false; // Biến để theo dõi lựa chọn của người dùng

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppBar(
            title: Text('User'),
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            toolbarHeight: 70,
            actions: [
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ElevatedButton(
                          onPressed: () async {
                            // Xử lý khi nhấn vào nút "User"
                            setState(() {
                              _showTemporaryUsers =
                                  false; // Đặt biến để hiển thị người dùng tạm thời là false
                            });
                            Navigator.pop(context); // Đóng PopupMenuButton
                          },
                          child: Text('User'),
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ElevatedButton(
                          onPressed: () async {
                            // Xử lý khi nhấn vào nút "Temporary User"
                            setState(() {
                              _showTemporaryUsers =
                                  true; // Đặt biến để hiển thị người dùng tạm thời là true
                            });
                            Navigator.pop(context); // Đóng PopupMenuButton
                          },
                          child: Text('Temporary User'),
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ElevatedButton(
                          onPressed: () async {
                            _showAddUserDialog(context);
                            
                          },
                          
                          child: Text('Add User'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchUsersWithTemporaryTrue(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<Map<String, dynamic>> _users = snapshot.data!;

                  // Lọc danh sách người dùng dựa trên lựa chọn của người dùng
                  List<Map<String, dynamic>> filteredUsers = _showTemporaryUsers
                      ? _users
                          .where((user) => user['temporaryCode'] == true)
                          .toList()
                      : _users
                          .where((user) => user['temporaryCode'] == false)
                          .toList();

                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredUsers[index]['username'] ??
                                    'Unknown User',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  height:
                                      4), // Khoảng cách giữa tên người dùng và passcode
                              Text(
                                'Passcode: ${"*****" ?? "****"}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showAddUserDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AddUserDialog(); // Trả về AddUserDialog từ file add_user_dialog.dart
    },
  );
}
