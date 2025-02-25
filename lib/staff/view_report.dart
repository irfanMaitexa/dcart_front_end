import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:online_grocery_app_ui/baseurl.dart';

class SalesReportScreen extends StatefulWidget {
  @override
  _SalesReportScreenState createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  List<dynamic> ordersList = [];
  bool isLoading = true;
  String? errorMessage;
  double totalSales = 0.0;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/orders/all/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        double sales = data.fold(0.0, (sum, order) => sum + double.parse(order['total_price'].toString()));
        print(data);

        setState(() {
          ordersList = data;
          totalSales = sales;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load orders');
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sales Report", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.green))
          : errorMessage != null
              ? Center(child: Text(errorMessage!, style: TextStyle(color: Colors.red, fontSize: 16)))
              : Column(
                  children: [
                    // Total Sales Summary
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Sales:", style: TextStyle(fontSize: 18, color: Colors.white)),
                              Text(
                                "₹${NumberFormat('#,##0.00').format(totalSales)}",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Sales Report Table
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                        child: DataTable(
                          border: TableBorder.all(width: 1, color: Colors.grey),
                          columns: [
                            DataColumn(label: Text('Order ID', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Customer ID', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Customer Name', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Total Price', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                          ],
                          rows: ordersList.map((order) {
                            return DataRow(cells: [
                              DataCell(Text(order['id'].toString())),
                              DataCell(Text(order['customer'] is Map ? order['customer']['name'] : "Customer #${order['customer']}")),
                              DataCell(Text(order['customer_name'])),
                              DataCell(Text("₹${NumberFormat('#,##0.00').format(double.parse(order['total_price'].toString()))}")),
                              DataCell(Text(order['created_at'].split('T')[0])),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
