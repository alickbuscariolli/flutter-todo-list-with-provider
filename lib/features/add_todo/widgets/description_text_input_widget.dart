import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/inputs/text_input_widget.dart';

class DescriptionTextInputWidget extends StatelessWidget {
  final TextEditingController descriptionTEC;
  final FocusNode descriptionFN;

  const DescriptionTextInputWidget({
    required this.descriptionTEC,
    required this.descriptionFN,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      controller: descriptionTEC,
      focusNode: descriptionFN,
      label: 'Descrição',
      minLines: 4,
      maxLines: 6,
    );
  }
}
