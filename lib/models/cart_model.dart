import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String productName;
  final String image;
  final String color;
  final String size;
  final String salePrice;
  final int quantity;

  CartModel(
      {required this.productName,
      required this.image,
      required this.color,
      required this.size,
      required this.salePrice,
      this.quantity = 0});

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'image': image,
      'color': color,
      'size': size,
      'salePrice': salePrice,
      'quantity': quantity
    };
  }

  factory CartModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return CartModel(
      productName: data?['productName'] ?? '',
      image: data?['image'] ?? '',
      color: data?['color'] ?? '',
      size: data?['size'] ?? '',
      salePrice: data?['salePrice'] ?? '',
      quantity: data?['quantity'] ?? '',
    );
  }
}
