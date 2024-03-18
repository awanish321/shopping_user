// // import 'package:flutter/material.dart';
// // import 'package:get_storage/get_storage.dart';
// // import 'package:shopping_app/screens/profile/components/notifications/notification_services.dart';
// //
// // class Notifications extends StatefulWidget {
// //   const Notifications({super.key});
// //
// //   @override
// //   State<Notifications> createState() => _NotificationsState();
// // }
// //
// // class _NotificationsState extends State<Notifications> {
// //   NotificationServices notificationServices = NotificationServices();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     notificationServices.requestNotificationPermission();
// //     notificationServices.firebaseInit(context);
// //     notificationServices.setupInteractMessage(context);
// //     notificationServices.isTokenRefresh();
// //
// //     notificationServices.getDeviceToken().then((value){
// //       print("Device token : $value");
// //     });
// //
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold),),
// //       ),
// //       body: ,
// //     );
// //   }
// // }
//
//
//
//
// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'notification_services.dart';
//
// class Notifications extends StatefulWidget {
//
//   const Notifications({super.key});
//
//   @override
//   State<Notifications> createState() => _NotificationsState();
// }
//
// class _NotificationsState extends State<Notifications> {
//
//   NotificationServices notificationServices = NotificationServices();
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     notificationServices.requestNotificationPermission();
//     notificationServices.foregroundMessage();
//     notificationServices.firebaseInit(context);
//     notificationServices.setupInteractMessage(context);
//     notificationServices.isTokenRefresh();
//
//     notificationServices.getDeviceToken().then((value){
//       if (kDebugMode) {
//         print('Device Token : $value');
//         print(value);
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: const Text('Notifications'),
//       ),
//       body: Center(
//         child: TextButton(onPressed: (){
//
//           // send notification from one device to another
//           notificationServices.getDeviceToken().then((value)async{
//
//             var data = {
//               'to' : value.toString(),
//               'priority': 'high',
//               'notification' : {
//                 'title' : 'Awanish Chaurasiya' ,
//                 'body' : 'Notifications' ,
//                 "sound": "jetsons_doorbell.mp3"
//               },
//               'android': {
//                 'notification': {
//                   'notification_count': 23,
//                 },
//               },
//               'data' : {
//                 'type' : 'msg' ,
//                 'id' : ' awanish'
//               }
//             };
//
//             await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//                 body: jsonEncode(data) ,
//                 headers: {
//                   'Content-Type': 'application/json; charset=UTF-8',
//                   'Authorization' : 'key=AAAAx5oTJE0:APA91bGtlGMqY-wLayUKMJcW3DKBc-uSp7DhCXJzNCVMIFP2yS3cFeOLKsX-WNjv9GAsSJBFUCkcToZPGPRckM8flT2_dhRauvZRxXnpZ89teETBMobRHU1b61yTrLL9221M5ePo1Hue'
//                 }
//             ).then((value){
//               if (kDebugMode) {
//                 print(value.body.toString());
//               }
//             }).onError((error, stackTrace){
//               if (kDebugMode) {
//                 print(error);
//               }
//             });
//           });
//         },
//             child: Text('Send Notifications')),
//       ),
//     );
//   }
// }