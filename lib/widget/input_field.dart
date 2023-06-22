import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({super.key,required this.label, required this.hintText, this.controller, this.validator, this.onChanged, this.onTap, this.readOnly = false });
  final String label;
  final String hintText;
  final bool readOnly;
  final TextEditingController ? controller;
  final String? Function(String?) ? validator;
  final Function(String) ? onChanged;
  final Function() ? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium,
      controller: controller,
      readOnly: readOnly,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}