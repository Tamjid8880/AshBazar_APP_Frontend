import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final T? initialValue;
  final Color? bgColor;
  final List<T> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String hintText;
  final String Function(T) displayItem;

  const CustomDropdown({
    super.key,
    this.initialValue,
    required this.items,
    required this.onChanged,
    this.validator,
    this.hintText = 'Select an option',
    required this.displayItem,
    this.bgColor,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late final ValueNotifier<T?> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<T?>(widget.initialValue);
  }

  @override
  void didUpdateWidget(CustomDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _valueNotifier.value = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<T>(
            isExpanded: true,
            hint: Text(
              widget.hintText,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: widget.items.map((T value) {
              return DropdownItem<T>(
                value: value,
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(widget.displayItem(value),
                      style: const TextStyle(fontSize: 14)),
                ),
              );
            }).toList(),
            valueListenable: _valueNotifier,
            onChanged: (T? newValue) {
              _valueNotifier.value = newValue;
              widget.onChanged(newValue);
            },
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.only(left: 16, right: 8),
              height: 50,
              decoration: BoxDecoration(
                color: widget.bgColor ?? Colors.grey[200],
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}
