import 'package:flutter/material.dart';

const Color primarySwatch = Colors.indigo;
const Color primaryColor = Color(0xff192D6B);
const Color primaryLightColor = Color(0xffC5CAE9);
const Color indigo50 = Color(0xffE8EAF6);
const Color backgroundColor = Color(0xffECF0F1);
const Color colorPest = Color(0xff21CBC1);
const Color colorBrown = Color(0xffE27108);
const Color colorPurple = Color(0xffA10D55);
const Color colorTransparent = Color(0xffffffff);
// Form Field Border Decoration
const Color enabledBorderColor = Colors.grey;
const Color focusedBorderColor = primaryColor;
const Color errorBorderColor = Color(0xfff72832);
const Color focusedErrorBorderColor = Color(0xffb5020b);
//Attendence cart
const Color presentColor = Color(0xff338915);
const Color leaveColor = Color(0xff11415C);
const Color absentColor = Color(0xffBB1A1A);
const Color holidayColor = Color(0xff1A9F97);

Color getColorAsRequisition({required String reqDocName}) {
  final Color color;
  switch (reqDocName) {
    case 'Leave Application':
      color = Colors.red.shade300;
      break;
    case 'General Product Store Requisition':
      color = Colors.purple.shade300;
      break;
    case 'ICT Product Store Requisition':
      color = Colors.green.shade300;
      break;
    case 'ICT Service Requisition':
      color = Colors.blue.shade400;
      break;
    default:
      color = Colors.blue.shade400;
      break;
  }
  return color;
}


