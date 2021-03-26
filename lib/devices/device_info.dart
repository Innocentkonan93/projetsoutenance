// import 'dart:io';
// import 'package:device_info/device_info.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class DeviceInfos extends StatefulWidget {
//   @override
//   _DeviceInfosState createState() => _DeviceInfosState();
// }

// class _DeviceInfosState extends State<DeviceInfos> {
//   @override
//   void initState() {
//     _getDeviceDetails();
//     super.initState();
//   }

//   String deviceName = '';
//   String deviceVersion = '';
//   String identifier = '';

//   Future<void> _getDeviceDetails() async {
//     final deviceInfoPlugin = DeviceInfoPlugin();
//     try {
//       if (Platform.isAndroid) {
//         var androidInfos = await deviceInfoPlugin.androidInfo;
//         setState(() {
//           deviceName = androidInfos.model;
//           deviceVersion = androidInfos.version.toString();
//           identifier = androidInfos.androidId;
//         });
//       } else if (Platform.isIOS) {
//         var iosInfos = await deviceInfoPlugin.iosInfo;
//         setState(() {
//           deviceName = iosInfos.name;
//           deviceVersion = iosInfos.systemVersion;
//           identifier = iosInfos.identifierForVendor;
//         });
//       }
//     } on PlatformException {
//       print('echec');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('$deviceName'),
//             Text('$deviceVersion'),
//             Text('$identifier'),
//             RaisedButton(
//               onPressed: () {
//                 _getDeviceDetails();
//               },
//               child: Text('infos'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
