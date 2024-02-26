// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
//
// class AddNewAddressScreen extends StatelessWidget {
//   const AddNewAddressScreen({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     final name = TextEditingController();
//     final phoneNumber = TextEditingController();
//     final street = TextEditingController();
//     final postalCode = TextEditingController();
//     final city = TextEditingController();
//     final state = TextEditingController();
//     final country = TextEditingController();
//     GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Address', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontWeight: FontWeight.bold)),),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             child: Column(
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Iconsax.user),
//                     labelText: 'Name',
//                     labelStyle: GoogleFonts.nunitoSans(),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: const BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Iconsax.mobile),
//                     labelText: 'Phone Number',
//                     labelStyle: GoogleFonts.nunitoSans(),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: const BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Iconsax.building_31),
//                           labelText: 'Street',
//                           labelStyle: GoogleFonts.nunitoSans(),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: Colors.grey),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16 / 1.2),
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Iconsax.code),
//                           labelText: 'Postal Code',
//                           labelStyle: GoogleFonts.nunitoSans(),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: Colors.grey),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Iconsax.building),
//                           labelText: 'City',
//                           labelStyle: GoogleFonts.nunitoSans(),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: Colors.grey),
//                           ),
//                           // labelStyle:
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16 / 1.2),
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Iconsax.activity),
//                           labelText: 'State',
//                           labelStyle: GoogleFonts.nunitoSans(),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: const BorderSide(color: Colors.grey),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Iconsax.global),
//                     labelText: 'Country',
//                     labelStyle: GoogleFonts.nunitoSans(),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: const BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE53935)
//                     ),
//                     onPressed: () {},
//                     child: Text("SAVE", style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, color: Colors.white)),),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final phoneNumber = TextEditingController();
    final street = TextEditingController();
    final postalCode = TextEditingController();
    final city = TextEditingController();
    final state = TextEditingController();
    final country = TextEditingController();
    GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

    final user = FirebaseAuth.instance.currentUser!.email;

    Future<void> saveAddress(BuildContext context) async {
      if (user != null) {
        try {
          await FirebaseFirestore.instance
              .collection('Addresses')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('addresses')
              .add({
            'name': name.text,
            'phoneNumber': phoneNumber.text,
            'street': street.text,
            'postalCode': postalCode.text,
            'city': city.text,
            'state': state.text,
            'country': country.text,
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Address saved successfully!'),
          ));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to save address. Please try again.'),
          ));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Address',
          style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.user),
                    labelText: 'Name',
                    labelStyle: GoogleFonts.nunitoSans(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneNumber,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                    labelStyle: GoogleFonts.nunitoSans(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                // const SizedBox(height: 16),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: street,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.building_31),
                          labelText: 'Street',
                          labelStyle: GoogleFonts.nunitoSans(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16 / 1.2),
                    Expanded(
                      child: TextFormField(
                        controller: postalCode,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.code),
                          labelText: 'Postal Code',
                          labelStyle: GoogleFonts.nunitoSans(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: city,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.building),
                          labelText: 'City',
                          labelStyle: GoogleFonts.nunitoSans(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16 / 1.2),
                    Expanded(
                      child: TextFormField(
                        controller: state,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.activity),
                          labelText: 'State',
                          labelStyle: GoogleFonts.nunitoSans(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: country,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.global),
                    labelText: 'Country',
                    labelStyle: GoogleFonts.nunitoSans(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE53935),
                    ),
                    onPressed: () => saveAddress(context),
                    child: Text(
                      "SAVE",
                      style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
