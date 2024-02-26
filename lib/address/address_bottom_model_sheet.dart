// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class AddressModel {
// //   final String id;
// //   final String name;
// //   final String phoneNumber;
// //   final String street;
// //   final String city;
// //   final String state;
// //   final String postalCode;
// //   final String country;
// //
// //   AddressModel({
// //     required this.id,
// //     required this.name,
// //     required this.phoneNumber,
// //     required this.street,
// //     required this.city,
// //     required this.state,
// //     required this.postalCode,
// //     required this.country,
// //   });
// // }
// //
// // class AddressBottomModelSheet extends StatelessWidget {
// //   final String userId; // User ID
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   AddressBottomModelSheet({required this.userId, required void Function(AddressModel selectedAddress) onAddressSelected});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: MediaQuery.of(context).size.height * 0.7,
// //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             'Select Address',
// //             style: TextStyle(
// //               fontWeight: FontWeight.bold,
// //               fontSize: 20,
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           StreamBuilder<QuerySnapshot>(
// //             stream: _firestore.collection('addresses').where('userId', isEqualTo: userId).snapshots(),
// //             builder: (context, snapshot) {
// //               if (snapshot.connectionState == ConnectionState.waiting) {
// //                 return const  Center(
// //                   child: CircularProgressIndicator(),
// //                 );
// //               }
// //
// //               if (snapshot.hasError) {
// //                 return Center(
// //                   child: Text('Error: ${snapshot.error}'),
// //                 );
// //               }
// //
// //               final addresses = snapshot.data?.docs;
// //
// //               if (addresses == null || addresses.isEmpty) {
// //                 return const Center(
// //                   child: Text(
// //                     'No addresses found.',
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                     ),
// //                   ),
// //                 );
// //               }
// //
// //               return Expanded(
// //                 child: ListView.builder(
// //                   itemCount: addresses.length,
// //                   itemBuilder: (context, index) {
// //                     final addressData = addresses[index].data() as Map<String, dynamic>;
// //                     final address = AddressModel(
// //                       id: addresses[index].id,
// //                       name: addressData['name'] ?? '',
// //                       phoneNumber: addressData['phoneNumber'] ?? '',
// //                       street: addressData['street'] ?? '',
// //                       city: addressData['city'] ?? '',
// //                       state: addressData['state'] ?? '',
// //                       postalCode: addressData['postalCode'] ?? '',
// //                       country: addressData['country'] ?? '',
// //                     );
// //
// //                     return ListTile(
// //                       title: Text(address.street),
// //                       subtitle: Text('${address.city}, ${address.postalCode}'),
// //                       onTap: () {
// //                         Navigator.pop(context, address); // Pass selected address
// //                       },
// //                     );
// //                   },
// //                 ),
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'model/address_model.dart'; // Import your AddressModel
//
// class AddressBottomModelSheet extends StatelessWidget {
//   final String userId; // User ID
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   AddressBottomModelSheet({super.key, required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.7,
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Select Address',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           const SizedBox(height: 20),
//           StreamBuilder<QuerySnapshot>(
//             stream: _firestore.collection('addresses').where('userId', isEqualTo: userId).snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const  Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text('Error: ${snapshot.error}'),
//                 );
//               }
//
//               final addresses = snapshot.data?.docs;
//
//               if (addresses == null || addresses.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     'No addresses found.',
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 );
//               }
//
//               return Expanded(
//                 child: ListView.builder(
//                   itemCount: addresses.length,
//                   itemBuilder: (context, index) {
//                     final addressData = addresses[index].data() as Map<String, dynamic>;
//                     final address = AddressModel(
//                       id: addresses[index].id,
//                       name: addressData['name'] ?? '',
//                       phoneNumber: addressData['phoneNumber'] ?? '',
//                       street: addressData['street'] ?? '',
//                       city: addressData['city'] ?? '',
//                       state: addressData['state'] ?? '',
//                       postalCode: addressData['postalCode'] ?? '',
//                       country: addressData['country'] ?? '',
//                     );
//
//                     return ListTile(
//                       title: Text(address.street),
//                       subtitle: Text('${address.city}, ${address.postalCode}'),
//                       onTap: () {
//                         Navigator.pop(context, address); // Pass selected address
//                       },
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
