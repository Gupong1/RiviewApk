import 'package:flutter/material.dart';
import 'dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GengarCloud',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF060B14),
        useMaterial3: true,
      ),
      home: DashboardPage(
        username: 'DemoUser',
        password: 'demo123',
        role: 'admin',
        expiredDate: '2026-12-31',
        sessionKey: 'demo-session-123',
        listBug: [],
        listDoos: [],
        news: [
          {
            'title': 'Selamat Datang di GengarCloud',
            'desc': 'Ini adalah tampilan dashboard dengan tema merah',
          },
          {
            'title': 'Fitur Baru Tersedia',
            'desc': 'Nikmati berbagai fitur terbaru kami',
          },
          {
            'title': 'Tips & Trik',
            'desc': 'Pelajari cara maksimalkan penggunaan',
          },
        ],
      ),
    );
  }
}
