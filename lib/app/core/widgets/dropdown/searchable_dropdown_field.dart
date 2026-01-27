// import 'package:flutter/material.dart';

// import '../../extensions/context_extension.dart';
// import '../../theme/color/app_colors.dart';
// import '../gap/gap.dart';
// import '../input_fields/primary_text_form_field.dart';

// class SearchableDropdownField<T> extends StatefulWidget {
//   final String title;

//   /// Optional static list of items.
//   /// If provided, the dropdown will use these items directly.
//   final List<T>? items;

//   /// Optional async function to fetch items.
//   /// Used for dynamic or server-side data.
//   /// Receives an optional `searchKey` to filter results.
//   final Future<List<T>> Function(String? searchKey)? asyncItems;

//   /// Converts an item of type T into a String to display in the list.
//   final String Function(T) itemAsString;

//   /// Callback when an item is selected.
//   /// Returns the selected item (or null if cleared).
//   final void Function(T?) onChanged;

//   /// Initially selected item.
//   final T? selectedItem;

//   /// Hint text shown when no item is selected.
//   final String hintText;

//   /// Validation function. Returns null if valid, otherwise error string.
//   final String? Function(T?)? validator;

//   /// A reusable searchable dropdown widget that supports both
//   /// static and async items, with a draggable modal and rotating arrow.
//   /// Constructor ensures that either `items` or `asyncItems` must be provided.
//   const SearchableDropdownField({
//     super.key,
//     required this.title,
//     this.items,
//     this.asyncItems,
//     required this.itemAsString,
//     required this.onChanged,
//     this.selectedItem,
//     this.hintText = 'Select an item',
//     this.validator,
//   }) : assert(
//          items != null || asyncItems != null,
//          'Either items or asyncItems must be provided.',
//        );

//   @override
//   State<SearchableDropdownField<T>> createState() =>
//       _SearchableDropdownFieldState<T>();
// }

// class _SearchableDropdownFieldState<T> extends State<SearchableDropdownField<T>>
//     with SingleTickerProviderStateMixin {
//   T? selectedItem;
//   bool isOpen = false;
//   late AnimationController _arrowController;
//   String? errorText;

//   @override
//   void initState() {
//     super.initState();
//     selectedItem = widget.selectedItem;
//     _arrowController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200),
//       upperBound: 0.5, // half rotation = 180°
//     );
//   }

//   @override
//   void dispose() {
//     _arrowController.dispose();
//     super.dispose();
//   }

//   Future<void> _openSearchableModal() async {
//     setState(() => isOpen = true);
//     _arrowController.forward();

//     final T? result = await showModalBottomSheet<T>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       builder:
//           (context) => DraggableScrollableSheet(
//             initialChildSize: 0.5,
//             minChildSize: 0.3,
//             maxChildSize: 0.9,
//             expand: false,
//             builder:
//                 (context, scrollController) => Container(
//                   padding: const EdgeInsetsDirectional.symmetric(
//                     vertical: 12,
//                     horizontal: 16,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.surface,
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(16),
//                     ),
//                   ),
//                   child: SearchableModalContent<T>(
//                     title: widget.title,
//                     items: widget.items,
//                     asyncItems: widget.asyncItems,
//                     itemAsString: widget.itemAsString,
//                     scrollController: scrollController,
//                   ),
//                 ),
//           ),
//     );

//     if (result != null) {
//       setState(() {
//         selectedItem = result;
//         errorText = widget.validator?.call(result);
//       });
//       widget.onChanged(result);
//     }

//     setState(() => isOpen = false);
//     _arrowController.reverse();
//   }

//   /// Validate the current value manually
//   bool validate() {
//     final result = widget.validator?.call(selectedItem);
//     setState(() => errorText = result);
//     return result == null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: _openSearchableModal,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color:
//                     isOpen
//                         ? context.colorScheme.primary
//                         : context.colorScheme.outline,
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     selectedItem != null
//                         ? widget.itemAsString(selectedItem as T)
//                         : widget.hintText,
//                     style: context.themeData.textTheme.labelMedium?.copyWith(
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 RotationTransition(
//                   turns: _arrowController,
//                   child: Icon(Icons.expand_more, color: Colors.grey[700]),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if (errorText != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 4, left: 12),
//             child: Text(
//               errorText!,
//               style: context.themeData.textTheme.bodyMedium?.copyWith(
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.RED_COLOR,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// class SearchableModalContent<T> extends StatefulWidget {
//   final String title;
//   final List<T>? items;
//   final Future<List<T>> Function(String? searchKey)? asyncItems;
//   final String Function(T) itemAsString;
//   final ScrollController scrollController;

//   const SearchableModalContent({
//     super.key,
//     required this.title,
//     this.items,
//     this.asyncItems,
//     required this.itemAsString,
//     required this.scrollController,
//   });

//   @override
//   State<SearchableModalContent<T>> createState() =>
//       _SearchableModalContentState<T>();
// }

// class _SearchableModalContentState<T> extends State<SearchableModalContent<T>> {
//   TextEditingController searchController = TextEditingController();
//   List<T> items = [];
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadItems();

//     searchController.addListener(() {
//       _loadItems(searchKey: searchController.text);
//     });
//   }

//   Future<void> _loadItems({String? searchKey}) async {
//     setState(() => isLoading = true);

//     List<T> list = [];
//     if (widget.asyncItems != null) {
//       list = await widget.asyncItems!(searchKey);
//     } else if (widget.items != null) {
//       list = widget.items!;
//       if (searchKey != null && searchKey.isNotEmpty) {
//         list =
//             list
//                 .where(
//                   (e) => widget
//                       .itemAsString(e)
//                       .toLowerCase()
//                       .contains(searchKey.toLowerCase()),
//                 )
//                 .toList();
//       }
//     }

//     setState(() {
//       items = list;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.title, style: context.themeData.textTheme.labelLarge),
//         const Gap(12),

//         PrimaryTextFormField(
//           labelText: '',
//           textController: searchController,
//           hintText: 'Search...',
//           prefixIcon: const Icon(Icons.search),
//         ),
//         const Gap(16),
//         Expanded(
//           child:
//               isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : ListView.separated(
//                     controller: widget.scrollController,
//                     itemCount: items.length,
//                     separatorBuilder:
//                         (context, index) =>
//                             const Gap(12, direction: Axis.vertical),
//                     itemBuilder: (context, index) {
//                       final item = items[index];
//                       return InkWell(
//                         child: Padding(
//                           padding: const EdgeInsetsDirectional.symmetric(
//                             vertical: 4,
//                           ),
//                           child: Text(
//                             widget.itemAsString(item),
//                             style: context.themeData.textTheme.bodyLarge,
//                           ),
//                         ),
//                         onTap: () => Navigator.pop(context, item),
//                       );
//                     },
//                   ),
//         ),
//       ],
//     );
//   }
// }
