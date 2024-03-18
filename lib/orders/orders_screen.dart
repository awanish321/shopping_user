import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/models/order_model.dart';
import '../home/components/coustom_bottom_nav_bar.dart';
import 'order_tracker.dart';
import 'empty_orders.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  double parseDouble(String value) {
    final decimalFormat = NumberFormat.decimalPattern();
    return (decimalFormat.parse(value.replaceAll('₹', '').replaceAll(',', ',')) ?? 0.0) as double;
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavBar()),
                );
              },
            ),
            title: const Text("Orders"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Orders')
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection('orders')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return const EmptyOrderScreen();
                }

                return ListView.separated(
                  separatorBuilder: (_, __) {
                    return const Gap(5);
                  },
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot orderSnapshot = snapshot.data!.docs[index];
                    OrderModel order = OrderModel.fromSnapshot(orderSnapshot);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TrackOrders()));
                      },
                      child: OrderCard(
                        orderId: order.orderId,
                        orderDate: order.orderDate,
                        orderTotal: parseDouble(order.totalAmount),
                        productName: order.productName,
                        imageUrl: order.imageUrl,
                        deliveryAddress: order.deliveryAddress,
                        productPrice: order.productPrice,
                        salePrice: order.salePrice,
                        quantity: order.quantity,
                        color: order.color,
                        paymentMethod: order.paymentMethod,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        // ),
      // ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final DateTime orderDate;
  final double orderTotal;
  final String productName;
  final String imageUrl;
  final Address deliveryAddress;
  final String productPrice;
  final String salePrice;
  final int quantity;
  final String color;
  final String paymentMethod;

  const OrderCard({super.key,
    required this.orderId,
    required this.orderDate,
    required this.orderTotal,
    required this.productName,
    required this.imageUrl,
    required this.deliveryAddress,
    required this.productPrice,
    required this.salePrice,
    required this.quantity,
    required this.color,
    required this.paymentMethod,
  });

  String _formatAddress(Address address) {
    return '${address.name}, ${address.street}, ${address.city}, ${address.state}, ${address.postalCode}, ${address.country}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Placed On : ${DateFormat('MM/dd/yyyy').format(orderDate)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Qty : $quantity',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Color : $color',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      RichText(
                        text: TextSpan(
                          text: 'Price : ₹',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                          children: [
                            TextSpan(
                              text: productPrice,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text: '   ₹$salePrice',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delivery Address : ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    _formatAddress(deliveryAddress),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Payment Method:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  paymentMethod,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${NumberFormat("#,##,##0.00", "en_IN").format(orderTotal)}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
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
