import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:online_grocery_app_ui/baseurl.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  List<dynamic> feedbackList = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchFeedback();
  }

  Future<void> fetchFeedback() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/feedback/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          feedbackList = data;
          isLoading = false;
        });

        print(feedbackList);
      } else {
        throw Exception('Failed to load feedback');
      }
    } catch (error) {
      setState(() {
        errorMessage = "Error: $error";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Customer Feedback", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.green))
          : errorMessage != null
              ? Center(child: Text(errorMessage!, style: TextStyle(color: Colors.red, fontSize: 16)))
              : ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: feedbackList.length,
                  itemBuilder: (context, index) {
                    var feedback = feedbackList[index];
                    return FeedbackCard(
                      customerName: feedback['customer_name'] is Map
                          ? feedback['customer']['name']
                          : "${feedback['customer_name']}",
                      message: feedback['message'],
                      rating: feedback['rating'],
                      createdAt: feedback['created_at'],
                    );
                  },
                ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final String customerName;
  final String message;
  final int rating;
  final String createdAt;

  FeedbackCard({
    required this.customerName,
    required this.message,
    required this.rating,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // White background for a clean look
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 6, // Soft shadow effect
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Name
            Row(
              children: [
                Icon(Icons.person, color: Colors.green, size: 22),
                SizedBox(width: 8),
                Text(
                  customerName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Message
            Text(
              message,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 10),

            // Rating and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBarIndicator(
                  rating: rating.toDouble(),
                  itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 20.0,
                ),
                Text(
                  createdAt.split('T')[0], // Extracts only the date part
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
