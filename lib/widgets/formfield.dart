import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final String label;
  final TextInputType textInputType;
  final TextEditingController controller;

  const FormTextField({
    super.key,
    required this.label,
    required this.textInputType,
    required this.controller,
  });

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: widget.controller,
        autocorrect: true,
        keyboardType: widget.textInputType,
        maxLines: widget.textInputType == TextInputType.multiline ? null : 1,
        decoration: InputDecoration(
          prefixIcon: widget.textInputType == TextInputType.number
              ? const Icon(Icons.currency_rupee)
              : null,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: widget.label,
        ),
      ),
    );
  }
}
