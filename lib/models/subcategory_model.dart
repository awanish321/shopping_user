// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class SubCategoryModel {
//   final String? id;
//   final String? category;
//   final String? subcategory;
//   final String? image;
//
//   SubCategoryModel({
//     this.id,
//     this.category,
//     this.subcategory,
//     this.image,
//   });
//
//   factory SubCategoryModel.fromJson(DocumentSnapshot json) {
//     return SubCategoryModel(
//         id: json.id,
//         category: json['category'],
//         subcategory: json['subCategory'],
//         image: json['image'],
//         );
//     }
// }

//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class SubCategoryModel {
//   final String? id;
//   final String? category;
//   final String? subcategory;
//   final String? image;
//   final Timestamp? timestamp;
//   final String? userId;
//
//   SubCategoryModel({
//     this.id,
//     this.category,
//     this.subcategory,
//     this.image,
//     this.timestamp,
//     this.userId,
//   });
//
//   factory SubCategoryModel.fromJson(DocumentSnapshot json) {
//     return SubCategoryModel(
//       id: json.id,
//       category: json['category'],
//       subcategory: json['subcategory'],
//       image: json['image'],
//       timestamp: json['timestamp'],
//       userId: json['user_id'],
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoryModel {
  final String? id;
  final String? category;
  final String? subcategory;
  final String? image;

  SubCategoryModel({
    this.id,
    this.category,
    this.subcategory,
    this.image,
  });

  factory SubCategoryModel.fromJson(DocumentSnapshot json) {
    return SubCategoryModel(
      id: json.id,
      category: json['category'],
      subcategory: json['subcategory'],
      image: json['image'],
    );
  }
}
