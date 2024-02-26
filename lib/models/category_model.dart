import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String category;
  final String image;
  final Timestamp timestamp;
  final String userId;

  CategoryModel({
    required this.category,
    required this.image,
    required this.timestamp,
    required this.userId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      category: json['category'],
      image: json['image'],
      timestamp: json['timestamp'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'image': image,
      'timestamp': timestamp,
      'user_id': userId,
    };
  }
}

