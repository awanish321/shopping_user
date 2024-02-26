import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String id;
  final String email;
  final String phoneNumber;
  final String gender;
  final String firstName;
  final String lastName;
  final String dob;
  final String userName;
  final String password;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.dob,
    required this.gender,
    required this.password,
    required this.userName
  });

  toJson(){
    return {
      'userId': id,
      'firstName':firstName,
      'lastName' : lastName,
      'phoneNumber' : phoneNumber,
      'email': email,
      'dob':dob,
      'gender':gender,
      'username':userName,
      'password':password
    };
  }

  // factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
  //   final data = document.data()!;
  //   return UserModel(
  //       id: document.id,
  //       firstName: data['firstName'] ?? '',
  //       lastName: data['lastName'] ?? '',
  //       phoneNumber: data['phoneNumber'] ?? '',
  //       dob: data['dob'] ?? '',
  //       gender: data['gender'] ?? '',
  //       email: data['email'] ?? '',
  //       userName: data['username'] ?? '',
  //       password: data['Password'] ?? ''
  //   );
  // }

  // factory UserModel.fromSnapshot(DocumentSnapshot<dynamic> document) {
  //   final data = document.data() as Map<String, dynamic>;
  //   return UserModel(
  //     id: document.id,
  //     firstName: data['firstName'] ?? '',
  //     lastName: data['lastName'] ?? '',
  //     phoneNumber: data['phoneNumber'] ?? '',
  //     dob: data['dob'] ?? '',
  //     gender: data['gender'] ?? '',
  //     email: data['email'] ?? '',
  //     userName: data['username'] ?? '',
  //     password: data['password'] ?? '',
  //   );
  // }

  factory UserModel.fromSnapshot(DocumentSnapshot document) {
    final Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    // Check if data is null or empty
    if (data == null || data.isEmpty) {
      // Return UserModel with default values or throw an error
      return const UserModel(
        id: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        dob: '',
        gender: '',
        email: '',
        userName: '',
        password: '',
      );
    }

    // Use data safely
    return UserModel(
      id: document.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      dob: data['dob'] ?? '',
      gender: data['gender'] ?? '',
      email: data['email'] ?? '',
      userName: data['username'] ?? '',
      password: data['password'] ?? '',
    );
  }



}
