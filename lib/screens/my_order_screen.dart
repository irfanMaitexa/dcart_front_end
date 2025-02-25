import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_grocery_app_ui/baseurl.dart'; // For jsonDecode

class CustomerOrdersScreen extends StatefulWidget {
  final int customerId;

  CustomerOrdersScreen({required this.customerId});

  @override
  _CustomerOrdersScreenState createState() => _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState extends State<CustomerOrdersScreen> {
  List<dynamic> orders = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCustomerOrders();
  }

  Future<void> fetchCustomerOrders() async {
    final url = Uri.parse('$baseUrl/orders/customer/${widget.customerId}/'); // Replace with your backend URL

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the response data
        final data = jsonDecode(response.body);
        setState(() {
          orders = data;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load orders. Please try again.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred. Please check your connection.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        backgroundColor: Colors.green, // Green app bar
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // White background
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.green)) // Green loading indicator
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
                : orders.isEmpty
                    ? Center(child: Text('No orders found.', style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          var order = orders[index];
                          String orderId = order['id'].toString();
                          String status = order['status'];
                          String totalPrice = '\$${order['total_price']}';
                          String createdAt = order['created_at'];

                          return Card(
                            elevation: 2,
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              leading: Icon(Icons.shopping_bag, color: Colors.green), // Green icon
                              title: Text('Order #$orderId', style: TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  Text('Status: completed', style: TextStyle(color: _getStatusColor(status))),
                                  SizedBox(height: 4),
                                  Text('Total: $totalPrice'),
                                  SizedBox(height: 4),
                                  Text('Ordered on: ${createdAt.split('T')[0]}'),
                                ],
                              ),
                             
                            ),
                          );
                        },
                      ),
      ),
    );
  }

  // Helper function to get status color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Shipped':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}