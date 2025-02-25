import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/baseurl.dart';
import 'package:online_grocery_app_ui/screens/check_out_screen.dart';
import 'package:online_grocery_app_ui/widgets/custombuttonWidget.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert'; // For jsonDecode

class Mycartscreen extends StatefulWidget {
  Mycartscreen({super.key});

  @override
  State<Mycartscreen> createState() => _MycartscreenState();
}

class _MycartscreenState extends State<Mycartscreen> {
  late WebSocketChannel _channel;
  List<dynamic> cartList = [];

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  void _connectToWebSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse('$wBaseUrl/ws/cart/1/'),
    );

    _channel.stream.listen((message) {
      print('WebSocket message: $message');
      final data = jsonDecode(message);
      print(data);

      setState(() {
        cartList = data['data'];
        print(cartList);
      });
    }, onError: (error) {
      print('WebSocket error: $error');
    }, onDone: () {
      print('WebSocket connection closed');
    });
  }

  double getTotalCost() {
    double total = 0.0;
    for (var item in cartList) {
      total += item['total_price'];
    }
    return total;
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'My Cart',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff181725),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Divider(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  var item = cartList[index];
                  String productName = item['product_name'];
                  int quantity = item['quantity'];
                  double totalPrice = item['total_price'];
                  String createdAt = item['created_at'];

                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.shopping_cart, size: 50), // Placeholder
                            SizedBox(width: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productName,
                                  style: TextStyle(
                                    color: Color(0xff181725),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Quantity: $quantity',
                                  style: TextStyle(
                                    color: Color(0xff7C7C7C),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Added on: ${createdAt.split('T')[0]}',
                                  style: TextStyle(
                                    color: Color(0xff7C7C7C),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                
                                SizedBox(height: 10),
                                Text(
                                  '\$${totalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Color(0xff181725),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Divider(height: 5),
                      ],
                    ),
                  );
                },
              ),
            ),
            CustomButtonWidget(
              text: 'Make bill',
              action: () {
                double totalCost = getTotalCost();
                print(cartList);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(
                      cartItems: cartList,
                      totalAmount: totalCost,
                    ),
                  ),
                );
              
              },
            ),
          ],
        ),
      ),
    );
  }
}