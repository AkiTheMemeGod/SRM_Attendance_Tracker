import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api_service.dart';

class MarkPresentPage extends StatefulWidget {
  @override
  _MarkPresentPageState createState() => _MarkPresentPageState();
}

class _MarkPresentPageState extends State<MarkPresentPage> {
  List<String> rollNumbers = [];
  List<String> selectedRollNumbers = [];
  String? selectedSubject;

  @override
  void initState() {
    super.initState();
    _fetchRollNumbers(); // Fetch the roll numbers on init
  }

  void _markAbsent() async {
    if (selectedSubject == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a subject')));
      return;
    }

    try {
      var response = await ApiService().markOnlyAbsent(
        selectedRollNumbers, // Pass the selected roll numbers
        selectedSubject!,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Marked as Absent!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // Fetch roll numbers from API
  void _fetchRollNumbers() async {
    try {
      var fetchedRollNumbers = await ApiService().fetchrolls();
      setState(() {
        rollNumbers = fetchedRollNumbers;
      });
    } catch (e) {
      print("Error fetching roll numbers: $e");
    }
  }

  // Mark the selected roll numbers as present
  void _markPresent() async {
    if (selectedRollNumbers.isEmpty || selectedSubject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select roll numbers and subject')),
      );
      return;
    }

    try {
      await ApiService().markOnlyPresent(selectedRollNumbers, selectedSubject!);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Marked as Present!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Mark Attendance',
          style: GoogleFonts.breeSerif(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Dropdown
            Text(
              'Select Subject:',
              style: GoogleFonts.breeSerif(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedSubject,
              onChanged: (String? newSubject) {
                setState(() {
                  selectedSubject = newSubject;
                });
              },
              decoration: InputDecoration(
                labelText: 'Subject',
                labelStyle: GoogleFonts.breeSerif(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              items:
                  ['cs1', 'cs2', 'cs3', 'cs4', 'cs5'].map((subject) {
                    return DropdownMenuItem<String>(
                      value: subject,
                      child: Text(
                        subject,
                        style: GoogleFonts.breeSerif(color: Colors.black87),
                      ),
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),

            // Title for roll numbers selection
            Text(
              'Select Roll Numbers:',
              style: GoogleFonts.breeSerif(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),

            // Roll Number Checkboxes
            Expanded(
              child: ListView.builder(
                itemCount: rollNumbers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          rollNumbers[index],
                          style: GoogleFonts.breeSerif(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        value: selectedRollNumbers.contains(rollNumbers[index]),
                        onChanged: (bool? isSelected) {
                          setState(() {
                            if (isSelected == true) {
                              selectedRollNumbers.add(rollNumbers[index]);
                            } else {
                              selectedRollNumbers.remove(rollNumbers[index]);
                            }
                          });
                        },
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        controlAffinity: ListTileControlAffinity.leading,
                        tileColor: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // Mark as Present Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _markPresent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 66, 209, 73),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Mark as Present',
                    style: GoogleFonts.breeSerif(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _markAbsent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Mark as Absent',
                    style: GoogleFonts.breeSerif(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
