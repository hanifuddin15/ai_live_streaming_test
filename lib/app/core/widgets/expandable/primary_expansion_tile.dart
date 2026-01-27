import '../../extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryExpansionTile extends StatefulWidget {
  const PrimaryExpansionTile({
    super.key,
    required this.label,
    this.leadingIcon,
    required this.onTap,
    required this.children,
    required this.isExpanded, // Keep for initial value
    this.trailingIcon,
    this.backgroundColor,
    this.textStyle,
    this.collapsedBackgroundColor,
    this.borderColor = Colors.red,
  });

  final String label;
  final String? leadingIcon;
  final Widget? trailingIcon;
  final void Function() onTap;
  final List<Widget> children;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final TextStyle? textStyle;
  final Color borderColor;
  final bool isExpanded;

  @override
  State<PrimaryExpansionTile> createState() => _PrimaryExpansionTileState();
}

class _PrimaryExpansionTileState extends State<PrimaryExpansionTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded; // use initial external value
  }

  void _toggleExpansion() {
    setState(() => _isExpanded = !_isExpanded);
    widget.onTap(); // still call user callback
  }

  @override
  void didUpdateWidget(covariant PrimaryExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      _isExpanded = widget.isExpanded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with border
        GestureDetector(
          onTap: _toggleExpansion,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: widget.borderColor),
                color:
                    _isExpanded
                        ? (widget.backgroundColor ??
                            context.colorScheme.onPrimary)
                        : (widget.collapsedBackgroundColor ??
                            context.colorScheme.onPrimary),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  if (widget.leadingIcon != null)
                    SvgPicture.asset(
                      widget.leadingIcon!,
                      height: 24,
                      width: 24,
                    ),
                  if (widget.leadingIcon != null) const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.label,
                      style:
                          widget.textStyle ??
                          context.themeData.textTheme.labelLarge?.copyWith(
                            color: context.colorScheme.primary,
                          ),
                    ),
                  ),
                  widget.trailingIcon ??
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down_outlined,
                        color: context.colorScheme.primary,
                      ),
                ],
              ),
            ),
          ),
        ),

        // Expanded content section
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:
                      widget.backgroundColor ?? context.colorScheme.onPrimary,
                  border: Border.all(color: widget.borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: widget.children),
                ),
              ),
            ),
          ),
          crossFadeState:
              _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
