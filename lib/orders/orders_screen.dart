import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/models/order_model.dart';
import 'package:shopping_app/orders/orders.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  String _formatAddress(Address address) {
    return '${address.name} ${address.street} ${address.city} ${address.state} ${address.postalCode} ${address.country}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders", style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('orders').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                // child: CircularProgressIndicator(),
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
              separatorBuilder: (_, __){
                return const Divider(height: 30 ,thickness: 0.7,);
              },
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot orderSnapshot = snapshot.data!.docs[index];
                OrderModel order = OrderModel.fromSnapshot(orderSnapshot);
                return Row(
                  children: [
                    Image.network(order.imageUrl, height: 120, width: 120,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order.productName, style: GoogleFonts.nunitoSans(fontSize: 18, fontWeight: FontWeight.w500),),
                          Text(order.totalAmount, style: GoogleFonts.nunitoSans(fontSize: 15,)),
                          Text(DateFormat('MM/dd/yyyy').format(order.orderDate), style: GoogleFonts.nunitoSans(fontSize: 15,)),
                          Text(_formatAddress(order.deliveryAddress),maxLines: 3, overflow: TextOverflow.ellipsis, style: GoogleFonts.nunitoSans(fontSize: 15,)),
                          const Gap(20)
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
