import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/color.dart';

const OutlineInputBorder ENABLED_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: enabledBorderColor),
);
const OutlineInputBorder FOCUSED_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: focusedBorderColor),
);
const OutlineInputBorder ERROR_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: errorBorderColor),
);
const OutlineInputBorder FOCUSED_ERROR_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: focusedErrorBorderColor),
);

class LoginTextFormField extends StatelessWidget {
  const LoginTextFormField({
    super.key,
    this.label,
    this.validationText,
    this.controller,
    this.suffixIconButton,
    this.prefixIcon,
    this.prefixIconColor,
    required this.obscureText,
    this.focusNode,
    this.fillColor,
  });

  final String? label;
  final String? validationText;
  final TextEditingController? controller;
  final IconButton? suffixIconButton;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final bool obscureText;
  final FocusNode? focusNode;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: fillColor != null,
        prefixIcon: Icon(prefixIcon, color: prefixIconColor),
        suffixIcon: suffixIconButton,
        label: Text(label ?? ''),
        // contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        enabledBorder: ENABLED_BORDER,
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_ERROR_BORDER,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validationText;
        } else {
          return null;
        }
      },
    );
  }
}

class PrimaryTextFormField extends StatelessWidget {
  const PrimaryTextFormField({
    super.key,
    this.label,
    this.validationText,
    this.hintText,
    this.controller,
    this.suffixIcon,
    this.suffixIconColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.focusNode,
    this.inputType,
    this.inputFormatters,
    this.onTap,
    this.decoration,
    this.readOnly = false,
    this.textStyle,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.suffixIconSize,
    this.contentPadding,
  });

  final String? label;
  final TextStyle? textStyle;
  final InputDecoration? decoration;
  final String? validationText;
  final String? hintText;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final void Function()? onTap;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? maxLength;
  final String? Function(String? value)? validator;
  final double? suffixIconSize;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      onTap: onTap,
      keyboardType: inputType,
      maxLines: maxLines,
      readOnly: readOnly,
      style: textStyle,
      maxLength: maxLength,
      decoration:
          decoration ??
          InputDecoration(
            labelText: label ?? '',
            labelStyle: const TextStyle(fontSize: 13),
            hintText: hintText,
            contentPadding: contentPadding,
            prefixIcon:
                prefixIcon == null
                    ? null
                    : Icon(prefixIcon, color: prefixIconColor),
            suffixIcon:
                suffixIcon != null
                    ? Icon(
                      suffixIcon,
                      color: suffixIconColor,
                      size: suffixIconSize ?? 12,
                    )
                    : null,
            enabledBorder: ENABLED_BORDER,
            focusedBorder: FOCUSED_BORDER,
            errorBorder: ERROR_BORDER,
            focusedErrorBorder: FOCUSED_ERROR_BORDER,
          ),
      validator:
          validator ??
          (value) {
            if (value!.isEmpty) {
              return validationText;
            } else {
              return null;
            }
          },
    );
  }
}

class SecondaryTextFormField extends StatelessWidget {
  const SecondaryTextFormField({
    super.key,
    this.label,
    this.validationText,
    this.controller,
    this.suffixIcon,
    this.suffixIconColor,
    this.maxLines,
    this.hint,
    this.focusNode,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.onChanged,
  });
  final String? label;
  final String? hint;
  final String? validationText;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      maxLines: maxLines,
      magnifierConfiguration: const TextMagnifierConfiguration(),
      decoration: InputDecoration(
        // fillColor: Theme.of(context).colorScheme.onPrimaryContainer,
        filled: true,
        hintText: hint,
        suffixIcon: Icon(suffixIcon, color: suffixIconColor),
        label: Text(label ?? ''),
        // contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        enabledBorder: ENABLED_BORDER,
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_ERROR_BORDER,
      ),
      validator:
          validator ??
          (value) {
            if (value!.isEmpty) {
              return validationText;
            } else {
              return null;
            }
          },
    );
  }
}

////////////////////////////////////////////////////////////////////////////

class ClickableTextFormField extends StatelessWidget {
  const ClickableTextFormField({
    super.key,
    this.label,
    this.validationText,
    this.controller,
    this.suffixIcon,
    this.suffixIconColor,
    this.maxLines,
    this.hints,
    this.onIconTap,
    this.inputFormatters,
  });
  final String? label;
  final String? validationText;
  final String? hints;
  final VoidCallback? onIconTap;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      onTap: onIconTap,
      canRequestFocus: false,
      inputFormatters: inputFormatters,
      magnifierConfiguration: const TextMagnifierConfiguration(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hints,
        suffixIcon: InkWell(
          onTap: onIconTap,
          child: Icon(suffixIcon, color: suffixIconColor),
        ),
        label: Text(label ?? ''),
        // contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        enabledBorder: ENABLED_BORDER,
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_ERROR_BORDER,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validationText;
        } else {
          return null;
        }
      },
    );
  }
}
