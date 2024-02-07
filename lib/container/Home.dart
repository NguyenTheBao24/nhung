import 'package:flutter/material.dart';
import 'home/button_weve.dart';
import 'package:http/http.dart' as http;
import '../api/mqtt_services.dart';
import 'dart:convert';

class LockWidget extends StatelessWidget {
  const LockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const PrettyButtonsExample(),
    );
  }
}

class PrettyButtonsExample extends StatefulWidget {
  const PrettyButtonsExample({super.key});

  @override
  State<PrettyButtonsExample> createState() => _PrettyButtonsExampleState();
}

Future<void> onbutton() async {
  try {
    await Open('unlock');
  } catch (e) {}
}

class _PrettyButtonsExampleState extends State<PrettyButtonsExample> {
  final Color? scaffoldBg = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrettyWaveButton(
              child: const Text(
                'Open',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: onbutton,
            ),
          ],
        ),
      ),
    );
  
  }
}
