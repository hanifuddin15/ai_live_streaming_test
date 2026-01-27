import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// ignore: non_constant_identifier_names
PopupMenuItem PrimaryPopupMenuItem({
  required final VoidCallback onTap,
  required final IconData iconData,
  Rx<int>? badgeCount,
  Color? iconColor,
  required String title,
}) {
  return PopupMenuItem(
    onTap: onTap,
    child: Row(
      children: [
        badgeCount == null
            ? Icon(
                iconData,
                size: 28,
                color: iconColor ?? Colors.white,
              )
            : badges.Badge(
                badgeContent: Obx(
                  () => Text(
                    '${badgeCount.value}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                child: Icon(
                  iconData,
                  size: 28,
                  color: iconColor ?? Colors.white,
                ),
              ),
        const SizedBox(width: 20),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}
