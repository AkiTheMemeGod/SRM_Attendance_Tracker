import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<Map<String, dynamic>> attendanceData = [];
  List<String> subjects = ['cs1', 'cs2', 'cs3', 'cs4', 'cs5']; // Subjects

  // Fetch attendance data from the API
  Future<void> fetchAttendanceData() async {
    final response = await http.get(
      Uri.parse(
        'https://akithememegod.pythonanywhere.com/api/fetch_attendance',
      ),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 response, parse the data
      final List<dynamic> fetchedData = json.decode(response.body);

      setState(() {
        attendanceData =
            fetchedData.map((student) {
              return {
                "rollno":
                    student['rollno'].toString(), // Ensure rollno is a string
                "name": student['name'].toString(), // Ensure name is a string
                "attendance": student['attendance'], // Raw attendance data
              };
            }).toList();
      });
    } else {
      throw Exception('Failed to load attendance');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  Future<void> _refreshpage() async {
    setState(() {});
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refreshpage,
        height: 300,
        animSpeedFactor: 2,
        showChildOpacityTransition: true,

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              attendanceData.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            dataRowHeight: 60.0,
                            columnSpacing: 20.0,
                            horizontalMargin: 20.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Roll No',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              ...subjects.map(
                                (subject) => DataColumn(
                                  label: Text(
                                    subject,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            rows:
                                attendanceData.map((student) {
                                  return DataRow(
                                    color: MaterialStateProperty.resolveWith<
                                      Color?
                                    >((states) {
                                      // Alternate row colors
                                      if (attendanceData.indexOf(student) % 2 ==
                                          0) {
                                        return Colors
                                            .grey[200]; // Light gray for even rows
                                      }
                                      return Colors.white; // White for odd rows
                                    }),
                                    cells: [
                                      DataCell(
                                        Text(
                                          student['rollno'],
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          student['name'],
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      ...subjects.map((subject) {
                                        int index = subjects.indexOf(subject);
                                        String attendanceStatus =
                                            (student['attendance'][index] ??
                                                    'Absent')
                                                .toString();
                                        return DataCell(
                                          Text(
                                            attendanceStatus,
                                            style: TextStyle(
                                              color:
                                                  attendanceStatus == '0'
                                                      ? Colors.red
                                                      : Colors.green,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  );
                                }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}
