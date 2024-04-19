// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'notification_services.dart';
//
// class Notifications extends StatefulWidget {
//   const Notifications({Key? key, required id}) : super(key: key);
//
//   @override
//   State<Notifications> createState() => _NotificationsState();
// }
//
// class _NotificationsState extends State<Notifications> {
//   NotificationServices notificationServices = NotificationServices();
//   String id = "";
//
//   @override
//   void initState() {
//     super.initState();
//     notificationServices.requestNotificationPermission();
//     notificationServices.foregroundMessage();
//     notificationServices.firebaseInit(context);
//     notificationServices.setupInteractMessage(context);
//     notificationServices.isTokenRefresh();
//
//     notificationServices.getDeviceToken().then((value) {
//       if (kDebugMode) {
//         print('Device Token : $value');
//         print(value);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notifications'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextButton(
//               onPressed: () {
//                 // send notification from one device to another
//                 notificationServices.getDeviceToken().then((value) async {
//                   var data = {
//                     'to': value.toString(),
//                     'priority': 'high',
//                     'notification': {
//                       'title': 'Awanish Chaurasiya',
//                       'body': 'Notifications',
//                       "sound": "jetsons_doorbell.mp3"
//                     },
//                     'android': {
//                       'notification': {
//                         'notification_count': 23,
//                       },
//                     },
//                     'data': {
//                       'type': 'msg',
//                       'id': ' awanish',
//                     }
//                   };
//
//                   await http
//                       .post(
//                     Uri.parse('https://fcm.googleapis.com/fcm/send'),
//                     body: jsonEncode(data),
//                     headers: {
//                       'Content-Type': 'application/json; charset=UTF-8',
//                       'Authorization':
//                       'key=AAAAx5oTJE0:APA91bGtlGMqY-wLayUKMJcW3DKBc-uSp7DhCXJzNCVMIFP2yS3cFeOLKsX-WNjv9GAsSJBFUCkcToZPGPRckM8flT2_dhRauvZRxXnpZ89teETBMobRHU1b61yTrLL9221M5ePo1Hue'
//                     },
//                   )
//                       .then((value) {
//                     if (kDebugMode) {
//                       print(value.body.toString());
//                     }
//                   }).onError((error, stackTrace) {
//                     if (kDebugMode) {
//                       print(error);
//                     }
//                   });
//                 });
//               },
//               child: Text('Send Notifications'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   id = id.isEmpty ? ' Message Screen' : '';
//                 });
//               },
//               child: Text(id.isEmpty ? 'Go to Message Screen' : 'Clear Message Screen'),
//             ),
//             if (id.isNotEmpty)
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           id = '';
//                         });
//                       },
//                       child: const Text('Clear Message Screen'),
//                     ),
//                   ),
//                     ]
//               ),
//       )
//     );
//   }
// }



// import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
//
// class Notifications extends StatefulWidget {
//   const Notifications({Key? key, required id}) : super(key: key);
//
//   @override
//   State<Notifications> createState() => _NotificationsState();
// }
//
// class _NotificationsState extends State<Notifications> {
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   List<Map<String, dynamic>> notifications = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _messaging.requestPermission();
//     _messaging.getToken().then((token) {
//       if (kDebugMode) {
//         print('Device Token: $token');
//       }
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         print('Got a message whilst in the foreground!');
//         print('Message data: ${message.data}');
//       }
//
//       if (message.notification != null) {
//         String title = message.notification!.title ?? '';
//         String body = message.notification!.body ?? '';
//         setState(() {
//           notifications.add({
//             'title': title,
//             'body': body,
//             'timestamp': DateTime.now(),
//           });
//         });
//       }
//     });
//   }
//
//   String _formatTimestamp(DateTime timestamp) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = DateTime(now.year, now.month, now.day - 1);
//     final aYearAgo = DateTime(now.year - 1, now.month, now.day);
//
//     final startOfDay = DateTime(timestamp.year, timestamp.month, timestamp.day);
//     final diff = startOfDay.difference(today);
//
//     if (diff.inDays == 0) {
//       return DateFormat('h:mm a').format(timestamp);
//     } else if (diff.inDays == 1) {
//       return 'Yesterday';
//     } else if (diff.inDays > 365) {
//       return DateFormat('MMM d, yyyy').format(timestamp);
//     } else {
//       return DateFormat('MMM d').format(timestamp);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notifications'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: notifications.length,
//               itemBuilder: (context, index) {
//                 final notification = notifications[index];
//                 return Card(
//                   child: ListTile(
//                     leading: const CircleAvatar(
//                       child: Icon(Icons.notifications),
//                     ),
//                     title: Text(notification['title']),
//                     subtitle: Text(notification['body']),
//                     trailing: Text(
//                       _formatTimestamp(notification['timestamp']),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           TextButton(
//             onPressed: () async {
//               String? token = await _messaging.getToken();
//               if (token != null) {
//                 var data = {
//                   'to': token,
//                   'priority': 'high',
//                   'notification': {
//                     'title': 'Notification Title',
//                     'body': 'Notification Body',
//                     "sound": "jetsons_doorbell.mp3"
//                   },
//                   'android': {
//                     'notification': {
//                       'notification_count': 23,
//                     },
//                   },
//                   'data': {
//                     'type': 'msg',
//                     'id': 'awanish',
//                   }
//                 };
//                 await http.post(
//                   Uri.parse('https://fcm.googleapis.com/fcm/send'),
//                   body: jsonEncode(data),
//                   headers: {
//                     'Content-Type': 'application/json; charset=UTF-8',
//                     'Authorization':
//                     'key=AAAAx5oTJE0:APA91bGtlGMqY-wLayUKMJcW3DKBc-uSp7DhCXJzNCVMIFP2yS3cFeOLKsX-WNjv9GAsSJBFUCkcToZPGPRckM8flT2_dhRauvZRxXnpZ89teETBMobRHU1b61yTrLL9221M5ePo1Hue'
//                   },
//                 );
//               }
//             },
//             child: const Text('Send Notification'),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key, required id}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    _messaging.requestPermission();
    _messaging.getToken().then((token) {
      if (kDebugMode) {
        print('Device Token: $token');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }

      if (message.notification != null) {
        String title = message.notification!.title ?? '';
        String body = message.notification!.body ?? '';
        Map<String, dynamic> notification = {
          'title': title,
          'body': body,
          'timestamp': DateTime.now().toIso8601String(),
        };
        setState(() {
          notifications.add(notification);
        });
        _saveNotification(notification);
      }
    });

    _loadNotifications();
  }

  Future<void> _saveNotification(Map<String, dynamic> notification) async {
    final prefs = await SharedPreferences.getInstance();
    final notificationList = prefs.getStringList('notifications') ?? [];
    notificationList.add(jsonEncode(notification));
    await prefs.setStringList('notifications', notificationList);
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationList = prefs.getStringList('notifications') ?? [];
    setState(() {
      notifications = notificationList
          .map((notificationJson) => jsonDecode(notificationJson))
          .toList()
          .cast<Map<String, dynamic>>();
    });
  }

  String _formatTimestamp(String timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aYearAgo = DateTime(now.year - 1, now.month, now.day);

    final parsedTimestamp = DateTime.parse(timestamp);
    final startOfDay = DateTime(parsedTimestamp.year, parsedTimestamp.month, parsedTimestamp.day);
    final diff = startOfDay.difference(today);

    if (diff.inDays == 0) {
      return DateFormat('h:mm a').format(parsedTimestamp);
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays > 365) {
      return DateFormat('MMM d, yyyy').format(parsedTimestamp);
    } else {
      return DateFormat('MMM d').format(parsedTimestamp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.notifications),
                    ),
                    title: Text(notification['title']),
                    subtitle: Text(notification['body']),
                    trailing: Text(
                      _formatTimestamp(notification['timestamp']),
                    ),
                  ),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () async {
              String? token = await _messaging.getToken();
              if (token != null) {
                var data = {
                  'to': token,
                  'priority': 'high',
                  'notification': {
                    'title': 'Notification Title',
                    'body': 'Notification Body',
                    "sound": "jetsons_doorbell.mp3"
                  },
                  'android': {
                    'notification': {
                      'notification_count': 23,
                    },
                  },
                  'data': {
                    'type': 'msg',
                    'id': 'awanish',
                  }
                };
                await http.post(
                  Uri.parse('https://fcm.googleapis.com/fcm/send'),
                  body: jsonEncode(data),
                  headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization':
                    'key=AAAAx5oTJE0:APA91bGtlGMqY-wLayUKMJcW3DKBc-uSp7DhCXJzNCVMIFP2yS3cFeOLKsX-WNjv9GAsSJBFUCkcToZPGPRckM8flT2_dhRauvZRxXnpZ89teETBMobRHU1b61yTrLL9221M5ePo1Hue'
                  },
                );
              }
            },
            child: const Text('Send Notification'),
          ),
        ],
      ),
    );
  }
}