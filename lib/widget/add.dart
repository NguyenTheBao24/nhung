import 'package:flutter/material.dart';
import 'package:nhung/api/mqtt_services.dart';

class AddUserDialog extends StatefulWidget {
  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  String? userType = 'Regular';
  late TextEditingController passcodeController;

  @override
  void initState() {
    super.initState();
    passcodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    String username = '';
    String passcode = '';
    String accessCount = '';

    return AlertDialog(
      title: Text('Add User'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'User Type'),
            value: userType,
            onChanged: (value) {
              setState(() {
                userType = value;
              });
            },
            items: [
              DropdownMenuItem(
                value: 'Regular',
                child: Text('Regular User'),
              ),
              DropdownMenuItem(
                value: 'Temporary',
                child: Text('Temporary User'),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            onChanged: (value) {
              username = value;
            },
          ),
          if (userType == 'Regular')
            TextFormField(
              decoration: InputDecoration(labelText: 'Passcode'),
              controller: passcodeController,

              obscuringCharacter: '*', // Use '*' as the obscuring character
              obscureText: true, // Obscure the text
              keyboardType: TextInputType.number, // Set the keyboard type
            ),
          if (userType == 'Temporary')
            TextFormField(
              decoration: InputDecoration(labelText: 'Passcode'),
              controller: passcodeController,

              obscuringCharacter: '*', // Use '*' as the obscuring character
              obscureText: true, // Obscure the text
              keyboardType: TextInputType.number, // Set the keyboard type
            ),
          if (userType == 'Temporary')
            TextFormField(
              decoration: InputDecoration(labelText: 'AccessCount'),
              onChanged: (value) {
                // Loại bỏ bất kỳ ký tự nào không phải là số
                accessCount = value.replaceAll(RegExp(r'[^0-9]'), '');
              },
              keyboardType: TextInputType.number, // Đặt loại bàn phím cho số
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (passcodeController.text.length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Passcode must be at least 6 characters long'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              createUser(
                      username, passcodeController.text, userType, accessCount)
                  .then((notification) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(notification),
                    duration: Duration(seconds: 2),
                  ),
                );
                
                Navigator.of(context).pop();
              });
            }
          },
          child: Text('Add'),
        )
      ],
    );
  }
}
