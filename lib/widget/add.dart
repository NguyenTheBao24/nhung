import 'package:flutter/material.dart';

class AddUserDialog extends StatefulWidget {
  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  String? userType = 'Regular';

  @override
  Widget build(BuildContext context) {
    String username = '';
    String passcode = '';
    String passcodeTemporary = '';

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
              onChanged: (value) {
                passcode = value;
              },
            ),
          if (userType == 'Temporary')
            TextFormField(
              decoration: InputDecoration(labelText: 'Number of uses'),
              onChanged: (value) {
                passcodeTemporary = value;
              },
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
            print(
                'Username: $username, Passcode: $passcode, User Type: $userType');
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
