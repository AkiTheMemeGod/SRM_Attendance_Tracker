import 'package:attendancetracker/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: "https://yvyjdikfwbeizyygqphb.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl2eWpkaWtmd2JlaXp5eWdxcGhiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE1Njk2NzgsImV4cCI6MjA0NzE0NTY3OH0.AmbV8VeUvTDd8K6kIlo4fesJyLYuGMcjnjddogHBOvw",
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Attendance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthGate(),
    );
  }
}
