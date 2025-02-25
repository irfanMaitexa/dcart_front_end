import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_grocery_app_ui/baseurl.dart';


class ComplaintListScreen extends StatefulWidget {
  @override
  _ComplaintListScreenState createState() => _ComplaintListScreenState();
}

class _ComplaintListScreenState extends State<ComplaintListScreen> {
  late Future<List<Complaint>> complaints;

  @override
  void initState() {
    super.initState();
    complaints = ComplaintService.fetchComplaints('1234567890');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint List'),
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
        elevation: 5,
      ),
      body: FutureBuilder<List<Complaint>>(
        future: complaints,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load complaints'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No complaints available'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final complaint = snapshot.data![index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.green.shade50,
                child: ListTile(
                  leading: Icon(Icons.report_problem, color: Colors.green.shade800),
                  title: Text(complaint.subject, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green.shade900)),
                  subtitle: Text(complaint.message, style: TextStyle(color: Colors.green.shade700)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.green.shade800),
                  onTap: () => _showComplaintDetailsDialog(context, complaint),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddComplaintDialog(context),
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green.shade400,
        elevation: 5,
      ),
    );
  }

  // Show Add Complaint Dialog
  void _showAddComplaintDialog(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Complaint', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade800)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextField(
                controller: subjectController,
                decoration: InputDecoration(labelText: 'Subject', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextField(
                controller: messageController,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Message', border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: Colors.red))),
            ElevatedButton(
              onPressed: () async {
                bool success = await ComplaintService.submitComplaint(phoneController.text, subjectController.text, messageController.text);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Complaint submitted successfully'), backgroundColor: Colors.green.shade400));
                  setState(() {
                    complaints = ComplaintService.fetchComplaints(phoneController.text);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to submit complaint'), backgroundColor: Colors.red));
                }
                Navigator.pop(context);
              },
              child: Text('Submit', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
            ),
          ],
        );
      },
    );
  }

  // Show Complaint Details Dialog
  void _showComplaintDetailsDialog(BuildContext context, Complaint complaint) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Complaint Details', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade800)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${complaint.id}', style: TextStyle(fontSize: 16, color: Colors.green.shade900)),
              SizedBox(height: 10),
              Text('Subject: ${complaint.subject}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade800)),
              SizedBox(height: 5),
              Text(complaint.message, style: TextStyle(color: Colors.green.shade700)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Close', style: TextStyle(color: Colors.green.shade800))),
          ],
        );
      },
    );
  }
}
class Complaint {
  final int id;
  final String subject;
  final String message;
  final String status;
  final String createdAt;

  Complaint({
    required this.id,
    required this.subject,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      subject: json['subject'],
      message: json['message'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }
}


// Import the model

class ComplaintService {
  static const String base = '$baseUrl/api/complaints';

  // Fetch complaints list
  static Future<List<Complaint>> fetchComplaints(String phoneNumber) async {
  // Construct the URL with the phone number as a query parameter
  final uri = Uri.parse('$baseUrl/api/complaints').replace(
    queryParameters: {'phone': phoneNumber},
  );

  // Make the HTTP GET request
  final response = await http.get(uri);

  // Print the response body for debugging
  print(response.body);

  // Check if the request was successful
  if (response.statusCode == 200) {
    // Decode the JSON response
    List<dynamic> data = json.decode(response.body);

    // Map the JSON data to a list of Complaint objects
    return data.map((json) => Complaint.fromJson(json)).toList();
  } else {
    // Throw an exception if the request failed
    throw Exception('Failed to load complaints');
  }
}

  // Submit a new complaint
  static Future<bool> submitComplaint(String phone, String subject, String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/complaints/submit/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'subject': subject, 'message': message}),
    );
    return response.statusCode == 201;
  }
}
