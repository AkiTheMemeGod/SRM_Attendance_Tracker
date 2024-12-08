import 'package:attendancetracker/addstudent.dart';
import 'package:attendancetracker/attendance.dart';
import 'package:attendancetracker/auth/auth_service.dart';
import 'package:attendancetracker/markpresent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHome extends StatelessWidget {
  AdminHome({super.key});
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CS B Attendance",
          style: GoogleFonts.breeSerif(fontSize: 19),
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("lib/assets/Srmseal.png", scale: 4),
                      Text(
                        'CYBER SECURITY B \nAttendance Manager',
                        style: GoogleFonts.breeSerif(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text(
                    'Add Student',
                    style: GoogleFonts.breeSerif(fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddStudentPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text(
                    'View Attendance',
                    style: GoogleFonts.breeSerif(fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AttendancePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.mark_chat_read),
                  title: Text(
                    'Mark Attendance',
                    style: GoogleFonts.breeSerif(fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MarkPresentPage(),
                      ),
                    );
                  },
                ),
              ],
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout', style: GoogleFonts.breeSerif(fontSize: 19)),
              onTap: () => _authService.signout(),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('SRM', style: GoogleFonts.breeSerif(fontSize: 40)),
            SizedBox(height: 40),

            Image.asset("lib/assets/Srmseal.png", scale: 2),
            SizedBox(height: 40),
            Text(
              'CS B Attendance Manager',
              style: GoogleFonts.breeSerif(fontSize: 23),
            ),
          ],
        ),
      ),
    );
  }
}
