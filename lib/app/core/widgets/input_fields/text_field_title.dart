import 'package:flutter/services.dart';

import '../../extensions/context_extension.dart';
import '../gap/gap.dart';
import 'text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class TextFieldTitleWidget extends StatelessWidget {
  final String? label;
  final int maxLines;
  final int? maxLength;
  final IconData? icon;
  final TextEditingController controller;
  final String hint;
  final bool readOnly;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? suffixIconColor;
  final Color? prefixIconColor;
  final String? validationText;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validator;

  const TextFieldTitleWidget({
    super.key,
    this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.maxLength,
    this.icon,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconColor,
    this.prefixIconColor,
    this.validationText,
    this.isRequired = false,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            icon != null
                ? Icon(icon, size: 20, color: context.colorScheme.primary)
                : const SizedBox.shrink(),
            (label?.isNotEmpty ?? false)
                ? RichText(
                  text: TextSpan(
                    text: label ?? '',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                    children:
                        isRequired
                            ? [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]
                            : [],
                  ),
                )
                : const SizedBox.shrink(),
          ],
        ),
        const Gap(5),
        PrimaryTextFormField(
          controller: controller,
          readOnly: readOnly,
          validator: validator,
          maxLines: maxLines,
          validationText: validationText,
          inputFormatters: inputFormatters,
          onTap: onTap,
          maxLength: maxLength,
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,

            filled: true,
            fillColor: context.colorScheme.outlineVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: context.colorScheme.outlineVariant,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colorScheme.outlineVariant,
                width: 2,
              ),
            ),
            suffixIcon: suffixIcon,
            suffixIconColor: suffixIconColor,
            prefixIcon: prefixIcon,
            prefixIconColor: prefixIconColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: context.colorScheme.outlineVariant,
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
