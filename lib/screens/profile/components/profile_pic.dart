// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';
//
// class ProfilePic extends StatefulWidget {
//   final String userId;
//
//   const ProfilePic({Key? key, required this.userId}) : super(key: key);
//
//   @override
//   State<ProfilePic> createState() => _ProfilePicState();
// }
//
// class _ProfilePicState extends State<ProfilePic> {
//   File? _imageFile;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   String _profilePicUrl = 'assets/images/Profile Image.png';
//
//   @override
//   void initState() {
//     super.initState();
//     _getInitialProfilePicUrl();
//   }
//
//   Future<void> _getInitialProfilePicUrl() async {
//     final profilePicUrl = await _getProfilePicUrl();
//     setState(() {
//       _profilePicUrl = profilePicUrl;
//     });
//   }
//
//   Future<String> _getProfilePicUrl() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('profilePicUrl') ?? 'assets/images/Profile Image.png';
//   }
//
//   Future<void> _fetchProfilePicUrl(String userId) async {
//     final userDoc = await _firestore.collection('users').doc(userId).get();
//     final profilePicUrl = userDoc.data()?['profilePicUrl'] ?? 'assets/images/Profile Image.png';
//
//     // Update SharedPreferences with the new profile picture URL
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('profilePicUrl', profilePicUrl);
//
//     setState(() {
//       _profilePicUrl = profilePicUrl;
//     });
//   }
//
//   Future<void> _selectImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//       await _uploadImageToFirestore();
//     }
//   }
//
//   Future<void> _uploadImageToFirestore() async {
//     if (_imageFile != null) {
//       final reference = _storage.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
//       final uploadTask = reference.putFile(_imageFile!);
//       final snapshot = await uploadTask.whenComplete(() => null);
//       final downloadUrl = await snapshot.ref.getDownloadURL();
//       await _firestore.collection('users').doc(widget.userId).update({'profilePicUrl': downloadUrl});
//       await _fetchProfilePicUrl(widget.userId);
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       width: 100,
//       child: Stack(
//         fit: StackFit.expand,
//         clipBehavior: Clip.none,
//         children: [
//           _buildProfilePicture(),
//           Positioned(
//             right: -10,
//             bottom: 0,
//             child: SizedBox(
//               height: 35,
//               width: 35,
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                     side: const BorderSide(color: Colors.white),
//                   ),
//                   backgroundColor: const Color(0xFFF5F6F9),
//                 ),
//                 onPressed: () {
//                   showModalBottomSheet(
//                     context: context,
//                     builder: (context) => Wrap(
//                       children: [
//                         ListTile(
//                           leading: const Icon(Icons.photo_library),
//                           title: const Text('Gallery'),
//                           onTap: () {
//                             _selectImage(ImageSource.gallery);
//                             Navigator.pop(context);
//                           },
//                         ),
//                         ListTile(
//                           leading: const Icon(Icons.camera_alt),
//                           title: const Text('Camera'),
//                           onTap: () {
//                             _selectImage(ImageSource.camera);
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfilePicture() {
//     if (_imageFile != null) {
//       return CircleAvatar(
//         backgroundImage: FileImage(_imageFile!) as ImageProvider<Object>,
//       );
//     } else {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: CircleAvatar(
//           backgroundColor: Colors.white,
//           backgroundImage: CachedNetworkImageProvider(_profilePicUrl),
//         ),
//       );
//     }
//   }
//
// }

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePic extends StatefulWidget {
  final String userId;

  const ProfilePic({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? _imageFile;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _profilePicUrl = 'assets/images/Profile Image.png';
  bool _imageUrlFetched = false;

  @override
  void initState() {
    super.initState();
    _fetchProfilePicUrl();
  }

  Future<void> _fetchProfilePicUrl() async {
    final userDoc = await _firestore.collection('users').doc(widget.userId).get();
    final profilePicUrl = userDoc.data()?['profilePicUrl'] ?? 'assets/images/Profile Image.png';

    setState(() {
      _profilePicUrl = profilePicUrl;
      _imageUrlFetched = true;
    });
  }

  Future<void> _selectImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _uploadImageToFirestore();
    }
  }

  Future<void> _uploadImageToFirestore() async {
    if (_imageFile != null && mounted) {
      final reference = _storage.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = reference.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      if (mounted) {
        setState(() {
          _profilePicUrl = downloadUrl;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          _buildProfilePicture(),
          Positioned(
            right: -10,
            bottom: 0,
            child: SizedBox(
              height: 35,
              width: 35,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Gallery'),
                          onTap: () {
                            _selectImage(ImageSource.gallery);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Camera'),
                          onTap: () {
                            _selectImage(ImageSource.camera);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    if (!_imageUrlFetched) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/images/Profile Image.png'),
        ),
      );
    } else if (_imageFile != null) {
      return CircleAvatar(
        backgroundImage: FileImage(_imageFile!) as ImageProvider<Object>,
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: CachedNetworkImageProvider(_profilePicUrl),
      );
    }
  }
}
