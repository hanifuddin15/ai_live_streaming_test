import '../../extensions/context_extension.dart';
import 'text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class TimeFieldWidget extends StatelessWidget {
  final String label;
  final String validationText;
  final TextEditingController controller;
  final bool isRequired;
  final String? Function(String? value)? validator;
  final Widget Function(BuildContext, Widget?)? builder;

  const TimeFieldWidget({
    super.key,
    required this.label,
    this.validationText = '',
    required this.controller,
    this.isRequired = false,
    this.validator,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 6,
          children: [
            Icon(Icons.schedule, size: 20, color: context.colorScheme.primary),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: label,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colorScheme.primary,
                    ),
                  ),
                  if (isRequired)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        PrimaryTextFormField(
          controller: controller,
          validationText: validationText,
          validator: validator,
          readOnly: true,
          onTap: () async {
            final TimeOfDay? selectedTime = await showTimePickerDialog(
              context,
              builder: builder,
            );
            if (selectedTime != null) {
              // ignore: use_build_context_synchronously
              controller.text = selectedTime.format(context);
            }
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 12.0,
            ),
            isDense: true,
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
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: context.colorScheme.outlineVariant,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: context.colorScheme.error,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: context.colorScheme.error,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: context.colorScheme.outlineVariant,
                width: 2,
              ),
            ),
            suffixIcon: Icon(
              Icons.schedule,
              color: context.colorScheme.primary,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

Future<TimeOfDay?> showTimePickerDialog(
  BuildContext context, {
  Widget Function(BuildContext, Widget?)? builder,
}) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: builder,
  );
  return pickedTime;
}
