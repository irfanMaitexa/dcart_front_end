import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/baseurl.dart';
import 'package:online_grocery_app_ui/screens/bottomnavigationbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonDecode

class CheckoutScreen extends StatefulWidget {
  final List<dynamic> cartItems;
  final double totalAmount;

  CheckoutScreen({required this.cartItems, required this.totalAmount});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Payment succeeded
    print("Payment Success: ${response.paymentId}");

    // Create an order after successful payment
    int customerId = 1; // Replace with the actual customer ID
    createOrder(customerId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Payment failed
    print("Payment Error: ${response.code} - ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // External wallet selected
    print("External Wallet: ${response.walletName}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet: ${response.walletName}")),
    );
  }

  Future<void> createOrder(int customerId) async {
    final url = Uri.parse('$baseUrl/orders/add/'); // Replace with your backend URL
    final headers = {'Content-Type': 'application/json'};

    // Prepare the cart items for the order
    List<Map<String, dynamic>> items = widget.cartItems.map((item) {

      print(item);
      return {
        'product_id': item['id'],
        'quantity': item['quantity'],
      };
    }).toList();

    final body = jsonEncode({
      'customer_id': customerId,
      'items': items,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Order created successfully
        print('Order created successfully');
        print('Response: ${response.body}');

        // Show success message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Order created successfully!")),
        );

        clearDatabase();

        // Optionally, navigate to a success screen
        // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
      } else {
        // Handle error
        print('Failed to create order. Status code: ${response.statusCode}');
        print('Response: ${response.body}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to create order. Please try again.")),
        );
      }
    } catch (e) {
      // Handle network or other errors
      print('Error creating order: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please check your connection.")),
      );
    }
  }

  void openCheckout(double amount) {
    var options = {
      'key': 'rzp_test_QLvdqmBfoYL2Eu', // Replace with your Razorpay key
      'amount': amount * 100, // Amount in paise (e.g., 1000 paise = ₹10)
      'name': 'Online Grocery App',
      'description': 'Payment for groceries',
      'prefill': {'contact': '1234567890', 'email': 'user@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clear Razorpay event listeners
    super.dispose();
  }

  void clearDatabase() async {
  try {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.remove();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Bottomnavigationbar()), (route) => false);
    print("Database cleared successfully!");
  } catch (e) {
    print("Error clearing database: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  var item = widget.cartItems[index];
                 
                  String productName = item['product_name'];
                  int quantity = item['quantity'];
                  double totalPrice = item['total_price'];
                  String createdAt = item['created_at'];

                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text(productName),
                      subtitle: Text('Quantity: $quantity\nAdded on: ${createdAt.split('T')[0]}'),
                      trailing: Text('\$${totalPrice.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text(
              'Total Amount: \$${widget.totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    
                  )
                ),
                onPressed: () {
                  openCheckout(widget.totalAmount);
                },
                child: Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}