import 'package:flutter/material.dart';

const Color PRIMARY_SWATCH = Colors.indigo;
const Color PRIMARY_COLOR = Color(0xff192D6B);
const Color PRIMARY_LIGHT_COLOR = Color(0xffC5CAE9);
const Color INDIGO_50 = Color(0xffE8EAF6);
const Color BACKGROUND_COLOR = Color(0xffECF0F1);
const Color COLOR_PEST = Color(0xff21CBC1);
const Color COLOR_BROWN = Color(0xffE27108);
const Color COLOR_PURPLE = Color(0xffA10D55);
const Color COLOR_TRANSPARENT = Color(0xffffffff);
// Form Field Border Decoration
const Color ENABLED_BORDER_COLOR = Colors.grey;
const Color FOCUSED_BORDER_COLOR = PRIMARY_COLOR;
const Color ERROR_BORDER_COLOR = Color(0xfff72832);
const Color FOCUSED_ERROR_BORDER_COLOR = Color(0xffb5020b);
//Attendence cart
const Color PRESENT_COLOR = Color(0xff338915);
const Color LEAVE_COLOR = Color(0xff11415C);
const Color ABSENT_COLOR = Color(0xffBB1A1A);
const Color HOLIDAY_COLOR = Color(0xff1A9F97);

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


