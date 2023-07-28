import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/texts/text_widget.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final int? maxLines;
  final int? minLines;
  final void Function()? onTap;
  final bool readOnly;

  const TextInputWidget({
    required this.controller,
    required this.focusNode,
    required this.label,
    this.validator,
    this.onFieldSubmitted,
    super.key,
    this.maxLines,
    this.minLines,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        label: TextWidget(label),
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(color: Colors.white),
        floatingLabelStyle: const TextStyle(color: Colors.white),
      ),
      textCapitalization: TextCapitalization.words,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      minLines: minLines,
      maxLines: maxLines,
      onTap: onTap,
      readOnly: readOnly,
    );
  }
}
