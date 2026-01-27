// import 'package:badges/badges.dart' as badges;
// import 'package:flutter/material.dart';

// import '../config/app_constant.dart';
// import '../utils/color.dart';

// class PrimaryDrawer extends StatelessWidget {
//   const PrimaryDrawer({
//     super.key,
//     required this.headerPhoneUrl,
//     required this.headerTitle,
//     required this.headersubTitle,
//   });

//   final String headerPhoneUrl;
//   final String headerTitle;
//   final String headersubTitle;

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: PRIMARY_COLOR,
//       child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//         SizedBox(
//           child: DrawerHeader(
//             child: Container(
//               color: PRIMARY_COLOR,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SecondaryNetworkImage(
//                     imageUrl: headerPhoneUrl,
//                     height: 80,
//                     width: 80,
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     headerTitle,
//                     style: const TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                   Text(
//                     headersubTitle,
//                     style: const TextStyle(fontSize: 12, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             color: Colors.white,
//             child: const Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.person, color: PRIMARY_COLOR),
//                   title: Text('Profile'),
//                 ),
//                 Divider(),
//                 badges.Badge(
//                   badgeContent: Text(
//                     '3',
//                   ),
//                   child:
//                       Icon(Icons.notifications, size: 28, color: PRIMARY_COLOR),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ]),
//     );
//   }
// }

// class SecondaryNetworkImage extends StatelessWidget {
//   const SecondaryNetworkImage({
//     super.key,
//     required this.imageUrl,
//     this.height,
//     this.width,
//   });

//   final String imageUrl;
//   final double? height;
//   final double? width;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height ?? 32,
//       width: width ?? 32,
//       child: CircleAvatar(
//         backgroundImage: NetworkImage(
//           '${AppConstant.IMAGE_BASE_URL}'
//           '$imageUrl',
//         ),
//       ),
//     );
//   }
// }
