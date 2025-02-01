import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_grocery_app_ui/baseurl.dart'; // Ensure this file contains your base URL

class ViewProductScreen extends StatefulWidget {
  @override
  _ViewProductScreenState createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  List<Map<String, dynamic>> _products = []; // List to store products
  bool _isLoading = true; // Track loading state
  String _errorMessage = ''; // Track error messages

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch products when the screen loads
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true; // Start loading
      _errorMessage = ''; // Clear any previous error messages
    });

    try {
      final response = await http.get(Uri.parse('$baseUrl/api/products/'));

      if (response.statusCode == 200) {
        // Parse the response data
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _products = data.cast<Map<String, dynamic>>(); // Update products list
        });
      } else {
        // Handle server errors
        setState(() {
          _errorMessage = 'Failed to load products. Please try again later.';
        });
      }
    } catch (e) {
      // Handle network or other exceptions
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/products/$productId/delete/'),
      );

      if (response.statusCode == 204) {
        // Product deleted successfully
        setState(() {
          _products.removeWhere((product) => product['id'] == productId);
        });
        _fetchProducts();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product deleted successfully!'),
            backgroundColor: Colors.green[800],
          ),
        );
      } else {
        // Handle server errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete product. Please try again later.'),
            backgroundColor: Colors.red[400],
          ),
        );
      }
    } catch (e) {
      // Handle network or other exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red[400],
        ),
      );
    }
  }
  Future<void> _updateStock(String productId, int newStock) async {
  try {
    final response = await http.patch(
      Uri.parse('$baseUrl/api/products/$productId/update-stock/'),
      headers: {
        'Content-Type': 'application/json', // Set content type to JSON
      },
      body: json.encode({
        'stock': newStock, // Send stock value in the request body
      }),
    );
    

    if (response.statusCode == 200) {
      // Stock updated successfully
      setState(() {
        final productIndex = _products.indexWhere((product) => product['id'] == productId);
        if (productIndex != -1) {
          _products[productIndex]['stock'] = newStock;
        }
      });

      _fetchProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Stock updated successfully!'),
          backgroundColor: Colors.green[800],
        ),
      );
    } else {
      // Handle server errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update stock. Please try again later.'),
          backgroundColor: Colors.red[400],
        ),
      );
    }
  } catch (e) {
    // Handle network or other exceptions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred: $e'),
        backgroundColor: Colors.red[400],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Products', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.white],
          ),
        ),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.green[800],
                ),
              )
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      _errorMessage,
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  )
                : _products.isEmpty
                    ? Center(
                        child: Text(
                          'No products available.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          return Card(
                            elevation: 4,
                            margin: EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: Colors.white, // White card background
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (product['image'] != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        '$baseUrl${product['image']}',
                                        width: double.infinity,
                                        height: 100, // Reduced image height
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  SizedBox(height: 8),
                                  Text(
                                    product['name'],
                                    style: TextStyle(
                                      fontSize: 18, // Smaller font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    product['description'],
                                    style: TextStyle(
                                      fontSize: 14, // Smaller font size
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Divider(color: Colors.grey[300], thickness: 1, height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        'Price: \$${product['price']})}',
                                        style: TextStyle(
                                          fontSize: 14, // Smaller font size
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'Stock: ${product['stock']}',
                                        style: TextStyle(
                                          fontSize: 14, // Smaller font size
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Open a dialog to update stock
                                            _showUpdateStockDialog(product['id'].toString(), product['stock']);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue[400], // Blue button
                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            'Update Stock',
                                            style: TextStyle(
                                              fontSize: 14, // Smaller font size
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () => _deleteProduct(product['id'].toString()),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red[400], // Red button
                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                              fontSize: 14, // Smaller font size
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }

  void _showUpdateStockDialog(String productId, int currentStock) {
    final _stockController = TextEditingController(text: currentStock.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Stock', style: TextStyle(color: Colors.green[800])),
          content: TextField(
            controller: _stockController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'New Stock',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.green[800])),
            ),
            TextButton(
              onPressed: () {
                final newStock = int.tryParse(_stockController.text);
                if (newStock != null) {
                  _updateStock(productId, newStock);
                  Navigator.pop(context); // Close the dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a valid stock number.'),
                      backgroundColor: Colors.red[400],
                    ),
                  );
                }
              },
              child: Text('Update', style: TextStyle(color: Colors.green[800])),
            ),
          ],
        );
      },
    );
  }
}