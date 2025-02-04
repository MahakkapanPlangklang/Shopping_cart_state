import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final List<Map<String, dynamic>> _products = [
    {
      "name": "Asus TUF A15 Gaming Notebook",
      "price": 40990,
      "quantity": 0,
      "image": "https://m.media-amazon.com/images/I/71ROr-qsTzL.jpg"
    },
    {
      "name": "Xiaomi 13T Pro",
      "price": 14990,
      "quantity": 0,
      "image": "https://i02.appmifile.com/156_item_th/18/03/2024/070120994d8056dd21fd6c6534ce7ede!400x400!85.png"
    },
    {
      "name": "iPad Air 11-inch (M2) Wi-Fi 256GB",
      "price": 23500,
      "quantity": 0,
      "image": "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-gallery-202405-11inch-blue-wifi_FMT_WHH?wid=1200&hei=630&fmt=jpeg&qlt=95&.v=1713820066491"
    },
  ];

  int get totalItems {
    return _products.fold<int>(0, (sum, item) => sum + (item['quantity'] as int));
  }

  double get totalPrice {
    return _products.fold<double>(0.0, (sum, item) => sum + (item['quantity'] * item['price']).toDouble());
  }

  String formatPrice(int price) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(price);
  }

  void _incrementItem(int index) {
    setState(() {
      _products[index]['quantity']++;
    });
  }

  void _decrementItem(int index) {
    setState(() {
      if (_products[index]['quantity'] > 0) {
        _products[index]['quantity']--;
      }
    });
  }

  void _resetCart() {
    setState(() {
      for (var item in _products) {
        item['quantity'] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🖥️ IT Gadget Store"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.black,
                  elevation: 5,
                  shadowColor: Colors.blueAccent.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            _products[index]['image'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _products[index]['name'],
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text(
                                "฿${formatPrice(_products[index]['price'])}",
                                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                                    onPressed: () => _decrementItem(index),
                                  ),
                                  Text(
                                    '${_products[index]['quantity']}',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add_circle_outline, color: Colors.green),
                                    onPressed: () => _incrementItem(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Column(
              children: [
                Text(
                  "รวมสินค้า: $totalItems ชิ้น",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  "ราคารวม: ฿${formatPrice(totalPrice.toInt())}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellowAccent),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _resetCart,
                  icon: Icon(Icons.refresh),
                  label: Text("รีเซ็ตตะกร้า", style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
