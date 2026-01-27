import '../../extensions/context_extension.dart';
import '../gap/gap.dart';
import '../texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextFormField extends StatelessWidget {
  /// Whether the text field should be read-only (non-editable).
  /// Defaults to `false`.
  final bool readOnly;

  /// The initial value to display when the field is first built.
  /// Only used when [textController] is not provided.
  final String? initialValue;

  /// The [TextEditingController] that controls the value of the text field.
  /// If provided, [initialValue] will be ignored.
  final TextEditingController? textController;

  /// Optional list of [TextInputFormatter] to control or restrict
  /// the format of user input (e.g., digits only, uppercase).
  final List<TextInputFormatter>? inputFormatters;

  /// The action button on the keyboard (e.g., `next`, `done`).
  final TextInputAction? inputAction;

  /// The type of keyboard to use for the text field
  /// (e.g., text, number, email). Defaults to [TextInputType.text].
  final TextInputType inputType;

  /// The focus node for controlling the focus state of the field.
  /// Useful for moving focus between fields programmatically.
  final FocusNode? focusNode;

  /// A synchronous validation function.
  /// Returns an error string if validation fails, or `null` if valid.
  final String? Function(String?)? validator;

  /// Called whenever the field’s value changes.
  final void Function(String)? onChanged;

  /// Called when the field is tapped.
  /// Useful for showing custom pickers or date pickers in read-only fields.
  final void Function()? onTap;

  /// The maximum number of lines for the text input.
  /// Defaults to 1 (single-line text field).
  final int maxLines;

  /// The label text for this field.
  /// If [isTopLabel] is `true`, it will be shown above the field.
  /// Otherwise, it will appear as a floating label inside the field.
  final String labelText;

  /// The placeholder text shown when the field is empty.
  final String? hintText;

  /// An optional widget displayed before the editable part of the text field.
  /// Commonly an [Icon] indicating the type of input.
  final Widget? prefixIcon;

  /// An optional widget displayed after the editable part of the text field.
  /// Commonly used for clear buttons, password toggles, etc.
  final Widget? suffixIcon;

  /// Whether to display a red asterisk (*) to indicate
  /// that this field is required. Defaults to `false`.
  final bool isRequired;

  /// Whether to show the label as a top label above the text field.
  /// Defaults to `false`, which means the label will be inside the field.
  final bool isTopLabel;

  const PrimaryTextFormField({
    super.key,
    this.readOnly = false,
    this.focusNode,
    this.hintText,
    this.initialValue,
    this.inputAction,
    this.inputFormatters,
    this.inputType = TextInputType.text,
    this.maxLines = 1,
    this.isRequired = false,
    this.isTopLabel = false,
    this.prefixIcon,
    this.suffixIcon,
    this.textController,
    this.validator,
    this.onChanged,
    this.onTap,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: isTopLabel,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isRequired
                  ? RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: labelText,
                          style: context.themeData.textTheme.labelLarge,
                        ),
                        TextSpan(
                          text: ' ',
                          style: context.themeData.textTheme.labelLarge,
                        ),
                        TextSpan(
                          text: '*',
                          style: context.themeData.textTheme.labelLarge
                              ?.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  )
                  : CustomText(
                    text: labelText,
                    textStyle: context.themeData.textTheme.labelLarge,
                  ),
              const Gap(12),
            ],
          ),
        ),
        TextFormField(
          readOnly: readOnly,
          initialValue: initialValue,
          controller: textController,
          inputFormatters: inputFormatters,
          textInputAction: inputAction,
          keyboardType: inputType,
          focusNode: focusNode,
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: isTopLabel || labelText == '' ? null : labelText,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

class AuthTextFormField extends StatefulWidget {
  /// Controls the text being edited.
  /// Use this to read or modify the current value of the field.
  final TextEditingController? textController;

  /// The initial text value to display if no controller is provided.
  final String? initialValue;

  /// Defines the focus behavior of this text field.
  /// Useful for moving focus between fields on form navigation.
  final FocusNode? focusNode;

  /// Determines the type of keyboard to show (e.g., text, number, email).
  final TextInputType inputType;

  /// Defines the action button on the soft keyboard (e.g., next, done).
  final TextInputAction? inputAction;

  /// If `true`, the field will hide the text (useful for passwords).
  final bool isPassword;

  /// A validation function that returns an error string if input is invalid.
  /// Return `null` if the value is valid.
  final String? Function(String?)? validator;

  /// The label text for this field.
  /// If [isTopLabel] is `true`, it will be displayed above the field.
  /// Otherwise, it will be shown inside the field as a floating label.
  final String labelText;

  /// A placeholder text that appears inside the field when it is empty.
  final String? hintText;

  /// An optional icon to display before the input text.
  /// Usually used to indicate the type of input (e.g., email, phone).
  final IconData? prefixIcon;

  /// If `true`, the label will appear above the text field
  /// instead of inside it as a floating label.
  final bool isTopLabel;

  const AuthTextFormField({
    super.key,
    this.textController,
    this.initialValue,
    this.focusNode,
    this.inputType = TextInputType.text,
    this.inputAction,
    this.isPassword = false,
    this.validator,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.isTopLabel = false,
  });

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.isTopLabel,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: widget.labelText,
                textStyle: context.themeData.textTheme.labelLarge,
              ),
              const Gap(12),
            ],
          ),
        ),
        TextFormField(
          controller: widget.textController,
          initialValue: widget.initialValue,
          focusNode: widget.focusNode,
          keyboardType: widget.inputType,
          obscureText: widget.isPassword ? _obscureText : false,
          validator: widget.validator,
          decoration: InputDecoration(
            labelText: widget.isTopLabel ? null : widget.labelText,
            hintText: widget.hintText,
            prefixIcon:
                widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon:
                          _obscureText
                              ? const Icon(Icons.visibility_off, size: 20)
                              : const Icon(Icons.visibility, size: 20),
                    )
                    : null,
          ),
        ),
      ],
    );
  }
}
