  import 'package:flutter/material.dart';

  class UserWidget extends StatefulWidget {
    @override
    _LockWidgetState createState() => _LockWidgetState();
  }

  class _LockWidgetState extends State<UserWidget> {
  

  
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
            
          ),
          // Expanded(child: null)
          
        ],
      ),
    );
 

    }
  }
