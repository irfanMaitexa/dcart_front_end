import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_grocery_app_ui/baseurl.dart';
import 'package:online_grocery_app_ui/services/add_to_cart.dart';

import '../widgets/homescreenCustomwidget2.dart';
import 'mycartScreen.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key, this.zone, this.area});
  final String? zone;
  final String? area;

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
    searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/api/products/'));
    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      setState(() {
        products = data.map((item) => {
              'id': item['id'].toString(),
              'imageUrl': item['image'] == null ? 'asset/images/placeholder.png' : '${baseUrl+item['image']}' ,
              'title': item['name'],
              'subtitle': item['description'],
              'price': double.parse(item['price'].toString()),
              'quantity': 1
            }).toList();
        filteredProducts = List.from(products);
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  void _filterProducts() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products
          .where((product) =>
              product['title'].toLowerCase().contains(query) ||
              product['subtitle'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(height: 15),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffF2F3F2),
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search Store',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: filteredProducts.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            return HomeScreenCustomWidget2(
                              val: filteredProducts[index],
                              ontab: () {
                                addToCart(values: filteredProducts[index]);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Mycartscreen()),
                                );
                              },
                              image: filteredProducts[index]['imageUrl'],
                              title: filteredProducts[index]['title'],
                              subtitle: filteredProducts[index]['subtitle'],
                              price: filteredProducts[index]['price'],
                            );
                          },
                        ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
