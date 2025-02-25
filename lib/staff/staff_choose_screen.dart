import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/staff/add_product_screen.dart';
import 'package:online_grocery_app_ui/staff/view_feedback_screen.dart';
import 'package:online_grocery_app_ui/staff/view_report.dart';

import 'staff_view_product_screen.dart';

class StaffDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[800],
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // White background for the body
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildOptionCard(
                context,
                title: 'Add Product',
                icon: Icons.add_circle_outline,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen(),));
                 
                },
              ),
              SizedBox(height: 20),
              _buildOptionCard(
                context,
                title: 'View Feedback',
                icon: Icons.feedback_outlined,
                onTap: () {
                 

                 Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen(),));

                },
              ),
              SizedBox(height: 20),
              _buildOptionCard(
  context,
  title: 'View Products', // Updated title
  icon: Icons.list_alt_outlined, // Updated icon
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewProductScreen()),
    );
  },
),
 SizedBox(height: 20),

              _buildOptionCard(
                context,
                title: 'Sales Report',
                icon: Icons.bar_chart_outlined,
                onTap: () {
                  

                   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SalesReportScreen()),
    );
                  // Navigate to Sales Report Screen
                  print('Navigate to Sales Report Screen');
                },
              ),
              Spacer(), // Pushes the Logout button to the bottom
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.green[50], // Light green background for cards
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.green[800]), // Dark green icon
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  color: Colors.green[800], // Dark green text
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.green[800]), // Dark green arrow
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Perform logout action
          _showLogoutConfirmationDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[800], // Dark green background
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Logout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout', style: TextStyle(color: Colors.green[800])),
          content: Text('Are you sure you want to logout?', style: TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.green[800])),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action
                Navigator.pop(context); // Close the dialog
                _logout(context); // Call logout function
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    // Add your logout logic here
    print('User logged out');
    // Navigate to the login screen or perform other actions
    Navigator.pushReplacementNamed(context, '/login'); // Example: Navigate to login screen
  }
}