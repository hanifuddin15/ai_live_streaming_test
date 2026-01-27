// import 'package:ip_camera_live_streaming/app/core/services/theme_service.dart';

// import 'input_fields/primary_text_form_field.dart';
// import 'package:flutter/material.dart';
// import 'title_dropdown.dart';

// class PopUpForm {
//   // final BuildContext otherContext;
//   //
//   // PopUpForm({required this.otherContext});
//   //
//   // const PopUpForm({super.key, required this.otherContext});

//   ShowDialog(BuildContext othercontext, String title) {
//     showDialog(
//       context: othercontext,
//       builder:
//           (_) => AlertDialog(
//             surfaceTintColor: Colors.indigo,
//             title: Text(title),
//             content: Column(
//               children: [
//                 TitleDropDown(
//                   list: const ['Pending', 'Done', 'rejected'],
//                   title: 'Status',
//                   hints: 'Select status',
//                   dropdownWidth: Theme.of(context).size.width * 0.8,
//                   dropdownHeight: 40,
//                 ),
//                 TitleDropDown(
//                   list: const [
//                     'Leave',
//                     'Attendance',
//                     'ICT Service',
//                     'ICT Store',
//                     'General Store',
//                   ],
//                   title: 'Requisition Type',
//                   hints: 'Select Requisition Type',
//                   dropdownWidth: ThemeService.instance.width * 0.8,
//                   dropdownHeight: 40,
//                 ),
//                 const PrimaryTextFormField(labelText: ''),
//               ],
//             ),
//           ),
//     );
//   }

//   PopUpForm();
// }
