// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ProductModel {
//   final String category;
//   final Timestamp deliveryDate;
//   final List<String> images;
//   final List<String> colors;
//   final List<String> sizes;
//   final String productName;
//   final String productPrice;
//   final String productTitle;
//   final String subCategory;
//   final String userId;
//  final String productDetail1;
//  final String productTitle1;
//
//
//   // Add isFavorite as a local field
//   bool isFavorite;
//
//   ProductModel(
//       {
//     required this.category,
//     required this.deliveryDate,
//     required this.images,
//     required this.productName,
//     required this.productPrice,
//     required this.productTitle,
//     required this.subCategory,
//     required this.userId,
//     required this.isFavorite,
//         required this.productTitle1,
//         required this.productDetail1,
//         required this.colors,
//         required this.sizes
//         // Include isFavorite in the constructor
//   });
//
//   factory ProductModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
//
//     return ProductModel(
//       category: data?['category'] ?? '',
//       deliveryDate: data?['deliveryDate'] ?? Timestamp.now(),
//       images: List<String>.from(data?['images'] ?? []),
//       colors: List<String>.from(data?['colors'] ?? []),
//       sizes: List<String>.from(data?['sizes'] ?? []),
//       productName: data?['productName'] ?? '',
//       productPrice: data?['productPrice'] ?? '',
//       productTitle: data?['productTitle'] ?? '',
//       subCategory: data?['subCategory'] ?? '',
//       userId: data?['user_id'] ?? '',
//       isFavorite: false,
//       productTitle1: data?['productDetailTitle1'] ?? '',
//       productDetail1: data?['productDetail1'] ?? '', // Set isFavorite to false by default
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'category': category,
//       'deliveryDate': deliveryDate,
//       'images': images,
//       'productName': productName,
//       'productPrice': productPrice,
//       'productTitle': productTitle,
//       'subCategory': subCategory,
//       'user_id': userId,
//       'productDetailTitle1':productTitle1,
//       'productDetail1':productDetail1,
//       'colors': colors,
//       'sizes': sizes
//     };
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String category;
  final Timestamp deliveryDate;
  final List<String> images;
  final List<String> colors;
  final List<String> sizes;
  final String productName;
  final String productPrice;
  final String salePrice;
  final String productTitle;
  final String subCategory;
  final String userId;
  final String productDetail1;
  final String productTitle1;

  // Add isFavorite as a local field
  bool isFavorite;

  ProductModel({
    required this.category,
    required this.deliveryDate,
    required this.images,
    required this.productName,
    required this.productPrice,
    required this.salePrice,
    required this.productTitle,
    required this.subCategory,
    required this.userId,
    required this.isFavorite,
    required this.productTitle1,
    required this.productDetail1,
    required this.colors,
    required this.sizes,
  });

  factory ProductModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return ProductModel(
      category: data?['category'] ?? '',
      deliveryDate: data?['deliveryDate'] ?? Timestamp.now(),
      images: List<String>.from(data?['images'] ?? []),
      colors: List<String>.from(data?['colors'] ?? []),
      sizes: List<String>.from(data?['sizes'] ?? []),
      productName: data?['productName'] ?? '',
      productPrice: data?['productPrice'] ?? '',
      salePrice: data?['salePrice'] ?? '',
      productTitle: data?['productTitle'] ?? '',
      subCategory: data?['subCategory'] ?? '',
      userId: data?['user_id'] ?? '',
      isFavorite: false,
      productTitle1: data?['productDetailTitle1'] ?? '',
      productDetail1: data?['productDetail1'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'deliveryDate': deliveryDate,
      'images': images,
      'productName': productName,
      'productPrice': productPrice,
      'salePrice': salePrice,
      'productTitle': productTitle,
      'subCategory': subCategory,
      'user_id': userId,
      'productDetailTitle1': productTitle1,
      'productDetail1': productDetail1,
      'colors': colors,
      'sizes': sizes,
    };
  }
}
