// import 'package:cripton_erp_flutter/app/core/extensions/context_extension.dart';
// import 'package:cripton_erp_flutter/app/core/widgets/gap/gap.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MultiSelectDropdown<T> extends StatefulWidget {
//   const MultiSelectDropdown({
//     super.key,
//     required this.items,
//     required this.itemLabel,
//     required this.onSelectionChanged,
//     this.initialSelectedItems,
//     this.hint,
//     this.title,
//     this.maxHeight = 250,
//     this.titleStyle,
//     this.hintStyle,
//     this.isRequired = false,
//     this.validationText,
//   });

//   /// List of all items
//   final List<T> items;

//   /// Function to get the display label of an item
//   final String Function(T item) itemLabel;

//   /// Callback when selection changes
//   final ValueChanged<List<T>> onSelectionChanged;

//   /// Initial selected items
//   final List<T>? initialSelectedItems;

//   /// Placeholder text when nothing is selected
//   final String? hint;

//   /// Optional title above the dropdown
//   final String? title;
//   final TextStyle? titleStyle;
//   final TextStyle? hintStyle;

//   /// Max height of the dropdown list
//   final double maxHeight;

//   /// Whether this field is required (shows a red asterisk)
//   final bool isRequired;

//   /// Text to show when validation fails
//   final String? validationText;

//   @override
//   State<MultiSelectDropdown<T>> createState() => MultiSelectDropdownState<T>();
// }

// class MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
//   late List<T> _selectedItems;
//   bool _showValidationError = false;

//   @override
//   void initState() {
//     super.initState();
//     _selectedItems =
//         widget.initialSelectedItems != null
//             ? List<T>.from(widget.initialSelectedItems!)
//             : [];
//   }

//   @override
//   void didUpdateWidget(covariant MultiSelectDropdown<T> oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // 👇 Update selected items when parent provides new initialSelectedItems
//     if (widget.initialSelectedItems != oldWidget.initialSelectedItems) {
//       setState(() {
//         _selectedItems =
//             widget.initialSelectedItems != null
//                 ? List<T>.from(widget.initialSelectedItems!)
//                 : [];
//       });
//     }
//   }

//   Future<void> _openMultiSelectModal() async {
//     final result = await showModalBottomSheet<List<T>>(
//       context: context,
//       isScrollControlled: true,
//       builder:
//           (context) => DraggableScrollableSheet(
//             initialChildSize: 0.8,
//             minChildSize: 0.4,
//             maxChildSize: 0.8,
//             expand: false,
//             builder:
//                 (context, scrollController) => _MultiSelectModalContent<T>(
//                   title: widget.title ?? 'Select Items',
//                   items: widget.items,
//                   itemLabel: widget.itemLabel,
//                   initialSelectedItems: _selectedItems,
//                 ),
//           ),
//     );

//     if (result != null) {
//       setState(() => _selectedItems = result);
//       widget.onSelectionChanged(result);
//     }
//   }

//   bool validate() {
//     final isValid = _selectedItems.isNotEmpty || !widget.isRequired;
//     setState(() => _showValidationError = !isValid);
//     return isValid;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (widget.title != null)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 6.0),
//             child: RichText(
//               text: TextSpan(
//                 text: widget.title!,
//                 style:
//                     widget.titleStyle ??
//                     Theme.of(context).textTheme.labelSmall?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                 children: [
//                   if (widget.isRequired)
//                     const TextSpan(
//                       text: ' *',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         GestureDetector(
//           onTap: _openMultiSelectModal,
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             decoration: BoxDecoration(
//               color: context.colorScheme.outlineVariant,
//               border: Border.all(
//                 color:
//                     _showValidationError
//                         ? Colors.red
//                         : context.colorScheme.outlineVariant,
//               ),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child:
//                       _selectedItems.isEmpty
//                           ? Text(
//                             widget.hint ??
//                                 (widget.isRequired ? 'Select *' : 'Select'),
//                             style:
//                                 widget.hintStyle ??
//                                 context.textTheme.bodyLarge?.copyWith(
//                                   color: context.colorScheme.outline,
//                                 ),
//                           )
//                           : Wrap(
//                             spacing: 8,
//                             runSpacing: 4,
//                             children:
//                                 _selectedItems
//                                     .map(
//                                       (item) => Chip(
//                                         label: Text(
//                                           widget.itemLabel(item),
//                                           style: context.textTheme.labelSmall
//                                               ?.copyWith(
//                                                 color:
//                                                     context.colorScheme.primary,
//                                               ),
//                                         ),
//                                         deleteIcon: const Icon(
//                                           Icons.clear,
//                                           size: 18,
//                                         ),
//                                         onDeleted: () {
//                                           setState(() {
//                                             _selectedItems.remove(item);
//                                             widget.onSelectionChanged(
//                                               _selectedItems,
//                                             );
//                                           });
//                                         },
//                                       ),
//                                     )
//                                     .toList(),
//                           ),
//                 ),
//                 const Icon(Icons.arrow_drop_down),
//               ],
//             ),
//           ),
//         ),
//         if (_showValidationError)
//           Padding(
//             padding: const EdgeInsets.only(top: 6.0, left: 4),
//             child: Text(
//               widget.validationText ?? 'This field is required',
//               style: const TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ),
//       ],
//     );
//   }
// }

// class _MultiSelectModalContent<T> extends StatefulWidget {
//   const _MultiSelectModalContent({
//     super.key,
//     required this.title,
//     required this.items,
//     required this.itemLabel,
//     required this.initialSelectedItems,
//   });

//   final String title;
//   final List<T> items;
//   final String Function(T item) itemLabel;
//   final List<T> initialSelectedItems;

//   @override
//   State<_MultiSelectModalContent<T>> createState() =>
//       _MultiSelectModalContentState<T>();
// }

// class _MultiSelectModalContentState<T>
//     extends State<_MultiSelectModalContent<T>> {
//   final _searchController = TextEditingController();
//   late List<T> _selectedItems;
//   List<T> _filteredItems = [];

//   @override
//   void initState() {
//     super.initState();
//     _selectedItems = List<T>.from(widget.initialSelectedItems);
//     _filteredItems = widget.items;
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredItems =
//           widget.items.where((item) {
//             return widget.itemLabel(item).toLowerCase().contains(query);
//           }).toList();
//     });
//   }

//   void _onItemTapped(T item) {
//     setState(() {
//       if (_selectedItems.contains(item)) {
//         _selectedItems.remove(item);
//       } else {
//         _selectedItems.add(item);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.title, style: context.textTheme.labelLarge),
//           const Gap(12),
//           TextField(
//             controller: _searchController,
//             decoration: const InputDecoration(
//               hintText: 'Search...',
//               prefixIcon: Icon(Icons.search),
//             ),
//           ),
//           const Gap(16),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredItems.length,
//               itemBuilder: (context, index) {
//                 final item = _filteredItems[index];
//                 final isSelected = _selectedItems.contains(item);
//                 return CheckboxListTile(
//                   title: Text(widget.itemLabel(item)),
//                   value: isSelected,
//                   onChanged: (_) => _onItemTapped(item),
//                 );
//               },
//             ),
//           ),
//           const Gap(12),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(_selectedItems),
//               child: const Text('Done'),
//             ),
//           ),
//           const Gap(24),
//         ],
//       ),
//     );
//   }
// }
