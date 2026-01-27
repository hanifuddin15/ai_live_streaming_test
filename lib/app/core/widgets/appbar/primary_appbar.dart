import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The main title text to display in the center or start of the AppBar.
  final String title;

  /// Whether to center the title text. Defaults to `false`.
  final bool centerTitle;

  /// Whether to show a back arrow button that pops the current route.
  /// Defaults to `false`.
  final bool showBackButton;

  /// A list of widgets to display on the right side of the AppBar.
  /// Commonly used for action buttons.
  final List<Widget>? actions;

  /// Optional widget to display before the title instead of the default back button.
  final Widget? leading;

  /// The spacing around [title] content on the horizontal axis
  final double titleSpacing;

  /// The text style [titleTextStyle] for the title
  final TextStyle? titleTextStyle;

  const PrimaryAppBar({
    super.key,
    required this.title,
    this.centerTitle = false,
    this.showBackButton = false,
    this.actions,
    this.leading,
    this.titleSpacing = 0,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      leading:
          leading ??
          (showBackButton
              ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).maybePop(),
              )
              : null),
      title: Text(title, style: titleTextStyle),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
