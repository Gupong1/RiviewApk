import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NIGHT Bug WhatsApp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF050810),
        useMaterial3: true,
      ),
      home: HomePage(
        username: 'NIGHT User',
        password: 'password',
        sessionKey: 'test_session_key',
        listBug: [
          {'bug_id': 'cspam', 'bug_name': 'C Spam'},
          {'bug_id': 'ios_invis', 'bug_name': 'iOS Invisible'},
          {'bug_id': 'text', 'bug_name': 'Text Message'},
        ],
        role: 'USER',
        expiredDate: '2026-12-31',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
