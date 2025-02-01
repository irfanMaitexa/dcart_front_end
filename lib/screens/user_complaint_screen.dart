import 'package:flutter/material.dart';

class ComplaintListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint List'),
        centerTitle: true,
        backgroundColor: Colors.green.shade400, // Light green app bar
        elevation: 5,
      ),
      body: ListView.builder(
        itemCount: 10, // Dummy data
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.green.shade50, // Light green card background
            child: ListTile(
              leading: Icon(Icons.report_problem, color: Colors.green.shade800), // Dark green icon
              title: Text(
                'Complaint ${index + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green.shade900, // Dark green text
                ),
              ),
              subtitle: Text(
                'Description of complaint ${index + 1}',
                style: TextStyle(
                  color: Colors.green.shade700, // Medium green text
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.green.shade800), // Dark green icon
              onTap: () {
                _showComplaintDetailsDialog(context, index + 1);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddComplaintDialog(context);
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green.shade400, // Light green FAB
        elevation: 5,
      ),
    );
  }

  // Function to show the "Add Complaint" pop-up form
  void _showAddComplaintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Add Complaint',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800, // Dark green text
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Complaint Title',
                  labelStyle: TextStyle(color: Colors.green.shade800), // Dark green label
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green.shade800), // Dark green border
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Complaint Description',
                  labelStyle: TextStyle(color: Colors.green.shade800), // Dark green label
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green.shade800), // Dark green border
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red), // Red cancel button
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic to submit the complaint
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Complaint submitted successfully!'),
                    backgroundColor: Colors.green.shade400, // Light green snackbar
                  ),
                );
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800, // Dark green button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to show the complaint details dialog
  void _showComplaintDetailsDialog(BuildContext context, int complaintId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Complaint Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800, // Dark green text
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Complaint ID: $complaintId',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green.shade900, // Dark green text
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800, // Dark green text
                ),
              ),
              Text(
                'This is the detailed description of complaint $complaintId. You can add more details here.',
                style: TextStyle(
                  color: Colors.green.shade700, // Medium green text
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Close',
                style: TextStyle(color: Colors.green.shade800), // Dark green text
              ),
            ),
          ],
        );
      },
    );
  }
}