import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final String userEmail;
  final String productName;
  final String productPrice;
  final String salePrice;
  final int quantity;
  final String color;
  final String imageUrl;
  final String paymentMethod;
  final Address deliveryAddress;
  final String totalAmount;
  final DateTime orderDate;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.userEmail,
    required this.productName,
    required this.productPrice,
    required this.salePrice,
    required this.quantity,
    required this.color,
    required this.imageUrl,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.totalAmount,
    required this.orderDate,
  });

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      orderId: snapshot.id,
      userId: data['userId'],
      userEmail: data['userEmail'],
      productName: data['productName'],
      productPrice: data['productPrice'],
      salePrice: data['salePrice'],
      quantity: data['quantity'],
      color: data['color'],
      imageUrl: data['imageUrl'],
      paymentMethod: data['paymentMethod'],
      deliveryAddress: Address.fromMap(data['deliveryAddress']),
      totalAmount: data['totalAmount'],
      orderDate: (data['orderDate'] as Timestamp).toDate(),
    );
  }
}

class Address {
  final String street;
  final String city;
  final String postalCode;
  final String country;
  final String name;
  final String phoneNumber;
  final String state;

  Address({
    required this.street,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.name,
    required this.phoneNumber,
    required this.state,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'],
      city: map['city'],
      postalCode: map['postalCode'],
      country: map['country'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      state: map['state'],
    );
  }
}
