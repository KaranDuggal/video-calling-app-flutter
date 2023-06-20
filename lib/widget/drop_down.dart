import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  const DropDown({super.key,required this.label, required this.hintText, this.value = '', required this.items, this.validator, required this.onChanged});
  final String label;
  final String hintText;
  final String value;
  final List<DropdownMenuItem<String>> items;
  final String? Function(String?) ? validator;
  final Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      isExpanded: true,
      decoration: InputDecoration( 
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(),
        ),
      ),
      style: Theme.of(context).textTheme.displaySmall,
      items: items,
      validator: validator,
      onChanged: onChanged,
    );
  }
}