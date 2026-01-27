import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../config/app_assets.dart';
import '../utils/color.dart';

const OutlineInputBorder ENABLED_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: ENABLED_BORDER_COLOR),
);
const OutlineInputBorder FOCUSED_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: FOCUSED_BORDER_COLOR),
);
const OutlineInputBorder ERROR_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: ERROR_BORDER_COLOR),
);
const OutlineInputBorder FOCUSED_ERROR_BORDER = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: FOCUSED_ERROR_BORDER_COLOR),
);

class PrimaryDropdownSearch<T> extends StatelessWidget {
  const PrimaryDropdownSearch({
    super.key,
    required this.list,
    this.hint,
    this.validationText,
    required this.onChanged,
    this.selectedItem,
  });

  final Future<List<T>> list;
  final String? hint;
  final String? validationText;
  final void Function(T? object) onChanged;
  final T? selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      selectedItem: selectedItem,
      // dropdownSearchDecoration: InputDecoration(
      //   fillColor: Colors.white,
      //   filled: true,
      //   hintText: hint,
      //   contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      //   enabledBorder: ENABLED_BORDER,
      //   focusedBorder: FOCUSED_BORDER,
      //   errorBorder: ERROR_BORDER,
      //   focusedErrorBorder: FOCUSED_ERROR_BORDER,
      // ),
      popupProps: PopupProps.bottomSheet(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Search here',
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.indigo.withValues(alpha: 0.2),
          ),
        ),
      ),
      dropdownBuilder: (context, t) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(t.toString()),
        );
      },
      // asyncItems: (String filter) => list,
      itemAsString: (T u) => u.toString(),
      onChanged: onChanged,
      validator: (T? item) {
        if (item == null) {
          return validationText;
        } else {
          return null;
        }
      },
    );
  }
}

class SecondaryDropdownSearch<T> extends StatelessWidget {
  const SecondaryDropdownSearch({
    super.key,
    required this.list,
    this.hint,
    this.validationText,
    required this.onChanged,
    this.selectedItem,
  });

  final List<T> list;
  final String? hint;
  final String? validationText;
  final void Function(T? object) onChanged;
  final T? selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      selectedItem: selectedItem,
      // dropdownDecoratorProps: DropDownDecoratorProps(
      //   dropdownSearchDecoration: InputDecoration(
      //     hintText: hint,
      //     fillColor: Colors.white,
      //     filled: true,
      //     contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      //     enabledBorder: ENABLED_BORDER,
      //     focusedBorder: FOCUSED_BORDER,
      //     errorBorder: ERROR_BORDER,
      //     focusedErrorBorder: FOCUSED_ERROR_BORDER,
      //   ),
      // ),
      popupProps: PopupProps.bottomSheet(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            hintText: 'Search here',
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.indigo.withValues(alpha: 0.2),
          ),
        ),
      ),
      // items: list,
      itemAsString: (T u) => u.toString(),
      onChanged: onChanged,
      validator: (T? item) {
        if (item == null) {
          return validationText;
        } else {
          return null;
        }
      },
    );
  }
}

class PaginatedSearchableDropDown<T> extends StatelessWidget {
  final Future<List<SearchableDropdownMenuItem<T>>?> Function(int, String?)?
  paginatedRequest;
  final void Function(T?)? onChanged;
  final String? hintText;

  const PaginatedSearchableDropDown({
    super.key,
    this.hintText,
    this.paginatedRequest,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SearchableDropdown<T>.paginated(
      trailingIcon: Icon(Icons.arrow_drop_down),
      hintText: Text(
        hintText ?? '',
        style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
      ),
      margin: const EdgeInsets.only(right: 15, top: 15, bottom: 15, left: 3),
      paginatedRequest: paginatedRequest,
      onChanged: onChanged,
      backgroundDecoration: (widget) {
        return Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: widget,
        );
      },
    );
  }
}
