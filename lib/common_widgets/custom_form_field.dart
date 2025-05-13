import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool isRequired;
  final TextInputType keyboardType;
  final int? maxLines;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    required this.label,
    this.hint,
    required this.controller,
    this.isRequired = true,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.obscureText = false,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: suffix,
        ),
        validator: validator ?? (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return '\$label is required';
          }
          return null;
        },
      ),
    );
  }
} 